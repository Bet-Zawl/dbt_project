--Requêtes analytiques sur le DWH avec résultats corrects	

-- 1: Validation du CA total (OLTP vs DWH)

-- CA total dans le DWH
SELECT SUM(round(montant_total)::numeric(12, 2)) AS dwh_ca_total
FROM fact_orders;

-- CA total dans l’OLTP
SELECT SUM(round(unit_price * quantity * (1 - discount))::numeric(12,2)) AS oltp_ca_total
FROM stg_order_details;

-- 2: Validation du nombre de commandes (OLTP vs DWH)

SELECT COUNT(*) AS dwh_nb_orders
FROM fact_orders;

SELECT COUNT(*) AS oltp_nb_orders
FROM stg_orders;


-- 3: Validation du CA mensuel (agrégation temporelle)

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(round(montant_total)::numeric(12, 2)) AS ca_total
FROM fact_orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- 4: Validation du panier moyen (CA / nb commandes)

SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(round(montant_total)::numeric(12, 2)) / COUNT(order_id) AS panier_moyen
FROM fact_orders
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY month;

-- 5: Validation de la fraîcheur des données (latence)

SELECT 
    MAX(order_date) AS last_order_source,
    (SELECT MAX(order_date) FROM fact_orders) AS last_order_dwh
FROM stg_orders;











