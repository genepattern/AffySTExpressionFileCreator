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
site.library <- "/Users/eby/Library/R/3.1/library"

cat("\nLibrary dir: ",site.library)
.libPaths(site.library)

suppressMessages(suppressWarnings(
   library(optparse)
))
suppressMessages(suppressWarnings(
   library(affxparser)  # looks like this is already loaded by oligo, so probably no need to explicitly do so.
))
suppressMessages(suppressWarnings(
   library(affio)
))
suppressMessages(suppressWarnings(
   library(oligo)
))

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

source(file.path(libdir, "gp_oligo_efc.R"))
source(file.path(libdir, "common.R"))

normalize <- (opts$normalize == "yes")
background.correct <- (opts$background.correct == "yes")
compute.present.absent.calls <- (opts$compute.present.absent.calls == "yes")
annotate.probes <- (opts$annotate.probes == "yes")

check.output.format(opts$qc.plot.format)

# Set up all of the input files in a common directory for processing.
# Notes on the approach:
# - Leave all files in current input dir as that is GP standard.
# - R pkgs expect CELs to be located in a single subdir, so we'll copy into a subtree (note - symlink doesn't work)
#   then remove it on exit.
# - Any compressed/archived files will be expanded into this subtree.  Support common formats:
#   ZIP, TAR, gz, bz2 (probably that's all). Would be good to expand into flattened dir (+ copy/symlink
#   for raw files). For safety, we should only allow unique CEL file names. Pretty sure that's the case
#   based on existing EFC patterns and usual GP practices:
#     - Problem is that sample names are based on CEL file names.  It is possible to supply different
#       names via CLM, but that is still a mapping based on file name.
#     - Would be good to fail if duplicated name is found.  How to detect within archives?
# - Gather up all these file names with list.celfiles.
#     - Looks like R will catch any duplicate file names when read.celfiles tries to form a dataframe.

# Create a subdir to hold all of the input files.
dir.create("cel_files")
file.list <- read.table(opts$input.file, header=FALSE)

# Future plan here is to decompress (as needed) based on extension with cel_files as dest.  I think each will go into a subdir
# (just make unique names with numeric value & archive name) so that there is no overwriting and any duplicates are preserved.  
# That allows the read.celfiles call to detect and report duplicates.  Uncompressed cels can go into top level where name 
# collisions are detected by file.copy( overwrite=FALSE ).
for (i in 1:NROW(file.list)) {
   in.file <- toString(file.list[i, 1])
   to <- file.path("cel_files")  # This will be more sophisticated later, with generated tmp dir.
   retVal <- file.copy(in.file, to, overwrite=FALSE)
   if (!retVal) { stop(paste0("Unable to make a local copy of '", from, "' in location '", to, "'")) }
}

GP.affyst.efc("cel.files", normalize, background.correct, compute.present.absent.calls,
              opts$qc.plot.format, opts$clm.file, annotate.probes, opts$output.file.base)

# Clean up the CEL file subtree.
# Note: this needs to happen in a try/finally or other clean-up hook of some sort.  That will come later.
unlink("cel_files")