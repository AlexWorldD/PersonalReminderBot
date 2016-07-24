from flask import Flask

import atexit
import telegram_api

app = Flask(__name__)
app.config.from_pyfile('default_config.py')
app.config.from_envvar('PERSONALREMINDERBOT_SETTINGS', silent=True)

if app.debug is not True:
    import logging.config
    logging.config.dictConfig(app.config['LOG_SETTINGS'])

telegram_api.set_webhook(app.config['TELEGRAM_URL'], app.config['WEBHOOK_URL'], app.config['CERTIFICATE'])
atexit.register(telegram_api.reset_webhook, telegram_url=app.config['TELEGRAM_URL'],
                certificate=app.config['CERTIFICATE'])

if __name__ == '__main__':
    app.run()
