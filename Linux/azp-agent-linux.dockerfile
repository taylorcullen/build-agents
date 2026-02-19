# Use Ubuntu as the base image
FROM ubuntu:20.04

ENV TARGETARCH="linux-x64"
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies and required tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    wget bash curl git jq ca-certificates less \
    ncurses-base krb5-locales libgcc1 locales \
    libstdc++6 tzdata liburcu-dev zlib1g icu-devtools \
    python3 python3-pip openssl libssl-dev libffi-dev gcc \
    make python3-dev linux-headers-generic apt-transport-https \
    software-properties-common gnupg2 zip

# Add Microsoft package repository and install .NET SDK 8
RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    rm packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y dotnet-sdk-8.0

# Install PowerShell 7
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y powershell

# Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Install K6
RUN wget -q -O - https://dl.k6.io/key.gpg | apt-key add - && \
    echo "deb https://dl.k6.io/deb stable main" | tee /etc/apt/sources.list.d/k6.list && \
    apt-get update && \
    apt-get install -y k6

WORKDIR /azp/

COPY ./start.sh ./
RUN chmod +x ./start.sh

RUN adduser --disabled-password --gecos "" agent
RUN chown agent ./
USER agent

ENTRYPOINT [ "./start.sh" ]
