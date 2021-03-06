import logging
import atexit
from dateutil.relativedelta import relativedelta
from telegram_api import TelegramApi
from datetime import datetime


class PersonalReminderBot:
    def __init__(self, config):
        self.telegram_api = TelegramApi(config['TELEGRAM_URL'], config['CERTIFICATE'])
        self.webhook_url = config['WEBHOOK_URL']
        self.reminder_text = config['DEFAULT_REMINDER_TEXT']
        self.message_types = config['DEFAULT_MESSAGE_TYPES']
        self.delay = config['DEFAULT_REMINDER_DELAY']

    def set_webhook(self):
        logging.info("Starting the app")
        telegram_api = self.telegram_api
        telegram_api.set_webhook(self.webhook_url)

        def stop_bot():
            logging.info("Stopping the app")
            telegram_api.reset_webhook()

        atexit.register(stop_bot)

    def handle_update(self, update):
        if 'message' in update:
            from tasks import detect_datetime, remind
            message = update['message']
            chat_id = message['chat']['id']
            if 'text' in message:
                predicted_due = detect_datetime.apply_async(args=[message['text'], self.delay], queue='nlp').wait()
                if predicted_due < datetime.utcnow():
                    due = datetime.utcnow() + relativedelta(microseconds=self.delay)
                else:
                    due = predicted_due
            else:
                due = datetime.utcnow() + relativedelta(microseconds=self.delay)
            for send_type in self.message_types:
                if send_type in message:
                    if send_type == 'text':
                        content = message['text']
                    elif send_type == 'photo':
                        content = message['photo'][0]['file_id']
                    else:
                        content = message[send_type]['file_id']
                    remind.apply_async(args=[chat_id, send_type, content], eta=due, queue='reminders')
                    self.telegram_api.send_message(chat_id, 'Ok! You will be reminded at ' + (due + relativedelta(hours=3)).strftime("%Y-%m-%d %H:%M:%S"))
                    break
        return "Got the message"
