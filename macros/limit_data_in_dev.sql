{%- macro limit_data_in_dev(variable='created', unit='day', total=-3) %}
  {% if target.name=='default' %}
  where {{variable}}>=DATE_SUB(CURRENT_DATE(), interval {{total}} {{unit}})
  {% endif %}
{% endmacro -%}