-- 5: Validation de la fraîcheur des données (latence)

SELECT 
    MAX(order_date) AS last_order_source,
    (SELECT MAX(order_date) FROM fact_orders) AS last_order_dwh
FROM {{ref('stg_orders')}};