FROM alpine:latest as python-build

MAINTAINER Tim Huegdon <tim@timhuegdon.com>

ENV LANG=en_GB.utf-8 \
    LC_ALL=en_GB.utf-8
RUN apk add --update --no-cache --virtual=build-deps build-base bash python3-dev    && \
    find / -type d -name __pycache__ -exec rm -r {} +                               && \
    rm -r /usr/lib/python*/ensurepip                                                && \
    rm -r /usr/lib/python*/turtledemo                                               && \
    rm /usr/lib/python*/turtle.py                                                   && \
    rm /usr/lib/python*/webbrowser.py                                               && \
    pip3 install -U pip pipenv

FROM python-build as python-lxml-build
RUN apk add --update --no-cache --virtual=lxml-deps libxml2-dev libxslt-dev

FROM python-lxml-build as python-postgres-build
RUN apk add --update --no-cache --virtual=psql-deps postgresql-dev musl-dev
