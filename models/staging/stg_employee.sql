with stg_employee as (

    select 
    "employee_id" ::integer as employee_id,
    "title" ::varchar as title,
    "hire_date" ::date as hire_date,
    "city" ::varchar as city,
    "country" ::varchar as country,

    CONCAT(first_name, ' ', last_name) AS full_name
    
   
    from "dwh_northwind"."public"."employees"
)
select *
from stg_employee