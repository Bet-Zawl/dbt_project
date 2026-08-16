{{ config(materialized='table') }}

WITH dim_customers AS (
    SELECT
        customer_id,
        company_name,
        contact_name,
        contact_title,
        city,
        country,
        phone
    from {{ref('int_customers_stat')}}

)
select * 

FROM dim_customers