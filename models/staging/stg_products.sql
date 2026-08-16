{{ config(materialized='view') }}

with stg_products as (

    select
        -- Identifiants
        product_id,
        product_name,
        supplier_id,
        category_id,

        -- Champs numériques
        quantity_per_unit,
        unit_price,
        units_in_stock,
        units_on_order,

        -- Booléen
        "discontinued"     ::boolean        as discontinued,

        -- Colonne dérivée : TRUE si stock > 0
        case 
            when "units_in_stock" > 0 then true
            else false
        end as en_stock

    from {{source('dwh_northwind', 'products')}}

)

select *
from stg_products