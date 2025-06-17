ARG UBUNTU_VERSION=jammy

FROM ghcr.io/minchinweb/base:${UBUNTU_VERSION}

# keep apt happy
ARG DEBIAN_FRONTEND=noninteractive

EXPOSE 21025

COPY root/ /

# the server executable and base game assets need to be provided and mounted under /app
VOLUME /config
VOLUME /app


# these are provided by the build hook when run on Docker Hub
ARG BUILD_DATE="1970-01-01T00:00:00Z"
ARG COMMIT="local-build"
ARG URL="https://github.com/minchinweb/docker-starbound"
ARG BRANCH="none"

LABEL maintainer="MinchinWeb" \
      org.label-schema.description="Personal Starbound server; provide your own Starbound in /app" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-url=${URL} \
      org.label-schema.vcs-ref=${COMMIT} \
      org.label-schema.schema-version="1.0.0-rc1"


CMD /app/linux/starbound_server -bootconfig /config/sbinit.config
