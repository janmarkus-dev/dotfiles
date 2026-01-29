FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install SSH server and dev tools
RUN apt-get update && apt-get install -y \
    openssh-server \
    git \
    curl \
    wget \
    vim \
    build-essential \
    python3 \
    python3-pip \
    nodejs \
    npm \
    sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH properly
RUN mkdir -p /var/run/sshd /run/sshd \
    && ssh-keygen -A \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Create developer user with proper home directory
RUN useradd -m -s /bin/bash dev \
    && echo "dev:devpassword" | chpasswd \
    && echo "dev ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && mkdir -p /home/dev/.ssh \
    && chown -R dev:dev /home/dev/.ssh \
    && chmod 700 /home/dev/.ssh

WORKDIR /home/dev/projects

EXPOSE 2222

CMD ["/usr/sbin/sshd", "-D", "-e", "-p", "2222"]
