FROM reynoldsm88/interstellar:latest
LABEL maintainer="michael.reynolds@twosixlabs.com"

COPY topics.yml /opt/config/topics.yml

ENTRYPOINT cd /opt/app/interstellar && python3 interstellar.py --deployment_config /opt/config/topics.yml
