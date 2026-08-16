{{ config(materialized='view') }}

with stg_order_details as (
    select
        order_id,
        product_id,
        unit_price,
        quantity,
        discount,

         -- Calcul du sous-total
        round(unit_price * quantity * (1 - discount))::numeric(12,2) as sous_total


    from {{ source('dwh_northwind', 'order_details') }}
)

select *
from stg_order_details
