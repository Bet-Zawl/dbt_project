with stg_categories as (

    select 
    category_id,
    category_name,
    description as category_description
    
   
    from {{source('dwh_northwind', 'categories') }}
)
select *
from stg_categories