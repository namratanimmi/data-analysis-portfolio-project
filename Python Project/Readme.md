# 🏥 30-Day Hospital Readmission & Risk Analytics

[![Python](https://img.shields.io/badge/Python-3.9%2B-blue.svg)](https://www.python.org/)
[![Pandas](https://img.shields.io/badge/Pandas-2.0%2B-150458.svg)](https://pandas.pydata.org/)
[![Matplotlib](https://img.shields.io/badge/Matplotlib-Visualization-orange.svg)](https://matplotlib.org/)
[![Seaborn](https://img.shields.io/badge/Seaborn-Statistical%20Plots-blueviolet.svg)](https://seaborn.pydata.org/)

---

## 📌 Project Overview
Under value-based healthcare programs like the **Hospital Readmissions Reduction Program (HRRP)**, hospitals face regulatory reimbursement penalties of up to **3% across total Medicare inpatient billings** if their 30-day unplanned readmission rates exceed national benchmark thresholds (typically 15.0%–18.0%). Beyond regulatory fines, unplanned returns burden clinical staff, consume acute-care bed capacity, and generate uncompensated treatment costs.

This project analyzes **120,000 inpatient discharge encounters** across a 1-year timeline (2024). It builds an end-to-end data cleaning pipeline to resolve real-world electronic health record (EHR) anomalies, calculates executive healthcare KPIs, and presents actionable risk visualizations to help hospital leadership target pre-discharge interventions.

---

## 🎯 Executive KPIs

| # | KPI Name | Mathematical Formula | Project Result | Strategic Purpose |
| :-: | :--- | :--- | :-: | :--- |
| **1** | **Overall 30-Day Readmission Rate** | $\frac{\sum \text{Readmitted\_30\_Days}}{\text{Total Encounters}} \times 100$ | **19.00%** (Full) / **20.22%** (Complete-cases) | Primary quality metric; monitors baseline risk against the target threshold of 15.0%. |
| **2** | **Total Readmission Financial Exposure** | $\sum \text{Readmission\_Cost}$ | **~$369.4M** | Direct bed, procedural, and uncompensated clinical expenses tied to returning patients. |
| **3** | **Average Cost per Readmission** | $\frac{\text{Total Readmission Cost}}{\sum \text{Readmitted\_30\_Days}}$ | **~$16,202** | Quantifies expected secondary financial loss per returning encounter. |
| **4** | **High-Risk Diagnosis Readmission Rate** | $\frac{\sum \text{Readmissions for Condition } X}{\text{Total Encounters for Condition } X} \times 100$ | **19.2%** (Hip/Knee), **19.0%** (Heart Failure/COPD) | Pinpoints specific clinical specialties driving inpatient volume. |
| **5** | **Post-Discharge Follow-Up Gap** | $\text{Rate}(\text{No Follow-Up}) - \text{Rate}(\text{Follow-Up})$ | **+33.89%** (42.20% vs. 8.31%) | Quantifies clinical risk mitigation when outpatient checkups are scheduled prior to release. |

---

## 📊 Visualizations & Key Findings

### 1. Monthly Readmission Trend (Line Chart)
* **Finding:** Readmission rates remain stationary across all 12 months (~18.8% to 19.3%), remaining consistently above the 15.0% benchmark target.
* **Takeaway:** Excess readmissions stem from chronic systemic discharge gaps rather than localized seasonal spikes.

### 2. Clinical Exposure by Diagnosis (Dual-Axis Bar Chart)
* **Finding:** While condition-level readmission percentages hover around 19%, **Heart Failure** accounts for the largest aggregate financial loss due to high admission volume.
* **Takeaway:** Care coordination efforts should prioritize heart failure and pneumonia management protocols.

### 3. Post-Discharge Follow-Up Risk Gap (Bar Chart)
* **Finding:** Patients discharged without a scheduled follow-up appointment exhibit a **42.20% readmission rate**, compared to just **8.31%** for those with confirmed appointments.
* **Takeaway:** Scheduling outpatient appointments before discharge reduces readmission probability by over **33 percentage points**.

### 4. Risk Matrix Heatmap (Age Group vs. Prior Admissions)
* **Finding:** Patients aged **71+ with 3+ prior admissions in the last 12 months** represent the highest risk tier, with readmission rates exceeding **35%–40%**.
* **Takeaway:** Prior admission frequency combined with advanced age serves as the primary operational trigger for nurse-led transitional care management.

### 5. Readmission Cost by Admission Type (Boxplot / Donut)
* **Finding:** Emergency intakes generate the vast majority of secondary financial liability compared to planned elective procedures.

---

## 🧹 Data Cleaning Pipeline

The raw dataset contains **121,500 records** with simulated EHR system issues:
1. **Deduplication:** Dropped 1,500 duplicate primary keys (`subset=['Encounter_ID']`), preserving 120,000 unique encounters.
2. **Date Normalization:** Converted mixed international date strings (`YYYY-MM-DD`, `DD/MM/YYYY`, `MM-DD-YYYY`) into ISO datetime via `pd.to_datetime(df['Discharge_Date'], format='mixed')`.
3. **Categorical Standardization:** Applied lowercasing and dictionary mappings to collapse non-standard casing and abbreviations across `Gender` (3 classes), `Primary_Diagnosis` (5 clinical categories), and `Follow_Up_Scheduled` (Yes/No/Unknown).
4. **Outlier Mitigation:** Flagged invalid ages (`<= 0` or `> 110`) and medication codes (`999`) as anomalies.
5. **Null Strategy:** 
   * Imputed `Num_Prior_Admissions` with `0` (unrecorded EHR visits represent first-time admissions).
   * Binned age into standard cohorts (`Under 40`, `40-55`, `56-70`, `70+`) while labeling missing values as `Unknown` to preserve all 120,000 records without skewing demographic averages.

---

## 🚀 Getting Started

### 1. Clone Repository & Install Dependencies
```bash
git clone [https://github.com/your-username/hospital-readmission-analytics.git](https://github.com/your-username/hospital-readmission-analytics.git)
cd hospital-readmission-analytics
pip install -r requirements.txt
