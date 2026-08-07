with stg_categories as (

    select 
    "category_id" ::integer as category_id,
    "category_name" ::varchar as category_name,
    "description" ::varchar as description
    
   
    from "dwh_northwind"."public"."categories"
)
select *
from stg_categories