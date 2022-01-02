select
{{ dbt_utils.star(from=ref('dim_customers'), except=["first_order_date", "most_recent_order_date", "lifetime_value"]) }}
from {{ ref('dim_customers') }}