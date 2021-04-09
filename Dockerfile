FROM r-base:4.0.3

USER root
RUN apt-get update && apt-get upgrade -y \
    && apt install -y \
    git \
    libcurl4-openssl-dev
    ## && apt install libopenblas-dev

RUN mkdir /AffySTEFC \
    && chown docker /AffySTEFC

RUN git clone https://github.com/bmbolstad/preprocessCore.git \
    && chown docker /preprocessCore

USER docker

COPY src/*.R /AffySTEFC/

RUN Rscript /AffySTEFC/installPkgs.R /AffySTEFC/

RUN cd preprocessCore/ \
    && R CMD INSTALL --configure-args="--disable-threading"  .
