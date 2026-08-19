{% macro print_schema(model_name) %}
    {% set relation = ref(model_name) %}
    {% set columns = adapter.get_columns_in_relation(relation) %}

    {% for col in columns %}
        {{ log(col.name ~ ' (' ~ col.data_type ~ ')', info=True) }}
    {% endfor %}
{% endmacro %}
