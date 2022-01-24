select
    id as applicant_id,
    first_name,
    last_name,
    apply_date,
    email
from {{ source('jazzhr', 'jazzhr_applicants_details') }}