# 🏦 Bank Customer Churn & Retention Analysis (SQL + Excel / Google Sheets)

## 📌 Project Overview
An end-to-end retail banking data analysis project investigating the root causes of customer attrition across a **10,000-customer European retail banking portfolio** (France, Germany, and Spain). Using **SQL** for data auditing, cleaning, feature engineering, and cohort segmentation, paired with **Excel / Google Sheets** for interactive dashboarding, this project quantifies deposit outflow and outlines actionable retention strategies.

---

## 🎯 Business Problem & Objective
* **Context:** A retail bank is experiencing an elevated customer churn rate of **20.37%** (2,037 lost accounts out of 10,000), resulting in **$185.59M in lost deposit balances**—roughly **24.3%** of the bank's total $764.86M deposit base. Because acquiring a new banking customer costs ~5x more than retaining an existing one, reducing preventable attrition is critical to protecting net interest income and cross-selling revenue.
* **Objective:** Audit and clean raw customer records, segment customers across demographics, balances, product holdings, and engagement levels, and build an executive KPI dashboard that isolates high-risk churn cohorts.
* **Core Analytical Questions:**
  1. Which geographic markets, age brackets, and gender segments exhibit the highest churn rates?
  2. How do account balance size and tenure correlate with customer attrition?
  3. What is the optimal number of banking products for retention before over-bundling backfires?
  4. How strongly does active account engagement (`IsActiveMember`) mitigate churn across funded balance tiers?

---

## 🛠️ Tech Stack & Workflow
* **SQL (SQL Server / PostgreSQL / MySQL):**
  * Audited raw staging data (`10,040` rows) to detect and resolve exact/partial duplicates (`ROW_NUMBER() OVER (PARTITION BY CustomerId)`), missing values (`NULL`s), text inconsistencies (`TRIM`, `UPPER`), and out-of-range anomalies (`Age`, `CreditScore`, `Balance`).
  * Engineered analytical segments (`Age_Group`, `Balance_Tier`, `Credit_Category`, `Activity_Status`, `Churn_Status`) via `CASE WHEN`.
  * Built executive KPI aggregations and multi-dimensional risk rankings using **CTEs** and **Window Functions** (`RANK()`, `SUM() OVER ()`).
* **Excel / Google Sheets:**
  * Structured a 3-tab portfolio workbook (`DASHBOARD`, `Pivots`, `Bank_Churn_Clean`).
  * Built dynamic **KPI Cards**, **Pivot Tables**, **4 Core Visuals** (Clustered Column, Combo Chart, 100% Stacked Column, Grouped Bar), and interactive **Slicers** (`Geography`, `Gender`, `Activity Status`, `HasCrCard`).

---

## 📊 Executive Baseline KPIs

| KPI Metric | Exact Value | Business Significance |
| :--- | :---: | :--- |
| **Total Customers** | **10,000** | Portfolio baseline across France (5,014), Germany (2,509), and Spain (2,477) |
| **Churned Customers** | **2,037** | Total volume of exited accounts |
| **Overall Churn Rate** | **20.37%** | Primary North Star retention benchmark |
| **Retention Rate** | **79.63%** | Proportion of active retained customer base |
| **Total Deposit Balance Lost** | **$185,588,094.63** | ~24.3% of total bank deposits ($764.86M) withdrawn by churned clients |
| **Avg. Balance (Churned vs. Retained)** | **$91,108.54 vs. $72,745.30** | Affluent, higher-balance depositors exit at significantly higher rates |

---

## 🔍 Key Analytical Findings

1. **Geographic Crisis in Germany (32.44% Churn):**
   * Germany recorded a **32.44% churn rate** (814 of 2,509 exited)—**double** that of France (**16.15%**) and Spain (**16.67%**)[cite: 1, 2]—while holding the highest average account balance (**$119,730.12**)[cite: 2].
2. **Pre-Retirement Surge in Ages 46–60 (51.12% Churn):**
   * While the `31–45` age group holds the largest customer volume (5,921 clients, 15.74% churn)[cite: 2], attrition spikes dramatically to **51.12%** among customers aged **46–60** (842 of 1,647 exited)[cite: 1, 2].
3. **The 2-Product Sweet Spot vs. Over-Bundling Trap:**
   * Customers holding **2 products** achieve the lowest churn rate at **7.58%**, compared to **27.71%** for single-product holders[cite: 1, 2]. However, holding **3 products (82.71% churn)** or **4 products (100.00% churn)** triggers near-total attrition[cite: 1, 2].
4. **Engagement Nearly Halves Attrition:**
   * Inactive members churn at **26.85%** (1,302 of 4,849), nearly double the **14.27%** churn rate of active members (735 of 5,151)[cite: 1, 2]. Across every funded balance tier (`$1–$75K`, `$75K–$150K`, `$150K+`), inactive clients churn at **~30%–33.5%** vs. **~16.3%–17.1%** for active clients[cite: 1].
5. **Tenure & Credit Score Have Negligible Impact:**
   * Account tenure (0–10 years, avg. 5.01 years) shows a flat **~19%–22%** churn rate across every tenure year, proving that long tenure alone does not protect against churn. Female customers also exhibit higher attrition (**25.07%**) than male customers (**16.46%**)[cite: 1, 2].

---

## 💡 Strategic Recommendations

* **1. Audit German Operations & Assign Relationship Managers:** Investigate local fee structures and competitor rates in Germany, and assign dedicated relationship managers to high-balance German depositors ($119.7K+ average)[cite: 1, 2].
* **2. Launch Pre-Retirement Advisory Outreach (Ages 40–45):** Proactively engage clients with wealth-preservation, pension, and retirement planning consultations before they enter the high-risk `46–60` bracket[cite: 1, 2].
* **3. Optimize Cross-Selling to 2 Core Products:** Target single-product holders (`27.71%` churn) with tailored second-product bundles (e.g., checking + credit card) to reach the **7.58% churn** sweet spot while halting aggressive 3+ product bundling[cite: 1, 2].
* **4. Automate 60-Day Inactivity Nudges:** Trigger personalized digital re-engagement alerts, cashback incentives, and fee waivers when funded account holders show early signs of inactivity[cite: 1].

---

## 📂 Repository Structure
```text
├── data/
│   ├── Bank_Churn_Dirty.csv          # Raw staging dataset (10,040 rows with duplicates & anomalies)
│   └── Bank_Churn_Clean.csv          # Cleaned & feature-engineered dataset (10,000 unique customers)
├── sql/
│   └── bank_churn_analysis.sql       # Data cleaning, segmentation views, KPI & window-function queries
├── dashboard/
│   ├── Bank_Churn_Dashboard.xlsx     # Interactive workbook (DASHBOARD, Pivots, Bank_Churn_Clean)
│   └── dashboard_preview.png         # Executive dashboard screenshot
└── README.md                         # Project documentation & business findings
