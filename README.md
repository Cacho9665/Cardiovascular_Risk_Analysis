# Cardiovascular_Risk_Analysis

## Project Overview
This analysis evaluates 299 heart failure patient records from the [UCI Heart Failure Clinical Records dataset](https://github.com/vishnupriya62/DATASET-heart-failure-clinical-records/blob/main/heart_failure_clinical_records_dataset%20(1).csv) using a Cox Proportional Hazards Model. The objective is to identify key compounding clinical risk factors (e.g., ejection fraction and serum creatinine) to assist healtch care providers in stratifying patient mortality risk and prioritizing proactive intervention strategies.
 
---
## Summary
HR = Hazard ratio
* **Primary Risk Drivers:** High blood pressure (HR = 1.61) and elevated serum creatinine (HR = 1.36) are the strongest compounding predictors of mortality
* **Protective Factors:** Higher ejection fraction (HR = .95) significantly buffers mortality risk, where each unit increase reduces the baseline hazard by 5%.
* **Compounding Risk Threshold:** The top left of this image shows how compounded cardiovascular issues can greatly increase risk.
<img width="675" height="552" alt="image" src="https://github.com/user-attachments/assets/d427da1b-1796-4348-ad02-9c7e91294399" />

## Data Structure & Model Specification

### Dataset Overview
The analysis utilizes clinical records from $n = 299$ heart failure patients. The dataset includes demographic, clinical, and laboratory features captured during follow-up periods:

* **Target Variables:** Survival time (`time` in days) and death event (`DEATH_EVENT`: 0 = Survived, 1 = Deceased).
* **Key Clinical Features:** Age, Ejection Fraction, Serum Creatinine, Serum Sodium, High Blood Pressure, and Anemia.

### Cox Proportional Hazards Model Coefficients
A Cox Proportional Hazards regression (`coxph` in R) was fitted to quantify relative hazard ratios across significant clinical predictors. Non-statistically significant variables with high clinical relevance (e.g., Anemia, Serum Sodium) were retained to preserve statistical power and because they are crucial for accurately capturing the medical realities of body-wide oxygen levels and low blood sodium risks

| Clinical Feature | Log-Hazard Coefficient ($\beta$) | Hazard Ratio ($e^\beta$) | Clinical Interpretation |
| :--- | :--- | :--- | :--- |
| **Age** | `+0.04389` | `1.04` | Each additional year increases mortality hazard by ~4.4%. |
| **Ejection Fraction (%)** | `-0.04674` | `0.95` | Higher cardiac output acts as a strong protective factor. |
| **Serum Creatinine** | `+0.30432` | `1.36` | Increased levels multiply risk significantly. |
| **Serum Sodium** | `-0.04339` | `0.96` | Dropping levels (Hyponatremia) compound baseline systemic risk. |
| **High Blood Pressure** | `+0.47358` | `1.61` | History of hypertension scales baseline risk by 1.61x. |
| **Anemia** | `+0.37902` | `1.46` | Retained to preserve domain validity regarding oxygen-delivery strain. |
> **Technical Details:** Full Exploratory Data Analysis (EDA) and modeling scripts can be found in [`EDA_Cardio.R`](./EDA_Cardio.R) and [`Modeling_cardio.R`](./Modeling_cardio.R).
## Recommendations & Limitations
* **Clinical Monitoring:** Prioritize Serum Creatinine (routine renal function) and blood pressure monitoring for heart failure managment, as these represent the most actionable risk levers compared to unmodifiable factors like age.

* **Dashboard Deployment:** Implementing an interactive risk calculator into cilinical work areas would help nurses quickly flag high risk patient profiles based on blood tests.
[This](https://cardiovascularriskanalysis-bw6peparf8bz2y5v5x3l2p.streamlit.app/) is an interactive streamlit dashboard, like the one shown below.
<img width="1797" height="898" alt="image" src="https://github.com/user-attachments/assets/6a1cc4a2-e2f6-4f0e-86d5-37a6d9385a21" />

* **Data Constraints:** For a more accurate representation the sample size should be bigger and the demographic of patients in the dataset could be better. Because everyone in this dataset is ill to some degree, the averages on each clinical variable are more extreme than usually seen. The limiting age range is less of an issue because the average age of people significantly affected is going to be higher. 

---



