install.packages(c("tidyverse","ggpubr","devtools"))
devtools::install_github("r-lib/conflicted")
library(tidyverse)
library(ggpubr)
library(conflicted)
heart<- read.csv("https://raw.githubusercontent.com/vishnupriya62/DATASET-heart-failure-clinical-records/refs/heads/main/heart_failure_clinical_records_dataset%20(1).csv")
head(heart)
glimpse(heart)
summary(heart)
#proportion of deceased vs censored
ggplot(heart, aes(x = factor(DEATH_EVENT), fill = factor(DEATH_EVENT)))+
  geom_bar(alpha=.8, show.legend=FALSE)+
  scale_x_discrete(labels = c("0" = "Survived / Censored", "1" = "Deceased"))+
  labs(
    title = "Distribution of Death Events",
    x = "Patient Outcome",
    y = "Number of Patients"
  )
#skewness analysis
ggplot(heart, aes(x = creatinine_phosphokinase))+
  geom_histogram(bins=30, fill="blue", color ="white", alpha=.8)
ggplot(heart, aes(x = log(creatinine_phosphokinase)))+
  geom_histogram(bins=30, fill="blue", color ="white", alpha=.8)
ggplot(heart, aes(x = ejection_fraction))+
  geom_histogram(bins=30, fill="blue", color ="white", alpha=.8)
ggplot(heart, aes(x = log(ejection_fraction)))+
  geom_histogram(bins=30, fill="blue", color ="white", alpha=.8)
ggplot(heart, aes(x = platelets))+
  geom_histogram(bins=30, fill="blue", color ="white", alpha=.8)
ggplot(heart, aes(x = I(platelets)^.5))+
  geom_histogram(bins=30, fill="blue", color ="white", alpha=.8)
ggplot(heart, aes(x = serum_creatinine))+
  geom_histogram(bins=30, fill="blue", color ="white", alpha=.8)
ggplot(heart, aes(x = log(serum_creatinine)))+
  geom_histogram(bins=30, fill="blue", color ="white", alpha=.8)
ggplot(heart, aes(x = serum_sodium))+
  geom_histogram(bins=30, fill="blue", color ="white", alpha=.8)
ggplot(heart, aes(x = I(serum_sodium)^2))+
  geom_histogram(bins=30, fill="blue", color ="white", alpha=.8)

#continuous variables vs mortality
#skewed
wilcox.test(serum_creatinine~DEATH_EVENT, data=heart)
ggplot(heart, aes(x = factor(DEATH_EVENT), y = serum_creatinine, fill = factor(DEATH_EVENT))) +
  geom_boxplot(alpha = 0.7, show.legend = FALSE) +
  scale_x_discrete(labels = c("0" = "Survived", "1" = "Deceased")) +
  scale_fill_manual(values = c("green", "red")) +
  stat_compare_means(method = "wilcox.test", label = "p.format", label.x = 1.5) +
  labs(
    title = "Serum Creatinine Levels by Survival Status",
    x = "Outcome",
    y = "Serum Creatinine (mg/dL)"
  )

wilcox.test(creatinine_phosphokinase~DEATH_EVENT,data=heart)
ggplot(heart, aes(x = factor(DEATH_EVENT), y = creatinine_phosphokinase, fill = factor(DEATH_EVENT))) +
  geom_boxplot(alpha = 0.7, show.legend = FALSE) +
  scale_x_discrete(labels = c("0" = "Survived", "1" = "Deceased")) +
  scale_fill_manual(values = c("green", "red")) +
  stat_compare_means(method = "wilcox.test", label = "p.format", label.x = 1.5) +
  labs(
    title = "Creatine Phosphokinase by Survival Status",
    x = "Outcome",
    y = "Creatine Phosphokinase (mcg/L)"
  )

#normalish
t.test(ejection_fraction~DEATH_EVENT,data=heart)
ggplot(heart, aes(x = factor(DEATH_EVENT), y = ejection_fraction, fill = factor(DEATH_EVENT))) +
  geom_boxplot(alpha = 0.7, show.legend = FALSE) +
  scale_x_discrete(labels = c("0" = "Survived", "1" = "Deceased")) +
  scale_fill_manual(values = c("green", "red")) +
  stat_compare_means(method = "t.test", label = "p.format", label.x = 1.5) +
  labs(
    title = "Ejection Fraction by Survival Status",
    x = "Outcome",
    y = "Ejection Fraction (%)"
  )

