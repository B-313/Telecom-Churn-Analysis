-- TELECOM CUSTOMER CHURN ANALYSIS
-- Analysis of 7,043 customers to identify retention opportunities
-- Created: February 2026

-- Quick data overview
SELECT * FROM customers LIMIT 10;

-- Total customer count and churn breakdown
SELECT 
    Churn,
    COUNT(*) as customer_count,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customers), 1) as percentage
FROM customers
GROUP BY Churn;


-- KEY FINDING: CONTRACT TYPE DRIVES CHURN 
(INSIGHT: Month-to-month customers churn at 42.7% vs 2.8% for two-year contracts)


-- Churn rate by contract type
SELECT 
    Contract,
    COUNT(*) as total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) as churn_rate_percent,
    ROUND(AVG(MonthlyCharges), 2) as avg_monthly_charge
FROM customers
GROUP BY Contract
ORDER BY churn_rate_percent DESC;


-- REVENUE IMPACT ANALYSIS
(FINDING: £1.45M annual revenue at risk from month-to-month churn)

-- Calculate revenue at risk by contract type
SELECT 
    Contract,
    COUNT(*) as total_customers,
    SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) as churned_customers,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END), 2) as monthly_revenue_lost,
    ROUND(SUM(CASE WHEN Churn = 'Yes' THEN MonthlyCharges ELSE 0 END) * 12, 2) as annual_revenue_at_risk
FROM customers
GROUP BY Contract
ORDER BY annual_revenue_at_risk DESC;


-- END OF ANALYSIS
