
import streamlit as st
import numpy as np

# context
st.title("Clinical Heart Failure Risk Calculator")
st.write("This is an interactive dashboard that estimates a patient's relative mortality hazard based on cardiorenal biometric data.")
st.markdown("---")

# Vital inputs
#continuous
st.sidebar.header("Patient Biometric Data")
age = st.sidebar.slider("Age", 40, 95, 65)
ef = st.sidebar.slider("Ejection Fraction (%)", 10, 80, 35)
creatinine = st.sidebar.slider("Serum Creatinine (mg/dL)", 0.5, 9.5, 1.2, step = 0.1)
sodium = st.sidebar.slider("Serum Sodium (mEq/L)", 110, 150, 137)
#binary
hbp = st.sidebar.selectbox("High Blood Pressure History? (Yes/No)", ["No", "Yes"])
anemia = st.sidebar.selectbox("Anemia? (Yes/No)", ["No", "Yes"])

hbp_val = 1 if hbp == "Yes" else 0
anemia_val = 1 if anemia == "Yes" else 0

hazard_eq = ((.04389694*age) + (-.04674244*ef) + (.30432512*creatinine) + (-.04339366*sodium) + (.47358261*hbp_val) + (.37902147*anemia_val))

#relative Hazard
relative_hazard = np.exp(hazard_eq)

hazard_delta = relative_hazard - 1.0

st.subheader("Patient's Risk Stratification Analysis")

col1, col2 = st.columns([1, 1])
with col1:
    st.metric(
        label = "Calculated Relative Hazard", 
        value = f"{relative_hazard:.2f}x", 
        delta = f"{hazard_delta:+.2f} vs Baseline", 
        delta_color = "inverse" # Red when positive (elevated hazard), green when negative
    )
with col2:
    is_high_risk = (ef<30) or (creatinine>1.5) or (sodium<135)

    if is_high_risk:
        st.error("Patient is at High Risk of Mortality")
        st.markdown("**Key Risk Factors Identified:**")
        if ef<30:
            st.markdown("- Severely Reduced Ejection Fraction (<30%)")
        if creatinine>1.5:
            st.markdown("- Elevated Serum Creatinine (>1.5 mg/dL)")
        if sodium<135:
            st.markdown("- Hyponatremia (<135 mEq/L)")
    else:
        st.success("Risk Status: Stable/Baseline ")
        st.markdown("Patients variables currently remain within manageable baseline ranges.")
st.markdown("---")
st.caption("**Disclaimer: This tool is a prototype designed for software portfolio demonstration and data pipeline validation purposes.**")
st.caption("**It is built using data from the set UCI Heart Failure Clinical Records dataset.**")