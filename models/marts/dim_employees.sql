
{{ config(materialized='table') }}

WITH dim_employees AS (
    SELECT
        employee_id,
        full_name,
        hire_date,
        nb_commandes_traitees,
        ca_total,
        taux_livraison_a_temps,
        delai_moyen_livraison
    FROM {{ref('int_employees_stats')}}
)

SELECT *
FROM dim_employees