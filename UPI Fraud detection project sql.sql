SELECT * FROM upi_fraud_db.transactions;
use upi_fraud_db;

-- Query 1 — Overall Business KPIs
SELECT 
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(amount), 0) AS Total_Amount,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(CASE WHEN is_fraud=1 THEN amount ELSE 0 END), 0) AS Fraud_Amount,
    ROUND(AVG(amount), 0) AS Avg_Transaction_Value
FROM transactions;

-- Query 2 — Fraud by Merchant Category


SELECT 
    Merchant_Category,
    COUNT(*) AS Total_Transactions,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(CASE WHEN is_fraud=1 THEN amount ELSE 0 END), 0) AS Fraud_Amount
FROM transactions
GROUP BY Merchant_Category
ORDER BY Fraud_Rate_Pct DESC;

-- Query 3 — Fraud by Transaction Type


SELECT 
    Transaction_Type,
    COUNT(*) AS Total_Transactions,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(CASE WHEN is_fraud=1 THEN amount ELSE 0 END), 0) AS Fraud_Amount
FROM transactions
GROUP BY Transaction_Type
ORDER BY Fraud_Rate_Pct DESC;
-- Query 4 — Fraud by Amount Band

SELECT 
    Amount_Band,
    COUNT(*) AS Total_Transactions,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct,
    ROUND(AVG(amount), 0) AS Avg_Amount
FROM transactions
GROUP BY Amount_Band
ORDER BY Fraud_Rate_Pct DESC;
-- Query 5 — Fraud by Time of Day

SELECT 
    Time_Slot,
    COUNT(*) AS Total_Transactions,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct
FROM transactions
GROUP BY Time_Slot
ORDER BY Fraud_Rate_Pct DESC;

-- Query 6 — Fraud by Payment Channel

SELECT 
    Payment_Channel,
    COUNT(*) AS Total_Transactions,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(CASE WHEN is_fraud=1 THEN amount ELSE 0 END), 0) AS Fraud_Amount
FROM transactions
GROUP BY Payment_Channel
ORDER BY Fraud_Rate_Pct DESC;

-- Query 7 — Fraud by Authentication Method

SELECT 
    Auth_Method,
    Pin_Entry,
    COUNT(*) AS Total_Transactions,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct
FROM transactions
GROUP BY Auth_Method, Pin_Entry
ORDER BY Fraud_Rate_Pct DESC;

-- Query 8 — State-wise Fraud

SELECT 
    State,
    COUNT(*) AS Total_Transactions,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(CASE WHEN is_fraud=1 THEN amount ELSE 0 END), 0) AS Fraud_Amount
FROM transactions
GROUP BY State
ORDER BY Fraud_Count DESC
LIMIT 10;
-- Queryry 9 — Risk Tier Analysis

SELECT 
    Risk_Tier,
    COUNT(*) AS Total_Transactions,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct,
    ROUND(AVG(amount), 0) AS Avg_Amount,
    ROUND(SUM(CASE WHEN is_fraud=1 THEN amount ELSE 0 END), 0) AS Fraud_Amount
FROM transactions
GROUP BY Risk_Tier
ORDER BY Fraud_Rate_Pct DESC;
-- Query 10 — Handle Verification Impact

SELECT 
    Handle_Verification,
    COUNT(*) AS Total_Transactions,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct,
    ROUND(SUM(CASE WHEN is_fraud=1 THEN amount ELSE 0 END), 0) AS Fraud_Amount
FROM transactions
GROUP BY Handle_Verification
ORDER BY Fraud_Rate_Pct DESC;
-- Query 11 — Flag Score Impact

SELECT 
    Flag_Label,
    COUNT(*) AS Total_Transactions,
    SUM(is_fraud) AS Fraud_Count,
    ROUND(AVG(is_fraud)*100, 2) AS Fraud_Rate_Pct
FROM transactions
GROUP BY Flag_Label
ORDER BY Fraud_Rate_Pct DESC;

-- Query 12 — Top 10 Highest Fraud Transactions

SELECT 
    transaction_id,
    amount,
    Merchant_Category,
    State,
    Time_Slot,
    Risk_Tier,
    Handle_Verification,
    Flag_Label
FROM transactions
WHERE is_fraud = 1
ORDER BY amount DESC
LIMIT 10;