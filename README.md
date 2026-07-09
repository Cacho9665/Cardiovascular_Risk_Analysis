# Cardiovascular_Risk_Analysis
Analyzation of heart failure clinical records to find which variables had the biggest effect on overall health.

## Project Overview
This project analyzes a heart failure clinical records data set, [UCI Heart Failure Clinical Records dataset](https://github.com/vishnupriya62/DATASET-heart-failure-clinical-records/blob/main/heart_failure_clinical_records_dataset%20(1).csv), using Cox Proportional Hazards Model. Because of the nature of Survival Analysis this framework moves beyond predicting *if* a patient will face a mortality event, mapping out *when* and *how* compounding cardiovascular risk factors multiply a patient's baseline risk curve over time.
 
---

## Model Coefficients (From R `coxph`)
Before analysis, checks were conducted to be familiarized with the dataset seen in [here](C:/Users/Owner/Documents/EDA_Cardio.R). After exploring the data I kept the variables deemed significant, while Aneamia and Serum sodium weren't necessarly significant, as the p-value was greater than .05, I kept them in the model to preserve statistical power and because it didn't seen necessary to remove them. The coefficiants used in the interactive app are taken from Cox proportional hazard calculations:

| Clinical Feature | Log-Hazard Coefficient ($\beta$) | Hazard Ratio ($e^\beta$) | Clinical Interpretation |
| :--- | :--- | :--- | :--- |
| **Age** | `+0.04389` | `1.04` | Each additional year increases mortality hazard by ~4.4%. |
| **Ejection Fraction (%)** | `-0.04674` | `0.95` | Higher cardiac output acts as a strong protective factor. |
| **Serum Creatinine** | `+0.30432` | `1.36` | Increased levels multiply risk significantly. |
| **Serum Sodium** | `-0.04339` | `0.96` | Dropping levels (Hyponatremia) compound baseline systemic risk. |
| **High Blood Pressure** | `+0.47358` | `1.61` | History of hypertension scales baseline risk by 1.61x. |
| **Anemia** | `+0.37902` | `1.46` | Retained to preserve domain validity regarding oxygen-delivery strain. |

Below is the interactive streamlit dashboard [here](https://cardiovascularriskanalysis-bw6peparf8bz2y5v5x3l2p.streamlit.app/)
<img width="1797" height="898" alt="image" src="https://github.com/user-attachments/assets/6a1cc4a2-e2f6-4f0e-86d5-37a6d9385a21" />


---
## Summary
After going through all the variables we come out with 6 that are more significant to predicting mortality than any of the others. Age, Ejection Fraction, Serum Creatinine, Serum Sodium, High Blood Pressure, and Anemia. Of course age isn't something we can control, but the compounding effects of each of these health issues have a real hurtful effect on quality and length of life. Below is an example of how compounding issues affect the proportion of deaths, to the left of the vertical line and above the horizontal line are where issues start to arise.  

<img width="675" height="552" alt="image" src="https://github.com/user-attachments/assets/d427da1b-1796-4348-ad02-9c7e91294399" />
