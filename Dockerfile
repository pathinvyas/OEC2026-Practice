FROM docker.io/library/debian:stable-slim AS build

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV FLUTTER_HOME=/usr/local/flutter
ENV PATH=${FLUTTER_HOME}/bin:${PATH}

RUN git clone --depth 1 --branch stable https://github.com/flutter/flutter.git ${FLUTTER_HOME}

# Save time
RUN flutter config --no-analytics \
    && flutter config --enable-web \
    && flutter config --no-enable-android \
    && flutter config --no-enable-ios

# Fix
ENV TAR_OPTIONS="--no-same-owner"
WORKDIR /app
# Copy pubspec first to cache the "flutter pub get" step
COPY pubspec.* ./
RUN flutter pub get

COPY . .
RUN flutter build web --release

FROM docker.io/library/nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]