FROM python:alpine
ENV PYTHONUNBUFFERED 1
COPY ./requirements.txt /requirements.txt
COPY ./app ./app 

WORKDIR /app
EXPOSE 8000

RUN install /requirements.txt &&\