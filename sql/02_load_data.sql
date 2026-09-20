-- Load the cleaned CSV data into the tables

USE sl_tourism;

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'D:/Sri Lanka Tourist Arrivals & Market Insights/sl_tourism_csv/raw_monthly_summary.csv'
INTO TABLE raw_monthly_summary
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(year, month_num, month_name, arrivals, source_report);

LOAD DATA LOCAL INFILE 'D:/Sri Lanka Tourist Arrivals & Market Insights/sl_tourism_csv/raw_region.csv'
INTO TABLE raw_region
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(year, month_num, month_name, region, arrivals, pct_share);

LOAD DATA LOCAL INFILE 'D:/Sri Lanka Tourist Arrivals & Market Insights/sl_tourism_csv/raw_top_markets.csv'
INTO TABLE raw_top_markets
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(year, month_num, month_name, ranking, country, by_air, by_sea, total, prior_year_same_month);

LOAD DATA LOCAL INFILE 'D:/Sri Lanka Tourist Arrivals & Market Insights/sl_tourism_csv/raw_top_markets_annual.csv'
INTO TABLE raw_top_markets_annual
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(period_end_year, period_label, ranking, country, arrivals_current, arrivals_prior_period);

LOAD DATA LOCAL INFILE 'D:/Sri Lanka Tourist Arrivals & Market Insights/sl_tourism_csv/raw_purpose.csv'
INTO TABLE raw_purpose
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(year, month_num, month_name, purpose, pct_share);

LOAD DATA LOCAL INFILE 'D:/Sri Lanka Tourist Arrivals & Market Insights/sl_tourism_csv/raw_airports.csv'
INTO TABLE raw_airports
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(year, month_num, month_name, airport, pct_share);

LOAD DATA LOCAL INFILE 'D:/Sri Lanka Tourist Arrivals & Market Insights/sl_tourism_csv/raw_airlines.csv'
INTO TABLE raw_airlines
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(year, month_num, month_name, airline, pct_share);

-- build the date table from the monthly summary data
INSERT INTO dim_date (date_key, year, month_num, month_name, quarter)
SELECT DISTINCT
    STR_TO_DATE(CONCAT(year, '-', month_num, '-01'), '%Y-%m-%d') AS date_key,
    year, month_num, month_name,
    QUARTER(STR_TO_DATE(CONCAT(year, '-', month_num, '-01'), '%Y-%m-%d')) AS quarter
FROM raw_monthly_summary;

-- check row counts loaded into each table
SELECT 'raw_monthly_summary' AS tbl, COUNT(*) AS rows_loaded FROM raw_monthly_summary
UNION ALL SELECT 'raw_region', COUNT(*) FROM raw_region
UNION ALL SELECT 'raw_top_markets', COUNT(*) FROM raw_top_markets
UNION ALL SELECT 'raw_top_markets_annual', COUNT(*) FROM raw_top_markets_annual
UNION ALL SELECT 'raw_purpose', COUNT(*) FROM raw_purpose
UNION ALL SELECT 'raw_airports', COUNT(*) FROM raw_airports
UNION ALL SELECT 'raw_airlines', COUNT(*) FROM raw_airlines;
