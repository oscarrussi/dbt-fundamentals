select
    id,
    title,
    description,
    country_id,
    status
    original_open_date,
    type
from {{ source('jazzhr', 'jazzhr_jobs') }}