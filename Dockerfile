FROM python:3.8-slim-buster

ENV APP_WORKDIR=/app


RUN apt-get -y update
RUN apt-get install -yq --no-install-recommends \
    gcc libsasl2-dev python-dev libldap2-dev \
    libssl-dev openssh-client
RUN apt-get -y autoremove && apt-get -y autoclean

WORKDIR ${APP_WORKDIR}
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]