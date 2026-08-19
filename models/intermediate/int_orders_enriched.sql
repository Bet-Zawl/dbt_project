{{ config(materialized='view') }}

WITH int_orders_enriched AS (
    SELECT
        o.order_id,
        o.customer_id,
        o.employee_id,
        o.order_date,
        o.required_date,
        o.shipped_date,
        o.ship_via,
        o.freight,
        o.ship_city,
        o.ship_country,
        o.is_shipped,

        /* Nombre de lignes dans la commande */
        COUNT(od.order_id) AS nb_articles,

        /* Quantité totale */
        SUM(od.quantity) AS quantite_totale,

        /* Montant total */
        SUM(od.sous_total) AS montant_total,

        /* Délai de livraison en jours */
        CASE 
            WHEN o.shipped_date IS NULL OR o.order_date IS NULL THEN NULL
            ELSE (o.required_date - o.shipped_date)
        END AS delai_livraison_jours,
 

        /* Livraison à temps */
        CASE
            WHEN o.shipped_date IS NULL OR o.required_date IS NULL THEN NULL
            WHEN o.shipped_date <= o.required_date THEN TRUE
            ELSE FALSE
        END AS is_on_time

    FROM {{ ref('stg_orders') }} o
    LEFT JOIN {{ ref('stg_order_details') }} od
        ON o.order_id = od.order_id
    GROUP BY
        o.order_id,
        o.customer_id,
        o.employee_id,
        o.order_date,
        o.required_date,
        o.shipped_date,
        o.ship_via,
        o.freight,
        o.ship_city,
        o.ship_country,
        o.is_shipped
)

SELECT *
FROM int_orders_enriched

