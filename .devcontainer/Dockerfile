# Laboratorio Zero Trust · NicaHackfest
# FreeRADIUS 3.2, eapol_test (cliente 802.1X), radsecproxy y OpenSSL sobre Ubuntu 24.04
FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive LANG=C.UTF-8
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      freeradius freeradius-utils eapoltest radsecproxy openssl tcpdump \
      nano less procps iproute2 git ca-certificates bash-completion \
 && rm -rf /var/lib/apt/lists/* \
 && ln -s /lab/lab /usr/local/bin/lab \
 && echo 'umask 022' >> /etc/bash.bashrc

CMD ["bash"]
