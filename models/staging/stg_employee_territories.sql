with stg_employees_territories as (

    select
        -- Identifiants
        "employee_id"     ::integer       as employee_id,

        -- Nom et prénom
        "last_name"       ::varchar       as last_name,
        "first_name"      ::varchar       as first_name,

        -- Concaténation
        ( "first_name" || ' ' || "last_name" ) ::varchar  as full_name,

        -- Informations supplémentaires
        "title"          ::varchar       as title,
        "title_of_courtesy"::varchar       as title_of_courtesy,
        "birth_date"      ::date          as birth_date,
        "hire_date"       ::date          as hire_date,
        "address"        ::varchar       as address,
        "city"           ::varchar       as city,
        "region"         ::varchar       as region,
        "postal_code"     ::varchar       as postal_code,
        "country"        ::varchar       as country,
        "home_phone"      ::varchar       as home_phone,
        "extension"      ::varchar       as extension,
        "notes"          ::varchar       as notes,
        "reports_to"      ::integer       as reports_to

    from "dwh_northwind"."public"."employees"

)


select *
from stg_employees_territories