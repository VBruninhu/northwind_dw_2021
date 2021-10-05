{{ config(materialized='table') }}

with
    shippers as (
        select *
        from {{ref('stg_shippers')}}
    ), 

    transformed as (
        select 
            row_number() over (order by s.shipper_id) as shipper_sk, -- auto-incremental surrogate key
            s.shipper_id,
            s.company_name,
            s.phone

        from shippers s
    )

select * from transformed