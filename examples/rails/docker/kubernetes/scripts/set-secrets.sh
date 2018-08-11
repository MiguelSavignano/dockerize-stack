kubectl create secret generic rails-secrets \
  --from-literal=DATABASE_USERNAME= \
  --from-literal=DATABASE_PASSWORD= \
  --from-literal=SECRET_KEY_BASE= \
  --from-literal=RAILS_MASTER_KEY=
