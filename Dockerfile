FROM rocker/verse:3.6.0

LABEL description = "Bingo"
MAINTAINER "Leif Wigge" leif.wigge@scilifelab.se

WORKDIR /bingo

# Install Miniconda
RUN apt-get update && apt-get install -y --no-install-recommends curl bzip2 && apt-get clean
RUN curl https://repo.continuum.io/miniconda/Miniconda3-4.6.14-Linux-x86_64.sh -O && \
    bash Miniconda3-4.6.14-Linux-x86_64.sh -bf -p /opt/miniconda3/ && \
    rm Miniconda3-4.6.14-Linux-x86_64.sh
ENV PATH="/opt/miniconda3/bin:${PATH}"
RUN conda config --add channels bioconda && \
    conda config --add channels conda-forge

# Install Snakemake
RUN conda install -c bioconda snakemake-minimal=5.3.0 && \
    conda clean --all

# Run workflow (requires mounting of project files)
CMD snakemake -s Snakefile --configfile config.yml bingo
