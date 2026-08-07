with int_employee_stats as (

WITH orders AS (
    SELECT
        o.order_id,
        o.employee_id,
        o.order_date,
        o.required_date,
        o.shipped_date
    FROM "northwind"."public"."stg_orders" o
),

order_details AS (
    SELECT
        od.order_id,
        od.quantity,
        od.unit_price,
        (od.quantity * od.unit_price) AS line_amount
    FROM "northwind"."public"."stg_order_details" od
),

employees AS (
    SELECT
        e.employee_id,
        e.full_name,
        e.hire_date

    FROM "northwind"."public"."stg_employee" e
),

order_amounts AS (
    SELECT
        od.order_id,
        SUM(od.line_amount) AS order_total_amount
    FROM order_details od
    GROUP BY od.order_id
),

employee_stats AS (
    SELECT
        e.employee_id,
        e.full_name,
        e.hire_date,

        COUNT(o.order_id) AS nb_commandes_traitees,

        SUM(oa.order_total_amount) AS ca_total,

        AVG(CASE WHEN o.shipped_date IS NOT NULL THEN 1 ELSE 0 END)::numeric(10,4)
            AS taux_livraison_a_temps,

        AVG(EXTRACT(day FROM (o.shipped_date::timestamp - o.order_date::timestamp)))::numeric(10,2) AS delai_moyen_livraison


    FROM employees e
    LEFT JOIN orders o
        ON o.employee_id = e.employee_id
    LEFT JOIN order_amounts oa
        ON oa.order_id = o.order_id

    GROUP BY
        e.employee_id,
        e.full_name,
        e.hire_date
)

SELECT *
FROM employee_stats
)
select * from int_employee_stats