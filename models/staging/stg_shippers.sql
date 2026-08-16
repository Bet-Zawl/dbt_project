{{ config(materialized='view') }}

with stg_shippers as (
    select
        shipper_id as ship_via,
        company_name as shipper_company_name,
        phone as shipper_company_phone
    from {{ source('dwh_northwind', 'shippers') }}
)

select *
from stg_shippers
