{%- macro sort(param='id') %}
  order by {{param}}
{% endmacro -%}