{{ config(materialized='table') }}

WITH dim_temps AS (
    SELECT
        order_id,
        order_date::date as date,
        EXTRACT(day FROM order_date) AS jour,
        EXTRACT(month FROM order_date) AS mois,
        EXTRACT(year FROM order_date) AS annee,
        EXTRACT(quarter FROM order_date) AS trimestre,

        -- Format AAAA-MM
        TO_CHAR(order_date, 'YYYY-MM') AS annee_mois,

        -- Weekend ?
        CASE
            WHEN EXTRACT(dow FROM order_date) IN (0, 6) THEN TRUE
            ELSE FALSE
        END AS est_weekend

    FROM {{ref('int_monthly_revenue')}}
    ORDER BY order_date

)
select 
    order_id,
    jour,
    mois,
    annee,
    trimestre,
    annee_mois,
    est_weekend
from dim_temps