#!/bin/sh
set -ex
PROJECT_ID=<PROJECT_ID>
BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`
SHORT_SHA=`git rev-parse --short HEAD`
IMAGE_NAME=gcr.io/${PROJECT_ID}

# Build rails builder
docker build \
  -t ${IMAGE_NAME}/rails:${BRANCH_NAME}-${SHORT_SHA}-builder \
  -t ${IMAGE_NAME}/rails:${BRANCH_NAME}-latest-builder \
  -t ${IMAGE_NAME}/rails:latest-builder \
  --target builder \
  -f docker/production/rails/Dockerfile \
  .

# Build rails
docker build \
  -t ${IMAGE_NAME}/rails:${BRANCH_NAME}-${SHORT_SHA} \
  -t ${IMAGE_NAME}/rails:${BRANCH_NAME}-latest \
  -t ${IMAGE_NAME}/rails:latest \
  -f docker/production/rails/Dockerfile \
  .

# Build nginx
docker build \
  -t ${IMAGE_NAME}/nginx:${BRANCH_NAME}-${SHORT_SHA} \
  -t ${IMAGE_NAME}/nginx:${BRANCH_NAME}-latest \
  -f docker/production/nginx/Dockerfile \
  docker/production/nginx

gcloud docker -- push ${IMAGE_NAME}/rails:${BRANCH_NAME}-${SHORT_SHA}-builder
gcloud docker -- push ${IMAGE_NAME}/rails:${BRANCH_NAME}-latest-builder
gcloud docker -- push ${IMAGE_NAME}/rails:latest-builder
gcloud docker -- push ${IMAGE_NAME}/rails:${BRANCH_NAME}-${SHORT_SHA}
gcloud docker -- push ${IMAGE_NAME}/rails:${BRANCH_NAME}-latest
gcloud docker -- push ${IMAGE_NAME}/rails:latest
gcloud docker -- push ${IMAGE_NAME}/nginx:${BRANCH_NAME}-${SHORT_SHA}
gcloud docker -- push ${IMAGE_NAME}/nginx:${BRANCH_NAME}-latest
