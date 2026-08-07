with stg_shippers as (

    select
        "shipper_id"     ::integer       as shipper_id,
        "company_name"   ::varchar       as company_name,
        "phone"          ::varchar       as phone
    from "dwh_northwind"."public"."shippers"
)

select * 
from stg_shippers