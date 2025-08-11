FROM              dokken/centos-stream-8
COPY              install.sh /
RUN               bash /install.sh
COPY              run.sh /
ENTRYPOINT        ["bash", "/run.sh"]


