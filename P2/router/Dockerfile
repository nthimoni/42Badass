FROM frrouting/frr:latest

# Enable required routing daemons
RUN sed -i \
    -e 's/bgpd=no/bgpd=yes/' \
    -e 's/ospfd=no/ospfd=yes/' \
    -e 's/isisd=no/isisd=yes/' \
    /etc/frr/daemons
