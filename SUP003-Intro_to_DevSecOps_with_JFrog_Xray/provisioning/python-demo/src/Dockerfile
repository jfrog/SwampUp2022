ARG REGISTRY=yann-sbx.dev.gcp.devopsacc.team
ARG DOCKER_REPO=urs-docker

FROM $REGISTRY/$DOCKER_REPO/python:3.9.5-slim-buster

ARG PYTHON_REPO=urs-python
ARG RT_USER=ci
ARG RT_TOKEN

# https://docs.docker.com/engine/reference/builder/#understand-how-arg-and-from-interact
ARG REGISTRY

WORKDIR  /var/opt/webapp

RUN mkdir -p /var/opt/webapp
ADD webapp_python.tar.gz .
RUN ls -l
RUN pip config set global.index-url https://${RT_USER}:${RT_TOKEN}@${REGISTRY}/artifactory/api/pypi/${PYTHON_REPO}/simple && \
    pip install -r requirements.txt --trusted-host ${REGISTRY}

EXPOSE 8080

ENTRYPOINT ["python3", "main.py"]
