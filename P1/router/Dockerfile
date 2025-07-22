FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y gnupg curl lsb-release && \
    curl -s https://deb.frrouting.org/frr/keys.asc | apt-key add - && \
    echo "deb https://deb.frrouting.org/frr $(lsb_release -cs) frr-stable" > /etc/apt/sources.list.d/frr.list && \
    apt-get update && \
    apt-get install -y frr frr-pythontools supervisor \
    && apt clean


RUN sed -i 's/bgpd=no/bgpd=yes/' /etc/frr/daemons && \
    sed -i 's/ospfd=no/ospfd=yes/' /etc/frr/daemons && \
    sed -i 's/isisd=no/isisd=yes/' /etc/frr/daemons

COPY frr.conf /etc/frr/frr.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chown -R frr:frr /etc/frr && \
    chmod 640 /etc/frr/frr.conf

# Expose routing protocol ports if needed
# EXPOSE 2601 2604 2605

CMD ["/usr/bin/supervisord"]
