FROM python:latest

# Install gunicorn (pip package)
RUN pip install pip gunicorn --upgrade

# Add the a new user to run gunicorn
RUN useradd -r www

# Set the starting stript
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Create the root directory for the application
RUN mkdir -p /srv/app
WORKDIR /srv/app
VOLUME /srv/app
ENV PYTHONPATH=$PYTHONPATH:/srv/app

# Set the default environment variable
ENV LOG_FOLDER=/var/log/gunicorn
ENV NBR_WORKER=2

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
