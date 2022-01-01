select
    id as payment_id,
    orderid as order_id,
    paymentmethod as payment_method,
    status,
    -- amount is stored in cents, convert it to dollars
    {{cents_to_dollars()}} as amount,
    created as created_at
from {{ source('stripe', 'payments') }}
{{limit_data_in_dev(unit='month', total='46')}}