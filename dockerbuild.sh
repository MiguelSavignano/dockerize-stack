TAG_VERSION=$1
docker build \
  --no-cache \
  -t devmasx/dockerize-stack \
  -t devmasx/dockerize-stack:$TAG_VERSION \
   .
