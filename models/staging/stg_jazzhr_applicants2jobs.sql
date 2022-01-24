select
   id,
   applicant_id,
   job_id,
   date
from {{ source('jazzhr', 'jazzhr_applicants2jobs') }}