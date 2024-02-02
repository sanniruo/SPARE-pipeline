#!/usr/bin/env Rscript

options(stringsAsFactors=F)

## load R libraries
library(optparse)
library(SPARE)
library(coxme)
library(data.table)

option_list <- list(
  make_option("--PhenoFile", type="character",default="",
              help="Text file including file names in two columns. No header.")
)

parser <- OptionParser(usage="%prog [options]", option_list=option_list)
args <- parse_args(parser, positional_arguments = 0)
opt <- args$options
print(opt)

file <- opt$PhenoFile

data<-fread(file)
data<-data.frame(data)
data<-na.omit(data)

## Null model
fitme = coxme(Surv(tstart, tstop, Status) ~ age + sex + ( 1 | subject), data = data)

obj.null = Null_model(fitme,
                      data,
                      IDs = unique (data$subject))

print("Null model finished, starting to .")

saveRDS(obj.null, file = "null_test.rds")
