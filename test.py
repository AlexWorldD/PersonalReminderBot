from celery import Celery

app = Celery('tasks', backend='amqp',
             broker='amqp://worker:w@147.75.102.241/vhost')
@app.task
def add(x, y):
    return x + y

# task.detect_datetime.delay('28.04.2017', 5).get()
# task.remind.delay(t)