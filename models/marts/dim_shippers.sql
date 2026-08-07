

WITH dim_shippers AS (
    SELECT
        shipper_id,
        company_name,
        phone
    FROM "northwind"."public"."stg_shippers"
)

SELECT
    shipper_id,
    company_name,
    phone,

    -- Exemple d'étiquette utile
    CASE
        WHEN company_name ILIKE '%speed%' THEN 'Express'
        WHEN company_name ILIKE '%freight%' THEN 'Freight'
        ELSE 'Standard'
    END AS shipper_type

FROM shippers