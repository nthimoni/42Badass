# Use Alpine as the base image
FROM alpine:latest

# Install busybox (though it's already part of Alpine, this ensures it's explicitly available)
RUN apk update && apk add --no-cache busybox

# Set the default command to busybox shell
CMD ["busybox", "sh"]
