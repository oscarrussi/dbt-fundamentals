select
    first_name,
    last_name
from {{ ref('stg_customers') }}
where not(first_name != '' and last_name !='')