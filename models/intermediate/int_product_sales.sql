{{ config(materialized='view') }}

with int_products as(    
select
    o.order_id,
    o.customer_id,
    o.order_date,
    o.required_date,
    o.shipped_date,
    o.ship_city,
    o.ship_country,
    od.product_id,
    p.product_name,
    p.category_id,
    od.quantity,
    od.unit_price,
    od.discount,
    od.quantity * od.unit_price * (1 - od.discount) as line_amount

from {{ref('stg_orders')}} o
join {{ref('stg_order_details')}} od
on od.order_id = o.order_id
join {{ref('stg_products')}} p 
on p.product_id = od.product_id

)
select *
from int_products
