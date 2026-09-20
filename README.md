# Sri Lanka Tourism Arrivals & Market Insights Dashboard

An end-to-end data analytics project transforming 31+ months of fragmented 
SLTDA (Sri Lanka Tourism Development Authority) monthly PDF reports into a 
structured, analysis-ready dataset and an interactive Power BI dashboard.

---

## 📌 Project Overview

Sri Lanka's tourism authority publishes monthly arrival reports as PDFs — 
each containing 10+ tables scattered across 20+ pages with inconsistent 
formatting. Analyzing trends across months required manually stitching 
data together.

This project:
- **Extracts** data from 22+ PDF reports (Jan 2024 – Jul 2026)
- **Cleans & normalizes** 7 fact tables into a consistent schema
- **Models** key tourism metrics using DAX
- **Visualizes** insights in an interactive Power BI dashboard

---

## 🎯 Business Questions Answered

1. **Which source markets drive Sri Lanka's tourism** — and how concentrated is the market?
2. **How does seasonality affect arrivals** across months and quarters?
3. **How has tourism recovered** year-over-year since 2024?
4. **What are travelers' purposes** (leisure, MICE, VFR, business)?
5. **Which airlines and departure hubs** dominate inbound travel?
6. **How does regional mix** (Europe, Asia-Pacific, Americas) shift over time?

---

## 🗂️ Dataset

**Source:** Sri Lanka Tourism Development Authority (SLTDA) — Monthly Tourist Arrivals Reports  
**Coverage:** January 2024 – July 2026 (31 months)  
**Reports parsed:** 22+ PDFs  
**Records:** ~5,000+ rows across 7 tables

### Data Model (7 Tables)

| Table | Description | Rows |
|-------|-------------|------|
| `raw_monthly_summary` | Total arrivals per month | 31 |
| `raw_region` | Arrivals by world region | ~150 |
| `raw_top_markets` | Top 10 source countries (monthly) | ~310 |
| `raw_top_markets_annual` | Cumulative top 10 markets (annual) | 30 |
| `raw_purpose` | Purpose of visit breakdown (%) | ~270 |
| `raw_airports` | Main last-departure airports (%) | ~250 |
| `raw_airlines` | Main airlines used (%) | ~220 |

---

## 🛠️ Tech Stack

| Layer | Tool |
|-------|------|
| Data Extraction | Manual PDF parsing + Excel |
| ETL / Transformation | **Power Query** |
| Data Modeling | **Power BI (star schema)** |
| Calculations | **DAX** (measures + calculated columns) |
| Visualization | **Power BI** |
| Version Control | Git / GitHub |

---

## 📊 Dashboard Features

### Page 1 — Executive Summary
- KPI cards: Total arrivals, YoY growth %, top source market
- Monthly arrivals trend line (2024–2026)
- Regional share donut chart

### Page 2 — Source Market Analysis
- Top 10 source countries bar chart
- Market concentration (top 3 share)
- Country-level YoY growth matrix

### Page 3 — Seasonality & Purpose
- Monthly heatmap by region
- Purpose-of-visit breakdown (leisure, MICE, VFR, business)
- Purpose × source market cross-tab

### Page 4 — Travel Logistics
- Top departure airports
- Airline market share
- Hub dependency analysis

**Interactive elements:** Slicers for year, month, region, and country with cross-filtering.

---

## 🔑 Key Insights

- **India dominates** as the #1 source market (~20% share) with strong YoY growth
- **Europe accounts for ~50%** of arrivals, with the UK, Germany, and France leading
- **Seasonality is pronounced** — peak arrivals in Jan/Feb and Aug, dips in May–June
- **2025 shows ~15% YoY recovery** vs. 2024, signaling sustained post-pandemic rebound
- **Middle Eastern hubs (Dubai, Doha, Abu Dhabi)** handle ~30% of inbound traffic, indicating dependency on Gulf carriers

---

## 🧹 Data Cleaning Notes

The raw extraction (raw_data_FINAL.xlsx) contained several naming inconsistencies across reports published over 32 months, since SLTDA's own formatting varied slightly year to year — for example:

-Russia vs Russian Federation
-Doha vs Doha Qatar
-Four different spellings of SriLankan Airlines across different reports

These were standardized in cleaned_data.xlsx before loading into SQL, so downstream totals and charts aren't silently split across duplicate categories.

---
