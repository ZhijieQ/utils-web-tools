FROM node:18-alpine3.17 AS builder

RUN apk add --no-cache libc6-compat
RUN apk add --update python3 make g++ && rm -rf /var/cache/apk/*
WORKDIR /tmp

COPY . .
RUN npm install
RUN npm run hoist
RUN npm run build
RUN npm run docker

# # https://lipanski.com/posts/smallest-docker-image-static-website
# # https://github.com/lipanski/docker-static-website
# FROM zhijieuam/static-web:latest

# # Copy the static website
# # Use the .dockerignore file to control what ends up inside the image!
# COPY --from=builder /tmp/website/build .

# Base on offical NGINX Alpine image
FROM nginx:alpine

# Remove any existing config files
RUN rm /etc/nginx/conf.d/*

# Copy config files
# *.conf files in conf.d/ dir get included in main config
COPY ./web/default.conf /etc/nginx/conf.d/

WORKDIR /app
COPY --from=builder /tmp/website/build .

# Expose the listening port
EXPOSE 80

# Launch NGINX
CMD [ "nginx", "-g", "daemon off;" ]
