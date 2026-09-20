-- Sri Lanka Tourist Arrivals Dashboard - Database Schema
-- Creates the database and tables for the raw SLTDA data

CREATE DATABASE IF NOT EXISTS sl_tourism;
USE sl_tourism;

DROP TABLE IF EXISTS raw_monthly_summary;
CREATE TABLE raw_monthly_summary (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    month_num INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    arrivals INT NOT NULL,
    source_report VARCHAR(100)
);

DROP TABLE IF EXISTS raw_region;
CREATE TABLE raw_region (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    month_num INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    region VARCHAR(50) NOT NULL,
    arrivals INT NOT NULL,
    pct_share DECIMAL(5,2)
);

DROP TABLE IF EXISTS raw_top_markets;
CREATE TABLE raw_top_markets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    month_num INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    ranking INT,
    country VARCHAR(50) NOT NULL,
    by_air INT,
    by_sea INT,
    total INT NOT NULL,
    prior_year_same_month INT
);

DROP TABLE IF EXISTS raw_top_markets_annual;
CREATE TABLE raw_top_markets_annual (
    id INT AUTO_INCREMENT PRIMARY KEY,
    period_end_year INT NOT NULL,
    period_label VARCHAR(30) NOT NULL,
    ranking INT,
    country VARCHAR(50) NOT NULL,
    arrivals_current INT NOT NULL,
    arrivals_prior_period INT
);

DROP TABLE IF EXISTS raw_purpose;
CREATE TABLE raw_purpose (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    month_num INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    purpose VARCHAR(50) NOT NULL,
    pct_share DECIMAL(5,2)
);

DROP TABLE IF EXISTS raw_airports;
CREATE TABLE raw_airports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    month_num INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    airport VARCHAR(50) NOT NULL,
    pct_share DECIMAL(5,2)
);

DROP TABLE IF EXISTS raw_airlines;
CREATE TABLE raw_airlines (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    month_num INT NOT NULL,
    month_name VARCHAR(20) NOT NULL,
    airline VARCHAR(50) NOT NULL,
    pct_share DECIMAL(5,2)
);

-- date table, used later for time intelligence in Power BI
DROP TABLE IF EXISTS dim_date;
CREATE TABLE dim_date (
    date_key DATE PRIMARY KEY,
    year INT,
    month_num INT,
    month_name VARCHAR(20),
    quarter INT
);
