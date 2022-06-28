FROM python:3.10

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
EXPOSE 8000
CMD ["gunicorn", "monthly_challenges.wsgi:application", "-w", "4", "-b", "0.0.0.0"]