## The Broad Institute
## SOFTWARE COPYRIGHT NOTICE AGREEMENT
## This software and its documentation are copyright (2014) by the
## Broad Institute/Massachusetts Institute of Technology. All rights are
## reserved.
##
## This software is supplied without any warranty or guaranteed support
## whatsoever. Neither the Broad Institute nor MIT can be responsible for its
## use, misuse, or functionality.

#lines 12 - 61 are now in installPkgs.R
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("getopt", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("optparse", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("R.methodsS3", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("R.oo", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("R.utils", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("DBI", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("RSQLite", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("parallel", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("iterators", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("foreach", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("bit", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("zip", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("BiocManager", repos = "https://cloud.r-project.org/", quiet = TRUE))))
#
library("getopt")
library("optparse")
library("zip")

# Don't load the 'ff' package even though it is specified in the r.package.info file.  It's needed
# to install the oligoClasses pkg but if it's loaded at runtime then it changes the behavior of
# the module, with failures as a result. 
#suppressMessages(suppressWarnings(library(ff)))

#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('BiocGenerics', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('IRanges', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('XVector', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('GenomeInfoDb', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('GenomicRanges', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('Biobase', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('zlibbioc', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('Biostrings', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('affyio', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('affxparser', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('preprocessCore', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('oligoClasses', quiet = TRUE))))
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('oligo', quiet = TRUE))))

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
