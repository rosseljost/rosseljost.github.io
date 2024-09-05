FROM pandoc/latex:latest-ubuntu


RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
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
    python3-pip \
    python3-venv
RUN python3 -m venv /venv
RUN . /venv/bin/activate && \
    python3 -m pip install --upgrade pip

RUN mkdir -p /src
COPY src/requirements.txt /src/requirements.txt

RUN . /venv/bin/activate && \
    python3 -m pip install -r /src/requirements.txt

WORKDIR /

COPY src/ /src

ENTRYPOINT bash /src/build.sh /content /content-rendered /docs /meta
