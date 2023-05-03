{{
    config(
        unique_key ='order_id'
    )
}}

with orders as (
    
    select 
        id as order_id
        ,user_id as customer_id
        ,order_date
        ,status
    
    from {{ source('jaffle_shop', 'orders') }}
    {% if is_incremental() %} --implements incremental logic
    where 1=1 
        AND order_date >(select max(order_date) from {{this}}) -- {{this}} refers to base.incremental_orders
    {% endif %}
)

select * from orders