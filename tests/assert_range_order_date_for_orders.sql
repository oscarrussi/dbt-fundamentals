select
    order_date
from {{ ref('stg_orders') }}
where not(order_date >= '2018-01-01')