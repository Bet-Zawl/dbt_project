{{ config(materialized='view') }}

with int_customers_stat AS (
    SELECT
        customer_id,
        company_name,
        contact_name,
        contact_title,
        city,
        country,
        phone        
    FROM {{ ref('stg_customers') }}
)

SELECT *
FROM int_customers_stat


