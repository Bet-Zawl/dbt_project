-- 3: Validation du CA mensuel (agrégation temporelle)

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(round(montant_total)::numeric(12, 2)) AS ca_total
FROM {{ref('fact_orders')}}
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;