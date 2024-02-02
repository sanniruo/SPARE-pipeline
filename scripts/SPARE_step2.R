#!/usr/bin/env Rscript

options(stringsAsFactors=F)

## load R libraries
library(optparse)
library(SPARE)
library(coxme)
library(data.table)

option_list <- list(
  make_option("--PlinkFile", type="character",default="",
              help="Text file including file names in two columns. No header.")
)

parser <- OptionParser(usage="%prog [options]", option_list=option_list)
args <- parse_args(parser, positional_arguments = 0)
opt <- args$options
print(opt)

plinkfile = opt$PlinkFile

cmd = paste0("id=fread('",plinkfile,".fam')")
eval(parse(text = cmd))

gIDs=id$V1

cmd = paste0("nullModel=readRDS(file = '",plinkfile,"_null.rds')")
eval(parse(text = cmd))

SPARE.bed(plinkfile,
          gIDs,
          nullModel ,
          'outputTest_chrom19_all',
          min.maf = 0)
