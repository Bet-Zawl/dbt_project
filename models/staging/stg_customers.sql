with stg_customers as (
    
    select
        customer_id,
        initcap(trim(lower(company_name))) as company_name,
        initcap(trim(lower(contact_name))) as contact_name,
        initcap(trim(lower(contact_title))) as contact_title,
        initcap(trim(lower(city))) as city,
        convert_from(convert_to(country, 'LATIN1'), 'LATIN1') as country,
        trim(regexp_replace(phone, '[^0-9+]', '', 'g')) as phone
    
    from "dwh_northwind"."public"."customers"
)

select *
from stg_customers