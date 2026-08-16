
{{ config(materialized='table') }}

WITH fact_orders AS (
    SELECT
    --intermediate orders enriched
        oe.order_id,
        oe.customer_id,
        oe.employee_id,
        oe.ship_via,
        oe.order_date,
        oe.required_date,
        oe.shipped_date,
        oe.ship_city,
        oe.ship_country,
        oe.freight,
        oe.is_shipped,
        oe.is_on_time,
        oe.delai_livraison_jours,
        oe.nb_articles,
        oe.quantite_totale,
        oe.montant_total,
        /* Calcul du montant total avec frais */
        (oe.montant_total + oe.freight) AS montant_total_avec_frais
    FROM {{ ref('int_orders_enriched') }} oe 
    
)

SELECT *
FROM fact_orders

