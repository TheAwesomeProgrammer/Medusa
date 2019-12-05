FROM python:3.7-alpine3.9
LABEL maintainer="pymedusa"

ENV MEDUSA_COMMIT_BRANCH origin
ENV MEDUSA_COMMIT_HASH 39fa62d86761cd482c2b747a143c1dd6065d2911

LABEL localMedusa

# Install packages
RUN \
	# Update
	apk update \
	&& \
	# Runtime packages
	apk add --no-cache \
		mediainfo \
		tzdata \
		unrar \
	&& \
	# Cleanup
	rm -rf \
		/var/cache/apk/

# Install app
COPY . /app/medusa/

# Ports and Volumes
EXPOSE 8081
VOLUME /config /downloads /tv /anime

WORKDIR /app/medusa
CMD [ "python", "start.py", "--nolaunch", "--datadir", "/config" ]
