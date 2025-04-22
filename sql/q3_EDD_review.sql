CREATE TABLE IF NOT EXISTS incoming_payments (
    CustomerId BIGINT,
    Transaction_Datetime TIMESTAMP,
    Volume_Amount_USD NUMERIC(12, 3)
);

CREATE TABLE IF NOT EXISTS edd_reviews (
    CustomerId BIGINT PRIMARY KEY,
    EDD_Review_Time TIMESTAMP
);

WITH payments_with_cumsum AS (
  SELECT
    p.CustomerID,
    p.Transaction_Datetime,
    p.Volume_Amount_USD,
    r.EDD_Review_Time,
    SUM(p.Volume_Amount_USD) OVER (PARTITION BY p.CustomerID   
                            ORDER BY p.Transaction_Datetime ROWS BETWEEN UNBOUNDED PRECEDING 
                            AND CURRENT ROW) AS cumulative_usd
  FROM incoming_payments p
  LEFT JOIN edd_reviews r ON p.CustomerID = r.CustomerID
),

first_over_1000 AS (
  SELECT
    CustomerID,
    MIN(Transaction_Datetime) AS time_crossed_1000
  FROM payments_with_cumsum
  WHERE cumulative_usd >= 1000
  GROUP BY CustomerID
)

SELECT
  f.CustomerID,
  f.time_crossed_1000,
  r.EDD_Review_Time
FROM first_over_1000 f
JOIN EDD_Reviews r ON f.CustomerID = r.CustomerID
WHERE r.EDD_Review_Time > f.time_crossed_1000;
