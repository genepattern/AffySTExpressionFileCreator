FROM r-base:4.0.3

USER root
RUN apt-get update \
    && apt-get upgrade -y \
    && apt install libcurl4-openssl-dev -y \
    #&& apt install libopenblas-dev

RUN mkdir /AffySTEFC \
    && chown docker /AffySTEFC
USER docker

COPY src/*.R /AffySTEFC/

RUN Rscript /AffySTEFC/installPkgs.R /AffySTEFC/

RUN git clone https://github.com/bmbolstad/preprocessCore.git \
    && cd preprocessCore/ \
    && R CMD INSTALL --configure-args="--disable-threading"  .