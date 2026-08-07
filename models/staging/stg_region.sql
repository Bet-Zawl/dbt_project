with stg_region as (

    select
        "region_id"     ::integer       as region_id,
        "region_description" ::varchar  as region_description
    from "dwh_northwind"."public"."region"
)

select *
from stg_region