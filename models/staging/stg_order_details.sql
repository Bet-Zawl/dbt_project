with stg_order_details as (

    select
        -- Identifiants
        "order_id"     ::integer        as order_id,
        "product_id"   ::integer        as product_id,

        -- Champs numériques
        "unit_price"   ::numeric(10,2)  as unit_price,
        "quantity"    ::integer        as quantity,
        "discount"    ::numeric(5,4)   as discount,

        -- Calcul du sous-total
        ( "unit_price" * "quantity" * (1 - "discount") )
            ::numeric(12,2)           as sous_total

    from "dwh_northwind"."public"."order_details"

)

select *
from stg_order_details