# Source: https://dev.to/pwd9000/create-a-docker-based-self-hosted-github-runner-linux-container-48dh
FROM ubuntu:20.04

#input GitHub runner version argument
ARG RUNNER_VERSION
ENV DEBIAN_FRONTEND=noninteractive

LABEL Author="Marcel L"
LABEL Email="pwd9000@hotmail.co.uk"
LABEL GitHub="https://github.com/Pwd9000-ML"
LABEL BaseImage="ubuntu:20.04"
LABEL RunnerVersion=${RUNNER_VERSION}

# update the base packages + add a non-sudo user
RUN apt-get update -y && apt-get upgrade -y && useradd -m docker

# install the packages and dependencies along with jq so we can parse JSON (add additional packages as necessary)
RUN apt-get install -y --no-install-recommends \
    curl nodejs wget unzip vim git  build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

# cd into the user directory, download and unzip the github actions runner
WORKDIR /home/docker/actions-runner
RUN curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

# install some additional dependencies
RUN chown -R docker /home/docker
RUN /home/docker/actions-runner/bin/installdependencies.sh

# set the user to "docker" so all subsequent commands are run as the docker user
USER docker

# set the entrypoint to the start.sh script
ENTRYPOINT ["tail", "-f", "/dev/null"]