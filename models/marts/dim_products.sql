{{ config(materialized='view') }}

WITH dim_products AS (
    SELECT
        product_id,
        product_name,
        unit_price,
        units_in_stock,
        units_on_order,
        discontinued,
        en_stock,
        category_name,
        category_description,
        supplier_name,
        supplier_country,

    -- Gamme produit basée sur le prix
    CASE
        WHEN unit_price < 20 THEN 'Entree de gamme'
        WHEN unit_price BETWEEN 20 AND 50 THEN 'Milieu de gamme'
        ELSE 'Premium'
    END AS gamme
    FROM {{ref('int_products_enriched')}}
)

SELECT *

FROM dim_products