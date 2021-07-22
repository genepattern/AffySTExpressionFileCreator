suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("/AffySTEFC/getopt_1.20.3.tar.gz", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("/AffySTEFC/optparse_1.6.6.tar.gz", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("/AffySTEFC/R.methodsS3_1.8.1.tar.gz", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("/AffySTEFC/R.oo_1.24.0.tar.gz", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("/AffySTEFC/R.utils_2.10.1.tar.gz", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("/AffySTEFC/DBI_1.1.1.tar.gz", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("/AffySTEFC/RSQLite_2.2.6.tar.gz", quiet = TRUE))))
# don't think we need this anymore since parallel is included in 2.14.0
#suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("parallel", repos = "https://cloud.r-project.org/", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("iterators_1.0.13.tar.gz", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("foreach_1.5.1.tar.gz", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("bit_4.0.4.tar.gz", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("zip_2.1.1.tar.gz", quiet = TRUE))))
suppressPackageStartupMessages(suppressMessages(suppressWarnings(install.packages("BiocManager_1.30.15.tar.gz", quiet = TRUE))))

library("getopt")
library("optparse")

suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('BiocGenerics', version = "3.12", quiet = TRUE))))
# 0.36.1 from Bioconductor v3.12 - all
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('IRanges', version = "3.12", quiet = TRUE))))
# 2.24.1 from Bioconductor v3.12
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('XVector', version = "3.12", quiet = TRUE))))
# 0.30.0 from Bioconductor v3.12
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('GenomeInfoDb', version = "3.12", quiet = TRUE))))
# 1.26.7 (This gets IRanges & BiocGenerics btw), from Bioconductor v3.12
#https://packagemanager.rstudio.com/cran/__linux__/focal/2021-03-30/src/contrib/bitops_1.0-6.tar.gz - do these need to be grabbed separately?
#https://packagemanager.rstudio.com/cran/__linux__/focal/2021-03-30/src/contrib/RCurl_1.98-1.3.tar.gz
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('GenomicRanges', version = "3.12", quiet = TRUE))))
# 1.42.0 from Bioconductor v3.12
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('Biobase', version = "3.12", quiet = TRUE))))
# 2.50.0 from Bioconductor v3.12
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('zlibbioc', version = "3.12", quiet = TRUE))))
# 1.36.0 from Bioconductor v3.12
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('Biostrings', version = "3.12", quiet = TRUE))))
# 2.58.0 from Bioconductor v3.12
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('affyio', version = "3.12", quiet = TRUE))))
# 1.60.0 from Bioconductor v3.12
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('affxparser', version = "3.12", quiet = TRUE))))
# 1.62.0 from Bioconductor v3.12
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('preprocessCore', version = "3.12", quiet = TRUE))))
# 1.52.1 from Bioconductor v3.12
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('oligoClasses', version = "3.12", quiet = TRUE))))
# 1.52.0 from Bioconductor v3.12
suppressPackageStartupMessages(suppressMessages(suppressWarnings(BiocManager::install('oligo', version = "3.12", quiet = TRUE))))
# 1.54.1 from Bioconductor v3.12