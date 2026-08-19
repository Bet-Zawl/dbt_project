-- 4: Validation du panier moyen (CA / nb commandes)

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(round(montant_total)::numeric(12, 2)) / COUNT(order_id) AS panier_moyen
FROM {{ref('fact_orders')}}
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;