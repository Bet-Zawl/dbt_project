
WITH dim_temps AS (
    SELECT DISTINCT
        order_date::date AS date
    FROM "northwind"."public"."stg_orders"
)

SELECT
    date,
    EXTRACT(day FROM date) AS jour,
    EXTRACT(month FROM date) AS mois,
    EXTRACT(year FROM date) AS annee,
    EXTRACT(quarter FROM date) AS trimestre,

    -- Format AAAA-MM
    TO_CHAR(date, 'YYYY-MM') AS annee_mois,

    -- Weekend ?
    CASE
        WHEN EXTRACT(dow FROM date) IN (0, 6) THEN TRUE
        ELSE FALSE
    END AS est_weekend

FROM dim_temps
ORDER BY date