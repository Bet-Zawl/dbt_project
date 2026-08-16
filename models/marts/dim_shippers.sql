{{ config(materialized='table') }}

WITH dim_shippers AS (
    SELECT
        order_id,
        ship_via,
        freight, 
        order_date,
        required_date,
        shipped_date,
        shipper_company_name,
        shipper_company_phone,
        ship_city,
        ship_country,
        is_shipped
        
    from {{ref('int_shippers')}}
)
select *

FROM dim_shippers