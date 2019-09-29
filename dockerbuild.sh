# TAG_VERSION=$1
# docker build \
#   --no-cache \
#   -t devmasx/dockerize-stack \
#   -t devmasx/dockerize-stack:$TAG_VERSION \
#    .

DOCKER_TAG=$($GITHUB_REF | sed -e 's/refs\/tags\/v//')
DOCKER_IMAGE_NAME=devmasx/dockerize-stack
echo $DOCKER_TAG
# docker login -u $DOCKER_USER -p $DOCKER_PASSWORD
# docker build --no-cache -t $DOCKER_IMAGE_NAME -t $DOCKER_IMAGE_NAME:$DOCKER_TAG
# docker push $DOCKER_IMAGE_NAME
# docker push $DOCKER_IMAGE_NAME:$DOCKER_TAG
