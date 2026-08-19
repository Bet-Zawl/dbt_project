-- 1: Validation du CA total (OLTP vs DWH)

-- CA total dans le DWH
SELECT SUM(round(montant_total)::numeric(12, 2)) AS dwh_ca_total
FROM {{ref('fact_orders')}};


-- CA total dans l’OLTP
SELECT SUM(round(unit_price * quantity * (1 - discount))::numeric(12,2)) AS oltp_ca_total
FROM {{('stg_order_details')}};