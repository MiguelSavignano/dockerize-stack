FROM gcr.io/<PROJECT_ID>/rails:latest as rails

FROM nginx:1.13-alpine

RUN apk upgrade --no-cache
RUN apk add --no-cache xz

# COPY content/usr/local/sbin/* /usr/local/sbin/
COPY etc/nginx/ /etc/nginx/

WORKDIR /app

COPY --from=rails /app/public ./public
