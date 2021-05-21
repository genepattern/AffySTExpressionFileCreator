## The Broad Institute
## SOFTWARE COPYRIGHT NOTICE AGREEMENT
## This software and its documentation are copyright (2014) by the
## Broad Institute/Massachusetts Institute of Technology. All rights are
## reserved.
##
## This software is supplied without any warranty or guaranteed support
## whatsoever. Neither the Broad Institute nor MIT can be responsible for its
## use, misuse, or functionality.

sink(stdout(), type = "message")

# see installPkgs.R for what was installed in the Docker image
library("getopt")
library("optparse")
library("zip")

library("BiocGenerics")
library("IRanges")
library("XVector")
library("GenomeInfoDb")
library("GenomicRanges")
library("Biobase")
library("zlibbioc")
library("Biostrings")
library("affyio")
library("affxparser")
library("preprocessCore")
library("oligoClasses")
library("oligo")

sessionInfo()

args <- commandArgs(trailingOnly=TRUE)

libdir <- args[1]

option_list <- list(
  make_option("--input.file", dest="input.file"),
  make_option("--normalize", dest="normalize"),
  make_option("--background.correct", dest="background.correct"),
  make_option("--qc.plot.format", dest="qc.plot.format"),
  make_option("--clm.file", dest="clm.file", default=NULL),
  make_option("--annotate.rows", dest="annotate.rows"),
  make_option("--output.file.base", dest="output.file.base")
  )

opt <- parse_args(OptionParser(option_list=option_list), positional_arguments=TRUE, args=args)
print(opt)
opts <- opt$options

source(file.path(libdir, "common.R"))
source(file.path(libdir, "gp_affyst_efc.R"))

normalize <- (opts$normalize == "yes")
background.correct <- (opts$background.correct == "yes")
compute.present.absent.calls <- (opts$compute.present.absent.calls == "yes")

annotate.rows <- (opts$annotate.rows == "yes")

check.output.format(opts$qc.plot.format)

destdir <- "cel_files"
tryCatch(
   {
      files.to.process <- GP.setup.input.files(opts$input.file, destdir)
      GP.affyst.efc(files.to.process, normalize, background.correct, opts$qc.plot.format, 
                    opts$clm.file, annotate.rows, opts$output.file.base)
   },
   finally = {
      # Clean up the CEL file subtree.
      unlink(destdir, recursive=TRUE)
   }
)

sessionInfo()
