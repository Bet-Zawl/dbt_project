-- 2: Validation du nombre de commandes (OLTP vs DWH)

SELECT COUNT(*) AS dwh_nb_orders
FROM {{ref('fact_orders')}};

SELECT COUNT(*) AS oltp_nb_orders
FROM {{ref('stg_orders')}};