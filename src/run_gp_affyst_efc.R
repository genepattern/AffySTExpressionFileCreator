## The Broad Institute
## SOFTWARE COPYRIGHT NOTICE AGREEMENT
## This software and its documentation are copyright (2014) by the
## Broad Institute/Massachusetts Institute of Technology. All rights are
## reserved.
##
## This software is supplied without any warranty or guaranteed support
## whatsoever. Neither the Broad Institute nor MIT can be responsible for its
## use, misuse, or functionality.

args <- commandArgs(trailingOnly=TRUE)

libdir <- args[1]

site.library <- args[2]

# Temporarily use my local lib so we can avoid the need to create dependency installer.
#site.library <- "/Users/eby/Library/R/3.1/library"

cat("\nLibrary dir: ",site.library)
.libPaths(site.library)

suppressMessages(suppressWarnings({
   library(optparse)
   library(R.utils)
   library(affyio)
   library(oligo)
   library(DBI)
   library(KernSmooth)
}))

option_list <- list(
  make_option("--input.file", dest="input.file"),
  make_option("--normalize", dest="normalize"),
  make_option("--background.correct", dest="background.correct"),
  make_option("--compute.present.absent.calls", dest="compute.present.absent.calls"),
  make_option("--qc.plot.format", dest="qc.plot.format"),
  make_option("--clm.file", dest="clm.file", default=NULL),
  make_option("--annotate.probes", dest="annotate.probes"),
  make_option("--output.file.base", dest="output.file.base")
  )

opt <- parse_args(OptionParser(option_list=option_list), positional_arguments=TRUE, args=args)
print(opt)
opts <- opt$options

sessionInfo()

source(file.path(libdir, "common.R"))
source(file.path(libdir, "gp_affyst_efc.R"))

normalize <- (opts$normalize == "yes")
background.correct <- (opts$background.correct == "yes")
compute.present.absent.calls <- (opts$compute.present.absent.calls == "yes")
annotate.probes <- (opts$annotate.probes == "yes")

check.output.format(opts$qc.plot.format)

destdir <- "cel_files"
tryCatch(
   {
      setup.input.files(opts$input.file, destdir)
      GP.affyst.efc(destdir, normalize, background.correct, compute.present.absent.calls,
                    opts$qc.plot.format, opts$clm.file, annotate.probes, opts$output.file.base,
                    site.library)
   },
   finally = {
      # Clean up the CEL file subtree.
      unlink(destdir, recursive=TRUE)
   }
)