FROM debian:jessie
MAINTAINER Vip Consult Solutions <team@vip-consult.solutions>

RUN apt-get update

RUN apt-get install -y proftpd openssl

RUN apt-get install -y openssl \
    && openssl req -x509 -nodes -days 1500 -newkey rsa:2048 \
    -subj "/C=GB/ST=dorset/L=dorset/O=vip-consult.co.uk/OU=IT/CN=vip-consult.co.uk/emailAddress=support@vip-consult.co.uk" \
    -keyout /etc/proftpd/proftpd.pem \
    -out /etc/proftpd/proftpd.pem && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY proftpd.conf /etc/proftpd/
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["proftpd", "-n"]
