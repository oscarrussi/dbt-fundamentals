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

    select 
        customers.id as customer_id,
        customers.name as full_name,
        customers.last_name as surname,
        customers.first_name as givenname,
        min(order_date) as first_order_date,
        {{non_returned_order_date()}} as first_non_returned_order_date,
        {{non_returned_order_date('max')}} as most_recent_non_returned_order_date,
        COALESCE(max(user_order_seq),0) as order_count,
        COALESCE(count(case when orders.status != 'returned' then 1 end),0) as non_returned_order_count,
        {{total_life_value()}} as total_lifetime_value,
        {{total_life_value()}}/NULLIF(count(case when orders.status NOT IN ('returned','return_pending') then 1 end),0) as avg_non_returned_order_value,
        array_agg(distinct orders.id) as order_ids

    from orders

    join customers
    on orders.user_id = customers.id

    left outer join payments as c
    on orders.id = c.orderid

    where orders.status NOT IN ('pending') and c.status != 'fail'

    group by customers.id, customers.name, customers.last_name, customers.first_name

)
select * from customer_order_history