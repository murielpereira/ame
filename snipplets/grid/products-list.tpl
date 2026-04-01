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

        {#
          Frontend Deduplication Script
          Uses a MutationObserver to instantly remove duplicate product items
          (same data-product-id) appended during infinite scroll pagination
        #}
        <script>
            (function() {
                var dedupProducts = function() {
                    var seenIds = new Set();
                    var items = document.querySelectorAll('.js-item-product');
                    for (var i = 0; i < items.length; i++) {
                        var item = items[i];
                        var id = item.getAttribute('data-product-id');
                        if (id) {
                            if (seenIds.has(id)) {
                                item.remove();
                            } else {
                                seenIds.add(id);
                            }
                        }
                    }
                };

                // Run immediately for initial load
                if (document.readyState === 'loading') {
                    document.addEventListener('DOMContentLoaded', dedupProducts);
                } else {
                    dedupProducts();
                }

                // Setup observer for infinite scroll appends
                window.addEventListener('load', function() {
                    var grid = document.querySelector('.js-product-table');
                    if (grid) {
                        var observer = new MutationObserver(function(mutations) {
                            var shouldDedup = false;
                            for (var i = 0; i < mutations.length; i++) {
                                if (mutations[i].addedNodes.length > 0) {
                                    shouldDedup = true;
                                    break;
                                }
                            }
                            if (shouldDedup) {
                                dedupProducts();
                            }
                        });
                        observer.observe(grid, { childList: true, subtree: true });
                    }
                });
            })();
        </script>
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