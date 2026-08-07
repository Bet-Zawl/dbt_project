with stg_products as (

    select
        -- Identifiants
        "product_id"        ::integer        as product_id,
        "product_name"      ::varchar        as product_name,
        "supplier_id"       ::integer        as supplier_id,
        "category_id"       ::integer        as category_id,

        -- Champs numériques
        "quantity_per_unit"  ::varchar        as quantity_per_unit,
        "unit_price"        ::numeric(10,2)  as unit_price,
        "units_in_stock"     ::integer        as units_in_stock,
        "units_on_order"     ::integer        as units_on_order,
        "reorder_level"     ::integer        as reorder_level,

        -- Booléen
        "discontinued"     ::boolean        as discontinued,

        -- Colonne dérivée : TRUE si stock > 0
        case 
            when "units_in_stock" > 0 then true
            else false
        end as en_stock

    from "dwh_northwind"."public"."products"

)

select *
from stg_products