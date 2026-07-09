install.packages(c("survival","survminer","randomForest","caret"))
library(tidyverse)
library(survival)
library(survminer)
library(randomForest)
library(caret)
heart_model<- read.csv("https://raw.githubusercontent.com/vishnupriya62/DATASET-heart-failure-clinical-records/refs/heads/main/heart_failure_clinical_records_dataset%20(1).csv") %>%
  mutate(creatinine_phosphokinase = log(creatinine_phosphokinase))
#reproducible
set.seed(42)
#random 70% of rows using base R sampling
train_rows <- sample(1:nrow(heart_model), size = 0.7 * nrow(heart_model))
#split into separate sets
train_set <- heart_model[train_rows, ]
test_set  <- heart_model[-train_rows, ]
#convert to factors for random forest classification 
train_set$DEATH_EVENT <-as.factor(train_set$DEATH_EVENT)
test_set$DEATH_EVENT  <- as.factor(test_set$DEATH_EVENT)
#full data in training set , death event as a numeric 0/1 indicator
heart_model$DEATH_EVENT<- as.numeric(as.character(heart_model$DEATH_EVENT))
#1 fit cox proportional Hazards evaluates how various risk factors multiply the baseline hazard of death
cox_model<- coxph(Surv(time, DEATH_EVENT)~ age+ ejection_fraction+serum_creatinine+serum_sodium+high_blood_pressure+anaemia, data=heart_model)
cox_model2<- coxph(Surv(time, DEATH_EVENT)~ age+ ejection_fraction+serum_creatinine+serum_sodium+high_blood_pressure+diabetes, data=heart_model)
AIC(cox_model1)
AIC(cox_model2)
BIC(cox_model1)
BIC(cox_model2)
#hazard ratios and coefficients
summary(cox_model)
summary(cox_model2)
ggforest(cox_model,data=heart_model)
#Survival curve
km<- survfit(Surv(time, DEATH_EVENT)~1,data=heart_model)
ggsurvplot(km,data=heart_model, conf.int=TRUE,palette = 'blue', risk.table =TRUE, title="Overall Patient Survival Probabillity", xlab = "Follow-up Period (Days)", ylab= "Survival Probability")
#
custom_patients <- data.frame(
  age = c(45, 75),
  ejection_fraction = c(55, 20),      # Patient 1: Normal, Patient 2: Severe Heart Failure
  serum_creatinine = c(0.8, 2.4),     # Patient 1: Normal, Patient 2: Renal Failure
  serum_sodium = c(140, 130),         # Patient 1: Normal, Patient 2: Hyponatremia
  high_blood_pressure = c(0, 1),
  diabetes = c(0, 1)
)

# Predict survival curves specifically for these two individuals using our Cox model
individual_curves <- survfit(cox_model2, newdata = custom_patients)

# Plot both simulated patients to visualize the divergence in risk
ggsurvplot(
  individual_curves, 
  data = custom_patients,
  legend.labs = c("Patient 1: Low Risk Profile", "Patient 2: High Risk Profile"),
  palette = c("#2ca25f", "#de2d26"),
  title = "Individualized Patient Survival Predictions",
  xlab = "Timeline (Days)",
  ylab = "Predicted Probability of Survival"
)
