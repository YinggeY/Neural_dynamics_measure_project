analysis1 <- function(data_run){

# models
model.null = lmer(LZ ~ 1 + (1|subject/epoch), data=data_run, REML=FALSE)
model.drowsiness = lmer(LZ ~ drowsiness + (1|subject/epoch), data=data_run, REML=FALSE)
model.drows_region = lmer(LZ ~ drowsiness*region + (1|subject/epoch), data=data_run, REML=FALSE)
model.drows_task = lmer(LZ ~ drowsiness*task + (1|subject/epoch), data=data_run, REML=FALSE)
model.complete = lmer(LZ ~ drowsiness*region + drowsiness*task + (1|subject/epoch), data=data_run, REML=FALSE)
model.complete_check = lmer(LZ ~ drowsiness*region + task + drowsiness:task + (1|subject/epoch), data=data_run, REML=FALSE)

# model comparison
print("------------------------------------- model comparison ----------------------------------------------")
print(anova(model.null,model.drowsiness)) 
print(anova(model.null,model.drows_region))
print(anova(model.null,model.drows_task))
print(anova(model.null,model.complete))
print(anova(model.drowsiness,model.drows_region))
print(anova(model.drowsiness,model.drows_task))
print(anova(model.drowsiness,model.complete))
print(anova(model.drows_region,model.drows_task))
print(anova(model.drows_region,model.complete))
print(anova(model.drows_task,model.complete))
print("---------------------------------- bayes model comparison -------------------------------------------")
print(bayesfactor_models(model.drowsiness,model.drows_region,model.drows_task,model.complete, denominator = model.null))
print(bayesfactor_models(model.drows_region,model.drows_task,model.complete, denominator = model.drowsiness))
print(bayesfactor_models(model.drows_task, denominator = model.drows_region))
print(bayesfactor_models(model.complete, denominator = model.drows_region))
print(bayesfactor_models(model.complete, denominator = model.drows_task))

# anova
print("--------------------------------- anova(model.drows_region) -------------------------------------------")
print(anova(model.drows_region))
print("--------------------------------- anova(model.drows_task) -------------------------------------------")
print(anova(model.drows_task))
print("--------------------------------- anova(model.complete) --------------------------------------------")
print(anova(model.complete))
print(anova(model.complete_check))
print("-------------------------------- summary(model.complete) -------------------------------------------")
print(summary(model.complete))


# Post Hoc comparisions
print("----------------------------------------- Post Hoc --------------------------------------------------")
data_run$drowsRegion <- interaction(data_run$drowsiness, data_run$region)

data_run_act = subset(data_run,task== "active")
model_drowsRegion_act = lmer(LZ ~ drowsRegion + (1|subject/epoch), data=data_run_act,REML=FALSE)
print(summary(glht(model_drowsRegion_act, mcp(drowsRegion="Tukey"))))

data_run_pas = subset(data_run,task== "passive")
model_drowsRegion_pas = lmer(LZ ~ drowsRegion + (1|subject/epoch), data=data_run_pas,REML=FALSE)
print(summary(glht(model_drowsRegion_pas, mcp(drowsRegion="Tukey"))))


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