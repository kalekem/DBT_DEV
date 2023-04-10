with mock_orders as (
    select
        order_id
        ,status as order_status
        ,created_at
        ,updated_at
    from {{ source('jaffle_shop', 'mock_orders') }}
)
select
    *
from mock_orders