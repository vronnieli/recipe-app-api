# base for docker image
FROM python:3.7-alpine
# (optional) maintainer of docker image
MAINTAINER VRONNIELI

# sets environment variable for python to run in unbuffered mode (set to 1), recommended when running python within docker containers, doesn't allow docker to buffer outputs (prints directly instead) and avoids complications with the docker image when running python applications
ENV PYTHONUNBUFFERED 1


# copies requirements file (where dependencies are stored) onto the docker image
COPY ./requirements.txt /requirements.txt
# takes copy requirements file and installs it using pip onto the docker image
RUN pip install -r /requirements.txt

# creates empty directory on the docker image called /app
RUN mkdir /app
# switches that directory to default directory, so that any applications run using the docker container uses this directory as the entry point
WORKDIR /app
# copy the local app folder to the app folder on the docker image
COPY ./app /app

# ('adduser') creates a user that (-D) will only be used for running Docker applications
RUN adduser -D user
# switches docker to this user for security purposes, otherwise the image will run the app using the root account (not recommended), which gives the user root access to the whole image
USER user
