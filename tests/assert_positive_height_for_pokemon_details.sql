select
    index
from {{ ref('stg_pokemon_details') }}
where height<=0