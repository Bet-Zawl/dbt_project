{{ config(materialized='view') }}

with int_shippers as (
    select

        o.order_id,
        o.customer_id,
        o.employee_id,
        o.freight, 
        o.order_date,
        o.required_date,
        o.shipped_date,
        o.ship_city,
        o.ship_country,
        o.is_shipped,

        s.ship_via,
        s.shipper_company_name,
        s.shipper_company_phone

    from {{ref('stg_orders')}} as o
    join {{ref('stg_shippers')}} as s on o.ship_via = s.ship_via

    group by 

    o.order_id,
        o.customer_id,
        o.employee_id,
        o.freight, 
        o.order_date,
        o.required_date,
        o.shipped_date,
        o.ship_city,
        o.ship_country,
        o.is_shipped,

        s.ship_via,
        s.shipper_company_name,
        s.shipper_company_phone

)
select *
from int_shippers