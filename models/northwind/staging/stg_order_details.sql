with 
    source_data as (
      select
            order_id,
            product_id,
            unit_price,
            quantity,
            discount

    from {{source('erpnorthwind', 'public_order_details')}}
)

select * from source_data