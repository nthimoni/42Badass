FROM frrouting/frr:latest

# Enable required routing daemons
RUN sed -i \
    -e 's/bgpd=no/bgpd=yes/' \
    -e 's/ospfd=no/ospfd=yes/' \
    -e 's/isisd=no/isisd=yes/' \
    /etc/frr/daemons

COPY frr.conf /etc/frr/frr.conf
    
CMD ["sh", "-c", "chown -R frr:frr /etc/frr && \
    exec /usr/lib/frr/frrinit.sh start && \
    tail -F /var/log/frr/*.log"]
