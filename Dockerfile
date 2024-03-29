## Install Operating system and dependencies
#FROM ubuntu:18.04
#
#RUN apt-get update
#RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
#RUN apt-get clean
#
## download Flutter SDK from Flutter Github repo
#RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
#
## Set flutter environment path
#ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
#
## Run flutter doctor
#RUN flutter doctor
#
## Enable flutter web
#RUN flutter channel master
#RUN flutter upgrade
#RUN flutter config --enable-web
#
## Copy files to container and build
#RUN mkdir /app/
#COPY . /app/
#WORKDIR /app/
#RUN flutter build web
#
## Record the exposed port
#EXPOSE 5050
#
## make server startup script executable and start the web server
#RUN ["chmod", "+x", "/app/server/server.sh"]
#
#ENTRYPOINT [ "/app/server/server.sh"]


# Build environment
FROM debian:stable-slim AS build-env

RUN apt-get update && \
    apt-get install -y curl git unzip libstdc++6 && \
    rm -rf /var/lib/apt/lists/*

# Download and install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable Flutter web and switch to beta channel
RUN flutter channel beta && \
    flutter upgrade && \
    flutter config --enable-web

# Copy files and build
WORKDIR /app
COPY . /app
RUN flutter build web --release

# Production environment
FROM nginx:1.21.1-alpine

# Copy built files to Nginx directory
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
