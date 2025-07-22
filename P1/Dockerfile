FROM debian:bullseye

# dependencies
RUN apt update && apt install -y \
    frr frr-pythontools \
    busybox \
    supervisor \
    iproute2 \
    net-tools \
    && apt clean

RUN sed -i 's/bgpd=no/bgpd=yes/' /etc/frr/daemons && \
    sed -i 's/ospfd=no/ospfd=yes/' /etc/frr/daemons && \
    sed -i 's/isisd=no/isisd=yes/' /etc/frr/daemons

COPY frr.conf /etc/frr/frr.conf

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose routing protocol ports if needed
# EXPOSE 2601 2604 2605

CMD ["/usr/bin/supervisord"]
