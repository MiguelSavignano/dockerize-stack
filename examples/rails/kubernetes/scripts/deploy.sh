PROJECT_ID=<PROJECT_ID>

kubectl set image deployment/rails-nginx \
  nginx=eu.gcr.io/${PROJECT_ID}/nginx:latest \
  rails=eu.gcr.io/${PROJECT_ID}/webapp:latest
