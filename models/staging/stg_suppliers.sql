{{ config(materialized='view') }}

with stg_suppliers as (
    select
        supplier_id,
        company_name,
        contact_name,
        contact_title,
        city,
        country,
        phone
    from {{ source('dwh_northwind', 'suppliers') }}
)

select *
from stg_suppliers
