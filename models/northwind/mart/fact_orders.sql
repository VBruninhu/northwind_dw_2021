{{ config(materialized='table') }}

with
    customers as (
        select
            customer_sk,
            customer_id

        from {{ref('dim_customers')}}
    ),

    employees as(
        select
            employee_id,
            employee_sk

        from {{ref('dim_employees')}}
    ),

    products as (
        select
            product_id,
            product_sk,
            supplier_id

        from{{ref('dim_products')}}
    ),

    shippers as (
        select
            shipper_id,
            shipper_sk
        
        from{{ref('dim_shippers')}}
    ),

    suppliers as (
        select
            supplier_id,
            supplier_sk
        
        from{{ref('dim_suppliers')}}
    ),

    orders_with_sk as (
        select 
            orders.order_id,
            customers.customer_id,
            customers.customer_sk,
            employees.employee_id,
            employees.employee_sk,
            products.product_id,
            products.product_sk,
            shippers.shipper_id,
            shippers.shipper_sk,
            suppliers.supplier_id,
            suppliers.supplier_sk,
            order_details.unit_price,
            order_details.quantity,
            order_details.discount,
            orders.order_date,
            orders.ship_region,
            orders.shipped_date,
            orders.ship_country,
            orders.ship_address,
            orders.ship_postal_code,
            orders.ship_city,
            orders.ship_name,
            orders.freight,
            orders.required_date

        from {{ref('stg_orders')}} orders
        left join {{ref('stg_order_details')}} order_details on orders.order_id = order_details.order_id
        left join customers customers on orders.customer_id = customers.customer_id
        left join employees employees on orders.employee_id = employees.employee_id
        left join products products on order_details.product_id = products.product_id
        left join shippers shippers on orders.shipper_id = shippers.shipper_id
        left join suppliers suppliers on products.supplier_id = suppliers.supplier_id
    )

select *
from orders_with_sk