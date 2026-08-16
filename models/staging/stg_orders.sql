{{ config(materialized='view') }}

with source_orders as (
    select
        order_id,
        customer_id,
        employee_id,
        ship_via,
        freight, 
        order_date,
        required_date,
        shipped_date,
        ship_city,
        ship_country,

          -- colonne dérivée
        case
            when "shipped_date" is not null then true
            else false
        end                      as is_shipped


    from {{ source('dwh_northwind', 'orders') }}

)
select *

from source_orders
