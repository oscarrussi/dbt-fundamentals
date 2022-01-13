WITH orders as (
    select * from {{ source('jaffle_shop', 'orders') }}
),
customers as (
    select * from {{ source('jaffle_shop', 'customers') }}
),
customer_orders as (
    select C.ID as customer_id
    , min(ORDER_DATE) as first_order_date
    , max(ORDER_DATE) as most_recent_order_date
    , count(ORDERS.ID) AS number_of_orders
    from customers as C 
    left join  orders
    on orders.USER_ID = C.ID 
    group by 1
)
select * from customer_orders