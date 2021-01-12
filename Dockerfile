FROM ubuntu:18.04

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install mc htop ncdu openssh-server p7zip-full wget -y && \
    mkdir /var/run/sshd && \
    echo 'root:MHzv9Sy9zm9p2z8J' | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22

ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

CMD ["/usr/sbin/sshd", "-D"]