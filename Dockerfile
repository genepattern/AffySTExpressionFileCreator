FROM r-base:4.0.4

USER root
RUN apt-get install libcurl4-openssl-dev
    ## && apt install libopenblas-dev

RUN mkdir /AffySTEFC \
    && chown docker /AffySTEFC

USER docker
COPY src/*.R /AffySTEFC/
COPY lib/*.tar.gz /AffySTEFC/

RUN Rscript /AffySTEFC/installPkgs.R

USER root
RUN git clone https://github.com/bmbolstad/preprocessCore.git \
    && cd preprocessCore/ \
    && R CMD INSTALL --configure-args="--disable-threading"  .

USER docker

# remember to update the tag version here and in your manifest
# docker build --rm https://github.com/genepattern/AffySTExpressionFileCreator.git#develop -f Dockerfile -t genepattern/affy-st-expression-file-creator:<tag>
# docker run
