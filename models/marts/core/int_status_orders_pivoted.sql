{%- set statuses = ['placed','shipped','returned','completed', 'return_pending'] -%}
select 
{% for status in statuses %}
sum(case when status='{{status}}' then 1 else 0 end) as count_{{status}}
{%- if not loop.last -%}
,
{%- endif -%}
{% endfor %}
from {{ref('stg_orders')}}