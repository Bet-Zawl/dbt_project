{{ config(materialized='view') }}

with stg_shippers as (
    select
        shipper_id,
        company_name,
        phone
    from {{ source('dwh_northwind', 'shippers') }}
)

select *
from stg_shippers
