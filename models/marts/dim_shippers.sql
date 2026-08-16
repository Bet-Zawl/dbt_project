

WITH dim_shippers AS (
    SELECT
        shipper_id,
        company_name,
        phone
    from {{ref('stg_shippers')}}
)
select *

FROM dim_shippers