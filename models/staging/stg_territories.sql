with stg_territories as (

    select
        "territory_id"     ::integer       as territory_id,
        "territory_description" ::varchar  as territory_description,
        "region_id"        ::integer       as region_id
    from "dwh_northwind"."public"."territories"
)

select *
from stg_territories