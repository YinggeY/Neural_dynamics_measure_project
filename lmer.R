install.packages("lme4")
install.packages("effects")
install.packages("dplyr")
install.packages("car")
install.packages("lmerTest")
install.packages("multcomp")
install.packages("bayestestR")
install.packages("effectsize")
install.packages("lsr")
install.packages("ggpubr")
install.packages("BayesFactor")
install.packages("rstatix", repos = "https://cloud.r-project.org")
install.packages("rmarkdown")

library(lme4)
library(effects)
library(dplyr)
library(car)
library(lmerTest) # for mixed model set-up
library(multcomp) # for multiple comparisons
library(bayestestR) # for Bayesian hierarchical modeling
library(effectsize) # for Cohen's d effect size
library(lsr)
library(ggpubr)# qqplot
library(BayesFactor)
library(rstatix) # for wilcox effect size

install.packages("devtools")
devtools::install_github("easystats/report")
library(report)

#####################################################################################

setwd("D:/MyProject/EXP all/Version6_micro_iaf_match_A_D_bayes_summary/R")

# import data
data_run<-read.csv("table_indiv.csv")
colnames(data_run)[1] <- "subject"
colnames(data_run)[2] <- "epoch"
colnames(data_run)[3] <- "drowsiness"
colnames(data_run)[4] <- "region"
colnames(data_run)[5] <- "task"
colnames(data_run)[6] <- "LZ"
colnames(data_run)[7] <- "RT"
colnames(data_run)[8] <- "difficulty"

data_run$subject <- as.character(data_run$subject)
#data_run$drowsiness[which(data_run$drowsiness==0)] <- "awake"
#data_run$drowsiness[which(data_run$drowsiness==1)] <- "drowsy"



source('function1.R')
analysis1(data_run)
#rmarkdown::render("lmer.R", output_file = "output1.html")

#source('function2.R')
#analysis2(data_run)
#rmarkdown::render("lmer.R", output_file = "output2.html")

# ##########################remove outliers
# x_a <- data_run_1_a$y
# x_d <- data_run_1_d$y
# idx_a <- which(x_a %in% boxplot.stats(x_a)$out)
# idx_d <- which(x_d %in% boxplot.stats(x_d)$out)
# sub_a <- data_run_1_a[idx_a,3]
# sub_d <- data_run_1_d[idx_d,3]
# sub <- union(sub_a,sub_d)
# idx_a <- which(data_run_1_a[,3] %in% sub)
# idx_d <- which(data_run_1_d[,3] %in% sub)
# if(length(sub)>0) {
#   data_run_1_a <- data_run_1_a[-idx_a,]
#   data_run_1_d <- data_run_1_d[-idx_d,]
# }
# data_run_1 <-rbind(data_run_1_a,data_run_1_d)
# 
# x_a <- data_run_2_a$y
# x_d <- data_run_2_d$y
# idx_a <- which(x_a %in% boxplot.stats(x_a)$out)
# idx_d <- which(x_d %in% boxplot.stats(x_d)$out)
# sub_a <- data_run_2_a[idx_a,3]
# sub_d <- data_run_2_d[idx_d,3]
# sub <- union(sub_a,sub_d)
# idx_a <- which(data_run_2_a[,3] %in% sub)
# idx_d <- which(data_run_2_d[,3] %in% sub)
# if(length(sub)>0) {
#   data_run_2_a <- data_run_2_a[-idx_a,]
#   data_run_2_d <- data_run_2_d[-idx_d,]
# }
# data_run_2 <-rbind(data_run_2_a,data_run_2_d)
# 
# x_a <- data_run_3_a$y
# x_d <- data_run_3_d$y
# idx_a <- which(x_a %in% boxplot.stats(x_a)$out)
# idx_d <- which(x_d %in% boxplot.stats(x_d)$out)
# sub_a <- data_run_3_a[idx_a,3]
# sub_d <- data_run_3_d[idx_d,3]
# sub <- union(sub_a,sub_d)
# idx_a <- which(data_run_3_a[,3] %in% sub)
# idx_d <- which(data_run_3_d[,3] %in% sub)
# if(length(sub)>0) {
#   data_run_3_a <- data_run_3_a[-idx_a,]
#   data_run_3_d <- data_run_3_d[-idx_d,]
# }
# data_run_3 <-rbind(data_run_3_a,data_run_3_d)
# 
# x_a <- data_run_4_a$y
# x_d <- data_run_4_d$y
# idx_a <- which(x_a %in% boxplot.stats(x_a)$out)
# idx_d <- which(x_d %in% boxplot.stats(x_d)$out)
# sub_a <- data_run_4_a[idx_a,3]
# sub_d <- data_run_4_d[idx_d,3]
# sub <- union(sub_a,sub_d)
# idx_a <- which(data_run_4_a[,3] %in% sub)
# idx_d <- which(data_run_4_d[,3] %in% sub)
# if(length(sub)>0) {
#   data_run_4_a <- data_run_4_a[-idx_a,]
#   data_run_4_d <- data_run_4_d[-idx_d,]
# }
# data_run_4 <-rbind(data_run_4_a,data_run_4_d)
# 
# data_run <- rbind(data_run_1,data_run_2,data_run_3,data_run_4)
# 
