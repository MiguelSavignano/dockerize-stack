kubectl create configmap rails-config \
  --from-literal=DATABASE_HOST=cloudsql-proxy \
  --from-literal=DATABASE_NAME=rails_production \
  --from-literal=RAILS_LOG_TO_STDOUT=true
