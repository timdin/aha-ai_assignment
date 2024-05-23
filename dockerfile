# Use an official selenium image as a parent image
FROM selenium/standalone-chrome:latest

# install python
USER root
RUN apt-get update && apt-get install -y python3-pip python3-dev && rm -rf /var/lib/apt/lists/*
RUN pip3 install --upgrade pip

# Install Robot Framework and SeleniumLibrary
RUN pip3 install robotframework robotframework-seleniumlibrary
