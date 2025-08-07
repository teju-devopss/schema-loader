FROM           redhat/ubi8


# Copy and execute install.sh
COPY          install.sh /
RUN           bash /install.sh

# Copy and set entrypoint
COPY           run.sh /
ENTRYPOINT ["bash", "/run.sh"]

