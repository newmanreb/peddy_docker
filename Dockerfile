FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LD_LIBRARY_PATH=/usr/local/lib

# Install build dependencies and bcftools, tabix directly
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    build-essential \
    libbz2-dev \
    liblzma-dev \
    libz-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libffi-dev \
    zlib1g-dev \
    libreadline-dev \
    libsqlite3-dev \
    tabix \
    && rm -rf /var/lib/apt/lists/*

# Install Python 3.8 from source
RUN apt-get update && apt-get install -y ca-certificates && \
    wget https://www.python.org/ftp/python/3.8.18/Python-3.8.18.tgz && \
    tar xzf Python-3.8.18.tgz && \
    cd Python-3.8.18 && \
    ./configure --enable-optimizations && \
    make -j$(nproc) && \
    make altinstall && \
    ln -s /usr/local/bin/python3.8 /usr/bin/python && \
    ln -s /usr/local/bin/pip3.8 /usr/bin/pip && \
    cd .. && rm -rf Python-3.8.18*

# Install peddy
RUN pip install peddy

# Set working directory
WORKDIR /data

# Default command
CMD ["peddy"]