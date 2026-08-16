{{ config(materialized='view') }}

with stg_employee as (

    select 
    employee_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    title,
    hire_date,
    city,
    country
   
    from {{source('dwh_northwind', 'employees')}}
)
select *
from stg_employee