t.test(platelets~DEATH_EVENT,data=heart)
ggplot(heart, aes(x = factor(DEATH_EVENT), y = platelets, fill = factor(DEATH_EVENT))) +
  geom_boxplot(alpha = 0.7, show.legend = FALSE) +
  scale_x_discrete(labels = c("0" = "Survived", "1" = "Deceased")) +
  scale_fill_manual(values = c("green", "red")) +
  stat_compare_means(method = "t.test", label = "p.format", label.x = 1.5) +
  labs(
    title = "Platelets by Survival Status",
    x = "Outcome",
    y = "Platelets (K/uL)"
  )

t.test(serum_sodium~DEATH_EVENT,data=heart)
ggplot(heart, aes(x = factor(DEATH_EVENT), y = serum_sodium, fill = factor(DEATH_EVENT))) +
  geom_boxplot(alpha = 0.7, show.legend = FALSE) +
  scale_x_discrete(labels = c("0" = "Survived", "1" = "Deceased")) +
  scale_fill_manual(values = c("green", "red")) +
  stat_compare_means(method = "t.test", label = "p.format", label.x = 1.5) +
  labs(
    title = "Serum Sodium Levels by Survival Status",
    x = "Outcome",
    y = "Serum Sodium (mmol/L)"
  )
#Categorical/Binary variables v Mortality
hbp_table <- table(heart$high_blood_pressure, heart$DEATH_EVENT)
rownames(hbp_table) <- c("No HBP", "Has HBP")
colnames(hbp_table) <- c("Survived", "Deceased")
print(hbp_table)
chisq.test(hbp_table)
heart %>%
  mutate(
    high_blood_pressure = factor(high_blood_pressure, labels = c("No HBP", "Has HBP")),
    DEATH_EVENT = factor(DEATH_EVENT, labels = c("Survived", "Deceased"))
  ) %>%
  ggplot(aes(x = high_blood_pressure, fill = DEATH_EVENT)) +
  geom_bar(position = "fill", alpha = 0.8) +
  scale_fill_manual(values = c("blue", "orange")) +
  labs(
    title = "Mortality Proportions by High Blood Pressure Status",
    x = "Clinical Status",
    y = "Proportion",
    fill = "Outcome"
  )

diab_table <- table(heart$diabetes, heart$DEATH_EVENT)
rownames(diab_table) <- c("No Diabetes", "Has Diabetes")
colnames(diab_table) <- c("Survived", "Deceased")
print(diab_table)
chisq.test(diab_table)
heart %>%
  mutate(
    diabetes = factor(diabetes, labels = c("No Diabetes", "Has Diabetes")),
    DEATH_EVENT = factor(DEATH_EVENT, labels = c("Survived", "Deceased"))
  ) %>%
  ggplot(aes(x = diabetes, fill = DEATH_EVENT)) +
  geom_bar(position = "fill", alpha = 0.8) +
  scale_fill_manual(values = c("blue", "orange")) +
  labs(
    title = "Mortality Proportions by Diabetes Status",
    x = "Clinical Status",
    y = "Proportion",
    fill = "Outcome"
  )

anem_table <- table(heart$anaemia, heart$DEATH_EVENT)
rownames(anem_table) <- c("No Anemia", "Has Anemia")
colnames(anem_table) <- c("Survived", "Deceased")
print(anem_table)
chisq.test(anem_table)
heart %>%
  mutate(
    anaemia = factor(anaemia, labels = c("No Anemia", "Has Anemia")),
    DEATH_EVENT = factor(DEATH_EVENT, labels = c("Survived", "Deceased"))
  ) %>%
  ggplot(aes(x = anaemia, fill = DEATH_EVENT)) +
  geom_bar(position = "fill", alpha = 0.8) +
  scale_fill_manual(values = c("blue", "orange")) +
  labs(
    title = "Mortality Proportions by Anemia Status",
    x = "Clinical Status",
    y = "Proportion",
    fill = "Outcome"
  )

