{{ config(materialized='table') }}

with
    suppliers as (
        select *
        from {{ref('stg_suppliers')}}
    ), 

    transformed as (
        select 
            row_number() over (order by s.supplier_id) as supplier_sk, -- auto-incremental surrogate key
            s.supplier_id,
            s.company_name,
            s.contact_name,
        	s.contact_title,
            s.address,
            s.city,
            s.region,
            s.postal_code,
            s.country,
            s.phone,
            s.fax,
            s.homepage

        from suppliers s
    )

select * from transformed