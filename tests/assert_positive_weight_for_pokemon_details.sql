select
    index
from {{ ref('stg_pokemon_details') }}
where weight<=0