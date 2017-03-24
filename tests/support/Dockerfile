FROM danvaida/ansible-docker-images:debian-wheezy-aws-slim

LABEL maintainer "me@danvaida.com"

RUN pip install dnspython==1.15.0

CMD ["./support/run-tests.sh"]
