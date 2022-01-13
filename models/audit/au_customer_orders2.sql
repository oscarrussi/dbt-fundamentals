WITH paid_orders as (
    select * from {{ref('stg_paid_orders2')}}
    ),
customer_orders as (
    select * from {{ref('stg_customer_orders2')}}
    ),
x as (
    select * from {{ref('stg_x2')}}
)
select
p.*,
ROW_NUMBER() OVER (ORDER BY p.order_id) as transaction_seq,
ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY p.order_id) as customer_sales_seq,
CASE WHEN c.first_order_date = p.order_placed_at
THEN 'new'
ELSE 'return' END as nvsr,
x.clv_bad as customer_lifetime_value,
c.first_order_date as fdos
FROM paid_orders p
left join customer_orders as c USING (customer_id)
LEFT OUTER JOIN 
 x on x.order_id = p.order_id
ORDER BY order_id