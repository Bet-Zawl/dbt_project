{{ config(materialized='table') }}

WITH dim_customers AS (
    SELECT
        c.customer_id,
        c.company_name,
        c.contact_name,
        c.contact_title,
        c.city,
        c.country,
        c.phone


    from {{ref('int_customers_stat')}} as c
    join {{ref('int_product_sales')}} as p on c.customer_id = p.customer_id

    group by

        c.customer_id,
        c.company_name,
        c.contact_name,
        c.contact_title,
        c.city,
        c.country,
        c.phone

)
select * 

FROM dim_customers