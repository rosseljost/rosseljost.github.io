FROM pandoc/latex:latest-ubuntu


RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    haskell-platform \
    git \
    curl
RUN curl -sSL https://get.haskellstack.org/ | sh

WORKDIR /
RUN git clone https://github.com/jez/pandoc-sidenote
WORKDIR /pandoc-sidenote
RUN stack build
RUN stack install

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    python3 \
    python3-pip
RUN pip install --upgrade pip

RUN mkdir -p /src
COPY src/requirements.txt /src/requirements.txt

RUN pip install -r /src/requirements.txt

WORKDIR /

COPY src/ /src

ENTRYPOINT bash /src/build.sh /content /content-rendered /docs /meta
