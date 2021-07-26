FROM rocker/r-ver:4.0.4

# have to run as root because we are dynamically installing the annotation pkgs at run time to control stderr output...
USER root
RUN apt update \
    && apt install -y git=1:2.25.1-1ubuntu3.1 \
    && apt install -y zlib1g-dev=1:1.2.11.dfsg-2ubuntu1.2 \
    && apt install -y libcurl4-openssl-dev=7.68.0-1ubuntu2.6
    ## && apt install libopenblas-dev

RUN mkdir /AffySTEFC \

COPY src/*.R /AffySTEFC/
COPY lib/*.tar.gz /AffySTEFC/

RUN Rscript /AffySTEFC/installPkgs.R

RUN git clone https://github.com/bmbolstad/preprocessCore.git \
    && cd preprocessCore/ \
    && git checkout -b RELEASE_3_12 \
    && R CMD INSTALL --configure-args="--disable-threading"  .

# remember to update the tag version here and in your manifest
# docker build --rm https://github.com/genepattern/AffySTExpressionFileCreator.git#develop -f Dockerfile -t genepattern/affy-st-expression-file-creator:<tag>
# docker run --rm -it -v /c/Users/MyUSER/PathTo/AffySTExpressionFileCreator:/mnt/mydata:rw genepattern/affy-st-expression-file-creator:<tag> bash
# don't for get to push
