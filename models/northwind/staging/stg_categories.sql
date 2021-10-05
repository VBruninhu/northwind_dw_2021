with 
    source_data as (
      select
            category_id,
            category_name,
            description,
            --picture

    from {{source('erpnorthwind', 'public_categories')}}
)

select * from source_data