FROM debian:buster-slim

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install mc htop ncdu -y

ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD ["/bin/bash"]