FROM python:3.5

ENV APP_PATH /srv/app/mysite

RUN mkdir -p /srv/app
COPY requirements.base.txt $APP_PATH/
RUN pip install --no-cache-dir -r $APP_PATH/requirements.base.txt

WORKDIR $APP_PATH
