FROM ubuntu:16.04

LABEL description = "Bingo"
MAINTAINER "Leif Wigge" leif.wigge@scilifelab.se

WORKDIR /bingo
ENV LC_ALL en_US.UTF-8
ENV LC_LANG en_US.UTF-8
SHELL ["/bin/bash", "-c"]

# Install necessary tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends bzip2 \
                                               ca-certificates \
                                               curl \
                                               fontconfig \
                                               git \
                                               language-pack-en \
                                               tzdata \
                                               wget \
    && apt-get clean

# Install TinyTeX
RUN wget -qO- "https://yihui.name/gh/tinytex/tools/install-unx.sh" | sh

# Install Miniconda and add to PATH
RUN curl https://repo.continuum.io/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh -O && \
    bash Miniconda3-4.6.14-Linux-x86_64.sh -bf -p /opt/miniconda3/ && \
    rm Miniconda3-4.6.14-Linux-x86_64.sh
ENV PATH="/opt/miniconda3/bin:${PATH}"

# Add project files
COPY environment.yml .

# Install conda environment
RUN conda config --add channels defaults && \
    conda config --add channels bioconda && \
    conda config --add channels conda-forge && \
    conda env update -n base -f environment.yml && \
    conda clean --all

CMD snakemake -s Snakefile --configfile config.yml bingo
