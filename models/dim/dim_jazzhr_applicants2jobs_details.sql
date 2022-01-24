with jobs as (
    select * from {{ ref('stg_jazzhr_jobs')}}
),
applicants2jobs as (
    select * from {{ ref('stg_jazzhr_applicants2jobs')}}
),
applicants as (
    select * from {{ ref('stg_jazzhr_applicants_details')}}
)
select 
*
from jobs as j
left join applicants2jobs as aj 
using (job_id)
right join applicants as a
using (applicant_id)