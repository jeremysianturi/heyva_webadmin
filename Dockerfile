# Install Operating system and dependencies
FROM ubuntu:latest as build-env

RUN apt-get update && \
    apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# download Flutter SDK from Flutter Github repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter environment path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web and switch to beta channel
RUN flutter channel beta && \
    flutter upgrade && \
    flutter config --enable-web

# Copy files to container
RUN mkdir /app/
COPY . /app/
WORKDIR /app/

# Build Flutter web app (part 1)
RUN flutter build web --release

# Copy Flutter web app build files to a new image
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
