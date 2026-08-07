

WITH dim_customers AS (
    SELECT
        customer_id,
        company_name,
        contact_name,
        contact_title,
        city,
        country,
        phone
    FROM "northwind"."public"."stg_customers"
)

SELECT
    customer_id,
    company_name,
    contact_name,
    contact_title,
    city,
    phone,


    -- Champs dérivés utiles pour la BI
    CONCAT(contact_name, ' (', company_name, ')') AS customer_label,
    UPPER(country) AS country,
    CONCAT(city, ' - ', country) AS city_country_label,

    CASE
        WHEN country IN ('USA', 'Canada') THEN 'North America'
        WHEN country IN ('UK', 'France', 'Germany', 'Italy', 'Spain') THEN 'Europe'
        ELSE 'Other'
    END AS customer_region_group

FROM customers