smk_table <- table(heart$smoking, heart$DEATH_EVENT)
rownames(smk_table) <- c("Doesn't Smoke", "Smokes")
colnames(smk_table) <- c("Survived", "Deceased")
print(smk_table)
chisq.test(smk_table)
heart %>%
  mutate(
    smoking = factor(smoking, labels = c("Doesn't Smoke", "Smokes")),
    DEATH_EVENT = factor(DEATH_EVENT, labels = c("Survived", "Deceased"))
  ) %>%
  ggplot(aes(x = smoking, fill = DEATH_EVENT)) +
  geom_bar(position = "fill", alpha = 0.8) +
  scale_fill_manual(values = c("blue", "orange")) +
  labs(
    title = "Mortality Proportions by Smoking Status",
    x = "Clinical Status",
    y = "Proportion",
    fill = "Outcome"
  )
#Multivariate Analysis
ggplot(heart, aes(x = ejection_fraction, y = serum_creatinine, color = factor(DEATH_EVENT))) +
  geom_point(size = 2.5, alpha = 0.7) +
  scale_color_manual(values = c("0" = "green", "1" = "red"), labels = c("Survived", "Deceased")) +
  labs(
    title = "Risk Stratification Space",
    x = "Ejection Fraction (%)",
    y = "Serum Creatinine (mg/dL)",
    color = "Outcome"
  ) +
  geom_vline(xintercept = 30, linetype = "dashed", color = "grey40") +
  geom_hline(yintercept = 1.5, linetype = "dashed", color = "grey40") +
  annotate("text", x = 20, y = 8, label = "High Risk Zone", color = "red") +
  theme_minimal()

ggplot(heart, aes(x = log(creatinine_phosphokinase), y = serum_creatinine, color = factor(DEATH_EVENT))) +
  geom_point(size = 2.5, alpha = 0.7) +
  scale_color_manual(values = c("0" = "green", "1" = "red"), labels = c("Survived", "Deceased")) +
  labs(
    title = "Renal Function vs Acute Muscle Risk Space",
    x = "Log of Creatine Phosphokinase (mcg/L)",
    y = "Serum Creatinine (mg/dL)",
    color = "Outcome"
  ) +
  geom_vline(xintercept = 6.9, linetype = "dashed", color = "grey40") +
  geom_hline(yintercept = 1.5, linetype = "dashed", color = "grey40") +
  annotate("text", x = 7.8, y = 7, label = "High Risk Zone", color = "red") +
  theme_minimal()

ggplot(heart, aes(x = serum_sodium, y = serum_creatinine, color = factor(DEATH_EVENT))) +
  geom_point(size = 2.5, alpha = 0.7) +
  scale_color_manual(values = c("0" = "green", "1" = "red"), labels = c("Survived", "Deceased")) +
  labs(
    title = "Electroyle Balance vs Renal Function Risk Space",
    x = "Serum Sodium (mmol/L)",
    y = "Serum Creatinine (mg/dL)",
    color = "Outcome"
  ) +
  geom_vline(xintercept = 135, linetype = "dashed", color = "grey40") +
  geom_hline(yintercept = 1.5, linetype = "dashed", color = "grey40") +
  annotate("text", x = 125, y = 8, label = "High Risk Zone", color = "red") +
  theme_minimal()

ggplot(heart, aes(x = serum_sodium, y = log(creatinine_phosphokinase), color = factor(DEATH_EVENT))) +
  geom_point(size = 2.5, alpha = 0.7) +
  scale_color_manual(values = c("0" = "green", "1" = "red"), labels = c("Survived", "Deceased")) +
  labs(
    title = "Electroyle Balance vs Enzyms Risk Space",
    x = "Serum Sodium (mmol/L)",
    y = "Log of Creatine Phosphokinase (mcg/L)",
    color = "Outcome"
  ) +
  geom_vline(xintercept = 135, linetype = "dashed", color = "grey40") +
  geom_hline(yintercept = 6.9, linetype = "dashed", color = "grey40") +
  annotate("text", x = 125, y = 8, label = "High Risk Zone", color = "red") +
  theme_minimal()
