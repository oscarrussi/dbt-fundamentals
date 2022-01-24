select
    id,
    first_name,
    last_name,
    apply_date
from {{ source('jazzhr', 'jazzhr_applicants') }}