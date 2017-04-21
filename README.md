# Personal Reminder Bot
A simple Telegram bot you could send all your notes to. When you give him an input he will remind you about them later.

Right now this bot is able to:

1. Resend your notes to your in time you specified in your note in arbitary format (like "remind me tomorrow" or "send me this note in 1 hour, 30 minutes". If date and time are not specified, the bot will remind you in the default time (one day).

2. Resend your photos, audios, documents, voice messages and videos in default time (one day).

The bot is written in Python 2.7, it uses Flask, celery and rabbitmq. It's still under development, other features and documentation are coming soon.

You are welcome to visit the bot [here](http://telegram.me/PersonalReminderBot)

This project is licensed under the terms of the MIT license.

# Personal Reminder Bot v2.0
### These scripts allow you to rise up your personal bot reminder on any Hardware.
## :wine_glass: Maximize your *free* time!
First of all, clone or download this repo to your machine. 
```sh
$ git clone https://github.com/AlexWorldD/PersonalReminderBot
```
Then, your should decide which type of machine you'd like to create: RabbitMQ server or just a Worker. For Worker you should use MakeWorker script:
```sh
$ chmod +x MakeWorkerl.sh
```

And finally, Run script, which'll build a Worker from your machine!
```sh
$ ./MakeWorkerl.sh
```
And amazing FromZero2Hero for RabbitMQ installation and configuration.
```sh
$ chmod +x FromZero2Hero.sh
$ ./FromZero2Hero.sh
```
<hr>

## :alien: Manual:
* Delayed...
