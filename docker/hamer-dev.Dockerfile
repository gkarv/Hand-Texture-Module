ARG BASE=pytorch/pytorch:2.4.0-cuda11.8-cudnn9-devel
FROM ${BASE} AS hamer

# Install OS dependencies:
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends --fix-missing \
    gcc g++ \
    make \
    python3 python3-dev python3-pip python3-venv python3-wheel \
    espeak-ng libsndfile1-dev \
    git \
    wget \
    ffmpeg \
    libsm6 libxext6 \
    libglfw3-dev libgles2-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

# Install hamer:
WORKDIR /app



COPY third-party/ third-party/

# Install project dependencies:
COPY . .

RUN pip install --no-build-isolation  torch==2.4.0 torchvision==0.19.0 torchaudio==2.4.0 --index-url https://download.pytorch.org/whl/cu118
RUN pip install --no-build-isolation setuptools==60.2.0
RUN pip install --no-build-isolation -e .[all]
RUN pip install --no-build-isolation -v -e third-party/ViTPose

