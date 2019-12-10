FROM nginx:stable-alpine

LABEL maintainer="Brightfish <dept.devl@brightfish.be>"

ARG APP_ENV
ARG APP_TIMEZONE

# Set correct timezone
RUN apk add --no-cache tzdata \
    && ln -sf /usr/share/zoneinfo/$APP_TIMEZONE /etc/localtime \
    && echo $APP_TIMEZONE > /etc/timezone \
    && rm -rf /tmp/* /var/cache/apk/*

# Copy configuration
COPY ./nginx-${APP_ENV:-production}.conf /etc/nginx/nginx.conf

# Create app root dir
WORKDIR /var/www/app
