# Cardiovascular_Risk_Analysis
Analyzation of heart failure clinical records to find which variables had the biggest effect on overall health.
# 🫀 Clinical Heart Failure Risk Stratification Framework

An end-to-end data science pipeline combining deep statistical survival modeling in R with a production-ready predictive web application deployed via Python and Streamlit.

## 📌 Project Overview
This project shifts away from traditional, snapshot binary classification to implement an **Advanced Clinical Pipeline (Survival Analysis)** using a **Cox Proportional Hazards Model**. By analyzing a cohort from the [UCI Heart Failure Clinical Records dataset](https://github.com/vishnupriya62/DATASET-heart-failure-clinical-records/blob/main/heart_failure_clinical_records_dataset%20(1).csv), the framework moves beyond predicting *if* a patient will face a mortality event, mapping out *when* and *how* compounding cardiorenal risk factors multiply a patient's baseline risk curve over time.

### Key Architecture
*   **Phase A (Exploratory Data Analysis):** Discovered severe right-skewness in Biomarkers (CPK) necessitating log-transformations, and mapped out intersecting risk danger zones.
*   **Phase B (Comparative Modeling):** Implemented a dual-paradigm framework comparing a Random Forest Classifier against a Cox Proportional Hazards Model to preserve temporal data validity.
*   **Phase C (Production Deployment):** Extracted mathematical coefficients from the R survival model to build a responsive, client-facing clinical calculator in Python.

---

## 📊 Model Coefficients (From R `coxph`)
The underlying mathematical weights utilized in the interactive application are derived directly from the Cox proportional hazard calculations:

| Clinical Feature | Log-Hazard Coefficient ($\beta$) | Hazard Ratio ($e^\beta$) | Clinical Interpretation |
| :--- | :--- | :--- | :--- |
| **Age** | `+0.04389` | `1.04` | Each additional year increases mortality hazard by ~4.4%. |
| **Ejection Fraction (%)** | `-0.04674` | `0.95` | Higher cardiac output acts as a strong protective factor. |
| **Serum Creatinine** | `+0.30432` | `1.36` | Elevated metrics (renal strain) multiply risk significantly. |
| **Serum Sodium** | `-0.04339` | `0.96` | Dropping levels (Hyponatremia) compound baseline systemic risk. |
| **High Blood Pressure** | `+0.47358` | `1.61` | History of hypertension scales baseline risk by 1.61x. |
| **Anemia** | `+0.37902` | `1.46` | Retained to preserve domain validity regarding oxygen-delivery strain. |

---

## 🛠️ Repository Structure
```directory
├── CardioVasc_App.py          # Production Python Streamlit Web Dashboard
├── heart_failure_analysis.R    # Phase A/B R Script (EDA, Splits, Random Forest, CoxPH)
├── README.md                   # Professional Portfolio Documentation
└── heart_failure_dataset.csv  # Local source data asset
