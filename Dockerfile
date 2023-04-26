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
