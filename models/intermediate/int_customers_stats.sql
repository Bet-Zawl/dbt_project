with int_customers_stats as (

WITH orders_enriched AS (
    SELECT
        o.customer_id,
        o.order_id,
        o.order_date,
        o.ship_country,
        o.required_date,
        o.shipped_date,
        o.freight,
        o.ship_via,
        o.is_shipped,
        o.ship_address,
        o.ship_city,
        o.ship_region,
        


        -- Montant de la commande
        SUM(od.unit_price * od.quantity * (1 - COALESCE(od.discount, 0))) AS order_amount
    FROM stg_orders o
    JOIN stg_order_details od
        ON o.order_id = od.order_id
    GROUP BY
        o.customer_id,
        o.order_id,
        o.order_date,
        o.ship_country,
        o.required_date,
        o.shipped_date,
        o.freight,
        o.ship_via,
        o.is_shipped,
        o.ship_address,
        o.ship_city,
        o.ship_region
),

orders_with_lag AS (
    SELECT
        customer_id,
        ship_country,
        order_id,
        order_date,
        order_amount,

        -- Date de la commande précédente
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_date

    FROM orders_enriched
)

SELECT
    customer_id,

    COUNT(order_id) AS nb_commandes,
    SUM(order_amount) AS ca_total,

    MIN(order_date) AS premiere_commande,
    MAX(order_date) AS derniere_commande,

    -- Délai moyen entre commandes (en jours)
    AVG(order_date - previous_order_date) AS delai_moyen

FROM orders_with_lag
GROUP BY customer_id
ORDER BY customer_id

)
select * 
from int_customers_stats