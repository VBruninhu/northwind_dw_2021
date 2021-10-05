{{ config(materialized='table') }}

with
    cat as (
        select *
        from {{ref('stg_categories')}}
    ), 

    prod as (
        select *
        from{{ref('stg_products')}}
    ),

    merged as (
        select 
            row_number() over (order by p.product_id) as product_sk, -- auto-incremental surrogate key
            p.product_id,
            p.product_name,
            p.supplier_id,
            p.category_id,
            p.quantity_per_unit,
            p.unit_price,
            p.units_in_stock,
            p.units_on_order,
            p.reorder_level,
            p.discontinued,
            c.category_name,
            c.description

        from prod p
        left join cat c on p.category_id = c.category_id
    )

select * from merged