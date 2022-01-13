with persons as (
    select * from {{ref('persons')}}
),
enrollings as (
    select * from {{ref('enrollings')}}
) 
select enrollings.*
from enrollings 
inner join persons
using (id)