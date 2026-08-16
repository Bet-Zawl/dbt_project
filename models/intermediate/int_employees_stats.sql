{{ config(materialized='view') }}

with int_employee_stats as (
 
    SELECT

    --employees
        e.employee_id,
        e.full_name,
        e.hire_date,

    --orders

        COUNT(o.order_id) AS nb_commandes_traitees,

    --stg_order_details

        SUM(od.sous_total) AS ca_total,

        AVG(CASE WHEN o.shipped_date IS NOT NULL THEN 1 ELSE 0 END)::numeric(10,4)
            AS taux_livraison_a_temps,

        AVG(EXTRACT(day FROM (o.shipped_date::timestamp - o.order_date::timestamp)))::numeric(10,2) AS delai_moyen_livraison

    from {{ ref('stg_employees') }} e
    LEFT JOIN {{ref('stg_orders')}} o
        ON o.employee_id = e.employee_id
    LEFT JOIN {{ref('stg_order_details')}} od
        ON od.order_id = o.order_id

    GROUP BY
        e.employee_id,
        e.full_name,
        e.hire_date
)
select * from int_employee_stats