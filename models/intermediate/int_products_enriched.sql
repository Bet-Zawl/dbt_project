{{ config(materialized='table') }}

with int_products_enriched as (

select
--products
    p.product_id,
    p.product_name,
    p.unit_price,
    ROUND(p.unit_price::numeric * GREATEST(p.units_in_stock, 0)::numeric, 2) as quantity_per_unit,
    p.units_in_stock,
    p.units_on_order,
    p.discontinued,
    p.en_stock,
    case
        when p.discontinued then 'Discontinued'
        else 'Active'
    end as product_status,
-- categories
    c.category_name,
    c.category_description,

--supplier
    s.company_name as supplier_name,
    s.country as supplier_country

from {{ref('stg_products')}} p
left join {{ref('stg_categories')}} c
    on p.category_id = c.category_id
left join {{ref('stg_suppliers')}} s
    on p.supplier_id = s.supplier_id

)
select * 
from int_products_enriched
