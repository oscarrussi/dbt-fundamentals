select
d.index,
d.name,
d.height,
d.weight,
(d.weight/(d.height*d.height)) as BMI,
(case 
when 
d.height>(select max(d2.height)/4 from {{source('pokemons', 'pokemon_details')}} as d2) 
then 'tall' 
when 
d.height>(select max(d2.height)/16 from {{source('pokemons', 'pokemon_details')}} as d2) 
then 'medium' 
else 'short' end) as range_height,
(case 
when 
d.weight>(select max(d2.weight)/4 from {{source('pokemons', 'pokemon_details')}} as d2) 
then 'heavy' 
when 
d.weight>(select max(d2.weight)/16 from {{source('pokemons', 'pokemon_details')}} as d2) 
then 'medium' 
else 'lightweight' end) as range_weight,
(case 
when 
(d.weight/(d.height*d.height))>(select max(d2.weight/(d2.height*d2.height))/4 from {{source('pokemons', 'pokemon_details')}} as d2)
then 'high' 
when 
(d.weight/(d.height*d.height))>(select max(d2.weight/(d2.height*d2.height))/16 from {{source('pokemons', 'pokemon_details')}} as d2) 
then 'medium' 
else 'low' end) as range_bmi
from {{source('pokemons', 'pokemon_details')}} as d