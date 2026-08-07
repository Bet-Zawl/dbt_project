

WITH dim_products AS (
    SELECT
        *
    FROM "northwind"."public"."int_products_enriched"
)

SELECT 
    product_id,
    product_name,
    quantity_per_unit,
    unit_price,
    units_in_stock, 
    units_on_order,
    reorder_level,
    discontinued,
    category_name,
    category_description,
    supplier_country,

    -- Gamme produit basée sur le prix
    CASE
        WHEN unit_price < 20 THEN 'Entrée de gamme'
        WHEN unit_price BETWEEN 20 AND 50 THEN 'Milieu de gamme'
        ELSE 'Premium'
    END AS gamme

FROM dim_products