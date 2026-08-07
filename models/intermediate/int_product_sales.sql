with int_product_sales as (

SELECT
    p.product_id,
    SUM(oi.quantity) AS quantite_totale_vendue,
    SUM(oi.quantity * oi.unit_price) AS ca_genere,
    COUNT(DISTINCT oi.order_id) AS nb_commandes_distinctes,
    p.units_in_stock AS stock_restant
FROM stg_products p
LEFT JOIN stg_order_details oi
    ON p.product_id = oi.product_id
GROUP BY
    p.product_id,
    p.units_in_stock
ORDER BY
    ca_genere DESC
)
select * from int_product_sales