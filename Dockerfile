FROM debian:testing

LABEL maintainer="Sven Höper" \
  org.label-schema.name="shoeper/spellcheck" \
  org.label-schema.description="Docker image to run spellchecks with aspell" \
  org.label-schema.vcs-url="https://github.com/shoeper/docker-spellcheck-debian" \
  org.label-schema.schema-version="1.0"

ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LC_TYPE="en_US.UTF-8" \
    DEBIAN_FRONTEND="noninteractive"

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections && \
    echo "LANGUAGE=\"$LANGUAGE\"\nLC_ALL=\"$LC_ALL\"" > /etc/default/locale && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    apt-get update && \
    apt-get install -y \
        apt-utils \
        locales && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure -f noninteractive locales && \
    update-locale LANG=en_US.UTF-8 && \
    apt-get install --no-install-recommends -y \
        aspell \
        aspell-en \
        aspell-de \
        poppler-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
