USE sl_tourism;

-- top source markets overall
SELECT country, SUM(total) AS total_arrivals
FROM raw_top_markets
GROUP BY country
ORDER BY total_arrivals DESC
LIMIT 10;

-- YoY growth by country using the annual cumulative table
SELECT
    country,
    period_end_year,
    arrivals_current,
    arrivals_prior_period,
    ROUND(100.0 * (arrivals_current - arrivals_prior_period) / NULLIF(arrivals_prior_period,0), 2) AS yoy_pct
FROM raw_top_markets_annual
ORDER BY country, period_end_year;

-- seasonality: average arrivals by calendar month across all years
SELECT month_num, month_name, ROUND(AVG(arrivals)) AS avg_arrivals
FROM raw_monthly_summary
GROUP BY month_num, month_name
ORDER BY month_num;

-- total arrivals by year
SELECT
    year,
    SUM(arrivals) AS total_arrivals,
    COUNT(*) AS months_included
FROM raw_monthly_summary
GROUP BY year
ORDER BY year;

-- region share over time
SELECT year, month_num, region, arrivals, pct_share
FROM raw_region
ORDER BY year, month_num, arrivals DESC;

-- purpose of visit trend, leisure share specifically
SELECT year, month_num, purpose, pct_share
FROM raw_purpose
WHERE purpose = 'Pleasure/Vacation'
ORDER BY year, month_num;

-- top departure airports overall
SELECT airport, ROUND(AVG(pct_share),2) AS avg_pct_share, COUNT(*) AS months_present
FROM raw_airports
GROUP BY airport
ORDER BY avg_pct_share DESC
LIMIT 10;

-- top airlines overall
SELECT airline, ROUND(AVG(pct_share),2) AS avg_pct_share, COUNT(*) AS months_present
FROM raw_airlines
GROUP BY airline
ORDER BY avg_pct_share DESC
LIMIT 10;

-- month over month percent change
SELECT
    d.date_key,
    m.arrivals,
    LAG(m.arrivals) OVER (ORDER BY d.date_key) AS prev_month_arrivals,
    ROUND(100.0 * (m.arrivals - LAG(m.arrivals) OVER (ORDER BY d.date_key))
        / NULLIF(LAG(m.arrivals) OVER (ORDER BY d.date_key),0), 2) AS mom_pct_change
FROM raw_monthly_summary m
JOIN dim_date d ON d.year = m.year AND d.month_num = m.month_num
ORDER BY d.date_key;

-- India's share of total arrivals over time
SELECT
    t.year, t.month_num,
    t.total AS india_arrivals,
    s.arrivals AS total_arrivals,
    ROUND(100.0 * t.total / s.arrivals, 2) AS india_pct_share
FROM raw_top_markets t
JOIN raw_monthly_summary s ON s.year = t.year AND s.month_num = t.month_num
WHERE t.country = 'India'
ORDER BY t.year, t.month_num;
