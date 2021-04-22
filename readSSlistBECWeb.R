# clear memory and load libraries
rm(list = ls())
library("foreign", lib.loc="C:/Program Files/R/R-3.1.2/library")
library("gdata", lib.loc="C:/Users/Public/R_library")
library("xlsx", lib.loc="C:/Users/Public/R_library")
library("dplyr", lib.loc="C:/Users/Public/R_library")
# read in data from BECWEB
SSBEC<-read.xls("http://www.for.gov.bc.ca/HRE/becweb/Downloads/Downloads_BECdb/SiteSeries_Ver8_(2011).xls", perl="C:/ORACLE/ORAHOME_10G/perl/5.8.3/bin/MSWin32-x86-multi-thread/perl")
add_rownames(SSBEC, var = "rowname")
#count BEC records by site series desctiption
SS_Count<- tally (group_by(SSBEC, SiteSeriesDescription))
#Sebset all wetland units then count them by site series description
Wetlands<-subset(SSBEC, grepl("^W", SiteSeries))
SS_Count_W<-tally(group_by(Wetlands, SiteSeriesDescription))
#list all the BEC units that have a particular wetland type. following example is swamps.
sSBEC_ws <- SSBEC %>% filter(str_detect(SiteSeries, "Ws"))
BECZONELIST <- unique(factor(sSBEC_ws$BGC_Zone))                       
             
