# Gunicorn docker container 

This container run gunicorn and save logs into files **and** standard output.

## Example: docker-compose.yml 
``` yaml
version: "3"

services:
  example:
    build: olive007/gunicorn
    volumes:
      # The source code have to be mounted into the /src/app folder.
      # It is recommended to mount it in read-only mode
      - ./src:/srv/app:ro
    ports:
      # The port use by gunicorn to serve the HTTP server is 8000.
      - "80:8000"
    environment:
      # The python path is required.
      # The first part (before the ':') is the path to the file separated by '.'.
      # The second part (after the ':') is the name of the variable that contain the WSGI application.
      APP_MODULE: "wsgi:api"
```

## Environment variable
- APP_MODULE: Required python path to the WSGI application.
- LOG_FOLDER: Define the path where the log will be save. (Default is /var/log/gunicorn)
- NBR_WORKER: Define the number of worker. (Default is 2)
