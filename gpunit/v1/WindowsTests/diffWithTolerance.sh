#!/bin/sh
diffdir=`mktemp -d $base1.XXXXXX`
cd $diffdir
/Library/Frameworks/R.framework/Versions/2.15/Resources/bin/Rscript --no-save --quiet --slave --no-restore ~/Documents/workspace/GenePattern/modules/DiffDatasets/src/run_diff_datasets.R ~/Documents/workspace/GenePattern/modules/DiffDatasets/src/ /Applications/GenePatternServer /Applications/GenePatternServer/patches/ --first.input.file=$1 --second.input.file=$2 --round.method=round --round.digits=6
cd ..
rm -rf $diffdir