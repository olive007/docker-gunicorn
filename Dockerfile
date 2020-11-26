FROM python:latest

# Install gunicorn (pip package)
RUN pip install pip gunicorn --upgrade

# Add the a new user to run gunicorn
RUN useradd -r www

# Set the starting stript
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create the root directory for the application
RUN mkdir -p /srv/src /srv/static
WORKDIR /srv/src
VOLUME /srv/src
VOLUME /srv/static
ENV PYTHONPATH=$PYTHONPATH:/srv/src

# Set the default environment variable
ENV LOG_FOLDER=/var/log/gunicorn
ENV REQUIREMENTS_FILE=/srv/requirements.txt
ENV NBR_WORKER=2

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
