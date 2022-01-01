{%- macro cents_to_dollars(variable='amount') %}
  round({{variable}} / 100, 2)
{% endmacro -%}