
FROM mcr.microsoft.com/devcontainers/base:dev-debian-12

LABEL org.opencontainers.image.source https://github.com/vwfinley/texlive

ENV PATH="$PATH:/usr/local/texlive/2025/bin/x86_64-linux"

RUN apt-get update

WORKDIR /tmp 

RUN <<EOF
    wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    zcat < install-tl-unx.tar.gz | tar xf -
    cd install-tl-*
    perl ./install-tl --scheme=small --no-interaction --no-doc-install --no-src-install
    tlmgr update --all
    cd ..
    rm -r install*
EOF

WORKDIR /workspace 

USER vscode