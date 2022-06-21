FROM python:3.8-slim-buster
# Application environment variables.
ENV APP_USER=demo
ENV APP_WORKDIR=/app

# Install required base packages.
RUN apt-get -y update
RUN apt-get install -yq --no-install-recommends \
    gcc libsasl2-dev python-dev libldap2-dev \
    libssl-dev openssh-client
RUN apt-get -y autoremove && apt-get -y autoclean
# Install pipenv tool with pip.
RUN pip install pipenv

# Install all dependencies.
RUN pipenv install --dev
# Activate Python virtual environment.
RUN . $(pipenv --venv)/bin/activate

# Set app project work directory.
WORKDIR ${APP_WORKDIR}

# Upgrade pip
RUN pip install --upgrade pip
# Install required Python packages with requirements file.
COPY requirements.txt .
RUN pip install -r requirements.txt

# Add a new app user.
RUN useradd --create-home ${APP_USER}

# Add install app project to Docker container.
COPY . .

# Change owner for project work directory.
RUN chown ${APP_USER}:${APP_USER} -R ${APP_WORKDIR}
# Switch to new app user.
USER ${APP_USER}

# Run sms-gateway
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]