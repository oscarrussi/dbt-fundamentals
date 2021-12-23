select
    index
from {{ ref('stg_pokemon_types') }}
where type=''