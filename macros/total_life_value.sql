{%- macro total_life_value() %}
  sum(case when orders.status NOT IN ('returned','return_pending') then ROUND(c.amount/100.0,2) else 0 end)
{% endmacro -%}
