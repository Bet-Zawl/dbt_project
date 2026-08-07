with stg_orders as (

    select
        -- clés et identifiants
        "order_id"      ::integer        as order_id,
        "customer_id"   ::varchar        as customer_id,
        "employee_id"   ::integer        as employee_id,

        -- dates
        "order_date"    ::date           as order_date,
        "required_date" ::date           as required_date,
        "shipped_date"  ::date           as shipped_date,

        -- shipping / coûts
        "ship_via"      ::integer        as ship_via,
        "freight"      ::numeric(10,2)  as freight,

        -- shipping / adresses
        "ship_address"  ::varchar        as ship_address,
        "ship_city"     ::varchar        as ship_city,
        "ship_region"   ::varchar        as ship_region,
        "ship_country"  ::varchar        as ship_country,


        -- colonne dérivée
        case
            when "shipped_date" is not null then true
            else false
        end                      as is_shipped

    from "dwh_northwind"."public"."orders"

)

select *
from stg_orders