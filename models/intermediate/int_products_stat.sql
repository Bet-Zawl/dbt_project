with int_products_stat as (
    SELECT
        p.product_id,
        p.product_name,
        p.quantity_per_unit,
        p.unit_price,
        p.units_in_stock,
        p.units_on_order,
        p.reorder_level,
        p.discontinued,

    -- Catégorie
        c.category_name,
        c.description AS category_description,

    -- Fournisseur
        s.company_name AS supplier_company_name,
        s.country AS supplier_country

FROM stg_products p
LEFT JOIN stg_categories c
    ON p.category_id = c.category_id
LEFT JOIN stg_suppliers s
    ON p.supplier_id = s.supplier_id

)
select * from int_products_stat