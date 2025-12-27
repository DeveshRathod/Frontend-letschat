# Stage 1: Build frontend
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Nginx serve
FROM nginx:alpine

RUN addgroup -S appgroup && adduser -S appuser -G appgroup

RUN mkdir -p /usr/share/nginx/html \
    && mkdir -p /etc/nginx/conf.d \
    && mkdir -p /var/cache/nginx/client_temp \
    && mkdir -p /run \
    && mkdir -p /var/log/nginx \
    && chown -R appuser:appgroup /usr/share/nginx/html /etc/nginx/conf.d /var/cache/nginx /run /var/log/nginx


COPY nginx.conf.template /etc/nginx/conf.d/nginx.conf.template

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

COPY --from=build /app/dist /usr/share/nginx/html

USER appuser

EXPOSE ${PORT:-80}

ENTRYPOINT ["/entrypoint.sh"]
