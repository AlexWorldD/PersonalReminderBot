from flask import Flask, request
from utils import start_app
import logging

app = Flask(__name__)
app.config.from_pyfile('default_config.py')
app.config.from_envvar('PERSONALREMINDERBOT_SETTINGS', silent=True)

if app.debug is not True:
    from utils import initialize_logging
    # app.logger is called in order to load default flask logger name
    app.logger
    initialize_logging(app.config)

start_app(app.config)


@app.route('/webhook/' + app.config['BOT_TOKEN'], methods=['POST'])
def webhook_handler():
    if request.method == "POST":
        logging.info("Got the message.\nHeaders:\n%sData:\n%s\n" % (request.headers, request.data))
    return "Got the message"

if __name__ == '__main__':
    app.run()
