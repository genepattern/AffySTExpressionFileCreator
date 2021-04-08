FROM r-base:4.0.3

USER root
RUN apt-get update && apt-get upgrade -y
RUN apt install libcurl4-openssl-dev
# RUN apt install libopenblas-dev

RUN mkdir /AffySTEFC
RUN chown -R $NB_USER /AffySTEFC
USER $NB_USER

COPY src/*.R /AffySTEFC/

RUN Rscript /AffySTEFC/installPkgs.R /AffySTEFC/