{%- set heights = ['short', 'medium', 'tall'] -%}
select
{% for height in heights  %}
sum(case when range_height='{{height}}' then 1 else 0 end) as total_{{height}}s
{%- if not loop.last -%}
,
{%- endif -%}
{% endfor %}
 from {{ref('stg_pokemon_details')}}