FROM alpine:3.7
MAINTAINER Timsonet L.
RUN apk -U add --no-cache postfix && \
    postalias /etc/postfix/aliases && \
    mkdir -p /var/spool/postfix/pid && \
    mkdir -p /var/spool/postfix/public && \
    mkfifo /var/spool/postfix/public/pickup && \
    chown  root /var/spool/postfix/. && \
    chown  root /var/spool/postfix/pid && \
    postalias /etc/postfix/aliases
    
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh
EXPOSE 25

CMD ["/root/run.sh"]

