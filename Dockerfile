FROM python:3-alpine
# FROM ubuntu:20.04

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]