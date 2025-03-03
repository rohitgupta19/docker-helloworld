############################################################
# Dockerfile to build Nginx Installed Containers
# Based on Ubuntu
############################################################

ARG CLOUD_PROVIDER = AWS

ENV CLOUD_PROVIDER = $CLOUD_PROVIDER

# Echo the environment variable
RUN echo "CLOUD_PROVIDER is set to: $CLOUD_PROVIDER"

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Karthik Gaekwad

# Install Nginx

# Add application repository URL to the default sources
# RUN echo "deb http://archive.ubuntu.com/ubuntu/ raring main universe" >> /etc/apt/sources.list

# Update the repository
RUN apt-get update

# Install necessary tools
RUN apt-get install -y vim wget dialog net-tools

RUN apt-get install -y nginx

# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/

RUN mkdir /etc/nginx/logs

# Add a sample index file
ADD index.html /www/data/

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Create a entrypoint-selector script for the entrypoint
COPY entrypoint-selector.sh /entrypoint-selector.sh
RUN chmod +x /entrypoint-selector.sh

# Expose ports
EXPOSE 80

ENTRYPOINT ["/entrypoint-selector.sh"]

# Set the default command to execute
# when creating a new container
CMD ["nginx"]
