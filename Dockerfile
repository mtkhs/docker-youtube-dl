FROM alpine:3.8

ENV DOWNLOADS_DIR /workspace
ENV SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt

RUN apk add --update --no-cache --virtual=dependencies curl \
    && apk add --update --no-cache ca-certificates ffmpeg python2 \
    && curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl \
    && chmod a+rx /usr/local/bin/youtube-dl \
    && apk update \
    && apk del --update dependencies \
    && mkdir $DOWNLOADS_DIR \
    && chmod a+rw $DOWNLOADS_DIR \
    && rm -r /root/.cache

WORKDIR $DOWNLOADS_DIR

ENTRYPOINT [ "youtube-dl" ]
CMD [ "--help" ]

