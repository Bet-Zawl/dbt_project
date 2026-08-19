
{{ config(materialized='view') }}

WITH int_monthly_revenue AS (
    SELECT
        o.order_id as order_id, 
        o.order_date as order_date,
        DATE_TRUNC('month', o.order_date) AS mois,
        COUNT(od.order_id) AS nb_commandes,
        SUM(od.sous_total) AS ca_total,
        AVG(od.sous_total) AS panier_moyen
    FROM {{ ref('stg_orders') }} AS o
    JOIN {{ ref('stg_order_details') }} AS od
        ON o.order_id = od.order_id
    GROUP BY
    o.order_id,
    o.order_date
)

SELECT
    order_id,
    order_date,
    mois,
    nb_commandes,
    ca_total,
    panier_moyen,
    ca_total - LAG(ca_total) OVER (ORDER BY mois) AS variation_prec
FROM int_monthly_revenue
ORDER BY mois
