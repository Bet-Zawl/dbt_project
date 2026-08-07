

WITH fact_orders AS (
    SELECT
        order_id,
        customer_id,
        employee_id,
        ship_via as shipper_id,
        order_date,
        required_date,
        shipped_date,
        ship_city,
        ship_country,
        freight,
        is_shipped,
        delai_livraison_jours,
        nb_articles,
        quantite_totale,
        montant_total,
        montant_total_avec_frais

    FROM "northwind"."public"."int_orders_enriched"
)

SELECT
        order_id,
        customer_id,
        employee_id,
        shipper_id,
        order_date,
        required_date,
        shipped_date,
        ship_city,
        ship_country,
        freight,
        is_shipped,
        delai_livraison_jours,
        nb_articles,
        quantite_totale,
        montant_total,
        montant_total_avec_frais

FROM fact_orders