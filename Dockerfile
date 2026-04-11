FROM debian:trixie-slim

# These values should be coming from the generated `.env` file.
ARG MY_USERNAME
ARG MY_UID
ARG MY_GID

ENV USERNAME=${MY_USERNAME:-dumbass}
ENV UID=${MY_UID:-1000}
ENV GID=${MY_GID:-1000}

RUN apt-get update \
    && apt-get install -y \
        apt-transport-https \
        bash \
        ca-certificates \
        curl \
        fd-find \
        git \
        gnupg \
        jq \
        less \
        lsb-release \
        lsof \
        procps \
        python3-venv \
        ripgrep \
        sudo \
        tmux \
        tree \
        unzip \
        wget \
        zip \
    && rm -rf /var/lib/apt/lists/*

# Do not run as root, use sudo without password; might be useless
RUN groupadd -g ${GID} ${USERNAME} \
    && useradd -u ${UID} -g ${GID} -m -s /bin/bash ${USERNAME} \
    && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME} \
    && chmod 0440 /etc/sudoers.d/${USERNAME}

# Set the default shell to bash instead of dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections \
    && dpkg-reconfigure dash

RUN mkdir -p /home/${USERNAME}/.config/opencode && \
    mkdir -p /home/${USERNAME}/.config/openspec && \
    mkdir -p /home/${USERNAME}/.local/share/opencode && \
    mkdir -p /home/${USERNAME}/.cache/opencode && \
    mkdir -p /home/${USERNAME}/.cache/oh-my-opencode && \
    mkdir -p /home/${USERNAME}/.cache/openspec && \
    mkdir -p /home/${USERNAME}/.npm && \
    mkdir -p /home/${USERNAME}/workdir && \
    chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

USER ${USERNAME}
WORKDIR /home/${USERNAME}

# TODO: Do stuff a target user More installation of tools

# Back to running commands as root.
USER root

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Default working directory (overridden at runtime by --workdir)
WORKDIR /home/${USERNAME}/workdir

# Set the entrypoint (runs as root, then switches to ${USERNAME})
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command is to run opencode
# CMD ["opencode"]
CMD ["/bin/bash", "-l"]
