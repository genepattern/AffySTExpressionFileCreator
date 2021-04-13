# AffySTExpressionFileCreator (v2)

**Description**: GenePattern module which Creates a GCT file from a set of CEL files from Affymetrix ST arrays.

**Authors**: David Eby, Broad Institute; Anthony Castanza, UCSD; Barbara Hill, Broad Institute

**Contact**: [Forum Link](https://groups.google.com/forum/?utm_medium=email&utm_source=footer#!forum/genepattern-help)

---

## Summary

This module creates a gene expression dataset from a set of CEL files for Affymetrix ST arrays.  It is similar to [ExpressionFileCreator](https://www.genepattern.org/modules/docs/ExpressionFileCreator/13), which operates on CEL files from the older 3' biased IVT-based Affymetrix arrays.  The conversion is done using the [Robust Multi-array Average (RMA) algorithm](http://biostatistics.oxfordjournals.org/content/4/2/249.long) as provided [by the 'oligo' package](https://bioconductor.riken.jp/packages/3.5/bioc/manuals/oligo/man/oligo.pdf) in Bioconductor.  The result is a matrix containing one intensity value per probe set per sample in the [GCT file format](https://www.genepattern.org/file-formats-guide#GCT). 

**Note that the RMA algorithm will log-transform the data during processing.**  This may affect downstream processing by other modules, some of which will produce erroneous results with log-transformed data unless adjustments are made.  For example, the ComparativeMarkerSelection module has a parameter that must be set for it to accept and adjust for log-transformed data.

Multiple CEL files can be provided individually to the input file parameter for processing.  The parameter also accepts CELs packaged as a ZIP or TAR file, or supplied as a directory input.  You can provide multiple ZIPs, TARs, or directory inputs as well, or mix all of these forms.  CEL files can be uncompressed or in GZ format. TAR files can be uncompressed, or in GZ, XZ, or BZ2 format.  Any directory inputs will be recursively searched for CEL files (uncompressed or in GZ format) to include in the dataset; ZIPs and TARs in these inputs will **not** be included, however.

You can supply an optional [CLM file](https://www.genepattern.org/file-formats-guide#CLM) listing the CEL files to be included in the dataset, their order, their phenotypic categories, and their alternate sample names.  Note that if there are any files submitted for a job but not listed in the included CLM file, those files will **not** be included in the dataset.  The column order of the output dataset will match the order of the CLM listing.  If no CLM file is provided, the CEL file names will be used as sample names and the order will match the module's processing order.  This can be somewhat unpredictable, so if order is important then the use of a CLM is recommended.

The default behavior is to _normalize_ and _background correct_ the dataset upon extraction, but the appropriate parameters can be set to 'no' if raw data extraction is desired.

Also by default, the dataset will be annotated with gene identifiers for each probeset; set _annotate probes_ to 'no' if you don't want these included.  Where available, the Entrez Gene number, RefSeq ID, and gene symbol will be provided in the "Description" column of the dataset, in the format "[_EntrezGene number_] // [_RefSeq ID_] // [_gene symbol_]".  The text "NA" is given instead if any of these are missing.  These annotations come from the Bioconductor bundle for the array set being analyzed.  Unfortunately, no annotation information is available for organisms other than Human, Mouse, or Rat. Note also that the necessary probeset level annotations are currently only available for the Human Clariom D assay, the other Clariom arrays do not support feature annotation at this time.

Lastly, the module is capable of producing a set of plots in multiple formats that may be useful for QC purposes.  See the Output Files section below for more details.  Plot generation is turned off by default as it can be quite time-consuming.

## References
---

Carvalho BS and Irizarry RA (2010). “A Framework for Oligonucleotide Microarray Preprocessing.” Bioinformatics. ISSN 1367-4803.

Carvalho BS and Irizarry RA (2017). "Package 'oligo'" documentation from Bioconductor 3.5.
