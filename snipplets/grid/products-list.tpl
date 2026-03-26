{% set list_data_store = template == 'category' ? 'category-grid-' ~ category.id : 'search-grid' %}
<div class="col pt-2 pt-md-0" data-store="{{ list_data_store }}">
    {% if products %}
        <div class="js-product-table row row-grid">
            {% include 'snipplets/product_grid.tpl' %}
        </div>
        {% if settings.pagination == 'infinite' %}
            {% set pagination_type_val = true %}
        {% else %}
            {% set pagination_type_val = false %}
        {% endif %}

        {% include "snipplets/grid/pagination.tpl" with {infinite_scroll: pagination_type_val} %}
    {% else %}
        {% if template == 'category' %}
            <div class="h6 py-5 text-center" data-component="filter.message">
                {{(has_filters_enabled ? "No tenemos resultados para tu búsqueda. Por favor, intentá con otros filtros." : "Próximamente") | translate}}
            </div>
        {% elseif template == 'search' %}
            <h5 class="my-4 font-weight-normal">
                {{ "Escribilo de otra forma y volvé a intentar." | translate }}
            </h5>
        {% endif %}
    {% endif %}
</div>