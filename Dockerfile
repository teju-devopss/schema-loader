FROM                     public.ecr.aws/aws-cli/aws-cli
COPY                     install.sh /
RUN                      bash /install.sh
COPY                     run.sh /
ENTRYPOINT               ["bash", "/run.sh"]