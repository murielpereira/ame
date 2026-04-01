{% if products and pages.is_last %}
	<div class="last-page" style="display:none;"></div>
{% endif %}

{# Prevent duplicate products from rendering entirely on the backend #}
{% set rendered_product_ids = rendered_product_ids | default('') %}

{% for product in products %}   
    {% set current_product_id_string = ',' ~ product.id ~ ',' %}
    {% if current_product_id_string not in rendered_product_ids %}
        {% set rendered_product_ids = rendered_product_ids ~ current_product_id_string %}
        {% include 'snipplets/grid/item.tpl' %}
    {% endif %}
{% endfor %}