WITH orders as (
    select * from {{ source('jaffle_shop', 'orders') }}
),
customers as (
    select * from {{ source('jaffle_shop', 'customers') }}
),
payments as (
    select * from {{ source('stripe', 'payments') }}
),
p as (
    select ORDERID as order_id, max(CREATED) as payment_finalized_date, sum(AMOUNT) / 100.0 as total_amount_paid
    from payments
    where STATUS <> 'fail'
    group by 1
    ),
paid_orders as (
    select orders.ID as order_id,
    orders.USER_ID	as customer_id,
    orders.ORDER_DATE AS order_placed_at,
    orders.STATUS AS order_status,
    p.total_amount_paid,
    p.payment_finalized_date,
    C.FIRST_NAME    as customer_first_name,
    C.LAST_NAME as customer_last_name
    FROM orders
    left join p ON orders.ID = p.order_id
    left join customers as C on orders.USER_ID = C.ID 
    )
select * from paid_orders