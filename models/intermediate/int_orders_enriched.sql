with int_orders_enriched as (
SELECT
    o.order_id,
    o.customer_id,
    o.employee_id,
    o.ship_via,
    o.order_date,
    o.required_date,
    o.shipped_date,
    o.ship_city,
    o.ship_country,
    o.freight,
    o.is_shipped,

    -- Nombre de lignes d’articles dans la commande
    COUNT(od.product_id) AS nb_articles,

    -- Quantité totale commandée
    SUM(od.quantity) AS quantite_totale,

    -- Montant total (prix * quantité * remise éventuelle)
    SUM(od.unit_price * od.quantity * (1 - COALESCE(od.discount, 0))) AS montant_total,

    -- Délai de livraison en jours (NULL si shipped_date ou order_date est NULL)
    
    (o.shipped_date - o.order_date) AS delai_livraison_jours,

    -- montat total avec frais
    SUM(od.unit_price * od.quantity * (1 - COALESCE(od.discount, 0))) + o.freight AS montant_total_avec_frais,

    -- TRUE si livré à temps, FALSE si en retard, NULL si shipped_date ou required_date manquent
    CASE
        WHEN o.shipped_date IS NULL OR o.required_date IS NULL THEN NULL
        WHEN o.shipped_date <= o.required_date THEN TRUE
        ELSE FALSE
    END AS is_on_time

FROM stg_orders o
JOIN stg_order_details od
    ON o.order_id = od.order_id

GROUP BY
    o.order_id,
    o.customer_id,
    o.employee_id,
    o.ship_via,
    o.order_date,
    o.required_date,
    o.shipped_date,
    o.ship_city,
    o.ship_country,
    o.freight,
    o.is_shipped
    
)
select * from int_orders_enriched