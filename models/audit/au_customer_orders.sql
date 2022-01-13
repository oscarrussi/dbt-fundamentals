with orders as (
   select 
        row_number() over (partition by user_id order by order_date, id) as user_order_seq,
        *
   from {{ source('jaffle_shop', 'orders') }}
   
),
customers as (
   select 
   first_name || ' ' || last_name as name,
   * from {{ source('jaffle_shop', 'customers') }}
),
payments as (
    select * from {{ source('stripe', 'payments') }}
),
customer_order_history as (
    select * from {{ref('customer_order_history')}}
)

select 
    orders.id as order_id,
    orders.user_id as customer_id,
    last_name as surname,
    first_name as givenname,
    first_order_date,
    order_count,
    total_lifetime_value,
    round(amount/100.0,2) as order_value_dollars,
    orders.status as order_status,
    payments.status as payment_status
from orders

join customers
on orders.user_id = customers.id

join  customer_order_history
on orders.user_id = customer_order_history.customer_id

left outer join  payments
on orders.id = payments.orderid

where payments.status != 'fail'