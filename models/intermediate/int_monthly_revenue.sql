

with int_monthly_revenue as (
WITH orders AS (
    SELECT
        o.order_id,
        o.order_date
    FROM "northwind"."public"."stg_orders" o
),

order_details AS (
    SELECT
        od.order_id,
        od.quantity,
        od.unit_price,
        (od.quantity * od.unit_price) AS line_amount
    FROM "northwind"."public"."stg_order_details" od
),

order_amounts AS (
    SELECT
        od.order_id,
        SUM(od.line_amount) AS order_total_amount
    FROM order_details od
    GROUP BY od.order_id
),

monthly AS (
    SELECT
        DATE_TRUNC('month', o.order_date) AS month,
        COUNT(o.order_id) AS nb_commandes,
        SUM(oa.order_total_amount) AS ca_total,
        AVG(oa.order_total_amount) AS panier_moyen
    FROM orders o
    LEFT JOIN order_amounts oa
        ON oa.order_id = o.order_id
    GROUP BY DATE_TRUNC('month', o.order_date)
),

monthly_with_variation AS (
    SELECT
        month,
        nb_commandes,
        ca_total,
        panier_moyen,

        ca_total
        - LAG(ca_total) OVER (ORDER BY month)
            AS variation_vs_mois_prec
    FROM monthly
)

SELECT *
FROM monthly_with_variation
ORDER BY month
)
select * from int_monthly_revenue