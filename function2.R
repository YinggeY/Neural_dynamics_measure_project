analysis2 <- function(data_run){

# models
model.null = lmer(RT ~ difficulty + (1|subject/epoch), data=data_run, REML=FALSE)
model.LZ = lmer(RT ~ LZ + difficulty + (1|subject/epoch), data=data_run, REML=FALSE)
model.drowsiness = lmer(RT ~ drowsiness + difficulty + (1|subject/epoch), data=data_run, REML=FALSE)
model.LZ_region = lmer(RT ~ LZ*region + difficulty + (1|subject/epoch), data=data_run, REML=FALSE)
model.drows_region = lmer(RT ~ drowsiness*region + difficulty + (1|subject/epoch), data=data_run, REML=FALSE)
model.LZ_drows = lmer(RT ~ LZ*drowsiness + difficulty + (1|subject/epoch), data=data_run, REML=FALSE)
model.complete = lmer(RT ~ LZ*drowsiness*region + difficulty + (1|subject/epoch), data=data_run, REML=FALSE)

# model comparison
print("------------------------------------- model comparison ----------------------------------------------")
print(anova(model.null,model.LZ)) 
print(anova(model.null,model.drowsines)) 
print(anova(model.null,model.LZ_region))
print(anova(model.null,model.drows_region))
print(anova(model.null,model.LZ_drows))
print(anova(model.null,model.complete))

print(anova(model.LZ,model.drowsiness))
print(anova(model.LZ,model.LZ_region))
print(anova(model.LZ,model.LZ_drows))
print(anova(model.LZ,model.complete))
print(anova(model.drowsiness,model.drows_region))
print(anova(model.drowsiness,model.LZ_drows))
print(anova(model.drowsiness,model.complete))

print(anova(model.LZ_region,model.complete))
print(anova(model.drows_region,model.complete))
print(anova(model.LZ_drows,model.complete))

print("---------------------------------- bayes model comparison -------------------------------------------")
print(bayesfactor_models(model.LZ,model.drowsiness,model.LZ_region,model.drows_region,model.LZ_drows,model.complete, denominator = model.null))
print(bayesfactor_models(model.drowsiness,model.LZ_region,model.LZ_drows,model.complete, denominator = model.LZ))
print(bayesfactor_models(model.drows_region,model.LZ_drows,model.complete, denominator = model.drowsiness))
print(bayesfactor_models(model.complete, denominator = model.LZ_region))
print(bayesfactor_models(model.complete, denominator = model.drows_region))
print(bayesfactor_models(model.complete, denominator = model.LZ_drows))

# anova
print("--------------------------------- anova(model.LZ_region) -------------------------------------------")
print(anova(model.LZ_region))
print("--------------------------------- anova(model.drows_region) -------------------------------------------")
print(anova(model.drows_region))
print("--------------------------------- anova(model.LZ_drows) -------------------------------------------")
print(anova(model.LZ_drows))
print("--------------------------------- anova(model.complete) --------------------------------------------")
print(anova(model.complete))
print("-------------------------------- summary(model.complete) -------------------------------------------")
print(summary(model.complete))


# Post Hoc comparisions
print("----------------------------------------- Post Hoc --------------------------------------------------")
data_run$LZRegion <- interaction(data_run$LZ, data_run$region)

data_run_alert = subset(data_run,drowiness== "alert")
model_LZRegion_alert = lmer(RT ~ LZRegion + difficulty + (1|subject/epoch), data=data_run_alert,REML=FALSE)
print(summary(glht(model_LZRegion_alert, mcp(LZRegion="Tukey"))))

data_run_drowsy = subset(data_run,drowiness== "drowsy")
model_LZRegion_drowsy = lmer(RT ~ LZRegion + difficulty + (1|subject/epoch), data=data_run_drowsy,REML=FALSE)
print(summary(glht(model_LZRegion_drowsy, mcp(LZRegion="Tukey"))))


################################# t-test / rank test / effect size / Bayesian
# # get difference
# data_run_1_y <-cbind(data_run_1_a$y,data_run_1_d$y,data_run_1_a$y - data_run_1_d$y)
# 
# print("-----------------------------------------------------------------------------------------------------")
# print("----------------------------- t-test (rank test) / effect size / BF ---------------------------------")
# print("-----------------------------------------------------------------------------------------------------")
# print("")
# # print("--------------------------------------------- EXP 1 -------------------------------------------------")
# data_run_y <- data_run_1_y
# # normality test
# results <- shapiro.test(data_run_y[,3])
# if (results$p.value > 0.05) {
#   # t-test
#   print(t.test(data_run_y[,1],data_run_y[,2],paired=TRUE))
#   print(cohensD(y ~ drowsiness,data=data_run_1,method = "paired"))
# } else {
#   # Wilcoxon signed rank test
#   print(wilcox.test(data_run_y[,1],data_run_y[,2],paired=TRUE))
#   print(wilcox_effsize(y ~ drowsiness,data=data_run_1,paired = TRUE))
# }
# print(ttestBF(data_run_y[,1],data_run_y[,2],paired=TRUE))


}