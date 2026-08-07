with stg_us_states as (

    select
        "state_id"     ::integer       as state_id,
        "state_name"   ::varchar       as state_name,
        "state_abbr"   ::varchar       as state_abbr
    from "dwh_northwind"."public"."us_states"
)

select *
from stg_us_states