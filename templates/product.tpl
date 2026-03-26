<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container pb-4 pt-md-4 pb-md-3" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">
    <div class="container pt-md-1">
        <div class="row">
            {% if not home_main_product %}
                <div class="col-md-12 d-block d-md-none">
                    <h2 class="h6 mb-0">{{ product.name }}</h2>
                </div>
            {% endif %}
            <div class="col-md-7 pb-0 pb-md-4 lb-product-image-container-sticky">
                {% include 'snipplets/product/product-image.tpl' %}
            </div>
            <div class="col" data-store="product-info-{{ product.id }}">
                {% include 'snipplets/product/product-form.tpl' %}
                {% if not settings.full_width_description %}
                    {% include 'snipplets/product/product-description.tpl' %}
                {% endif %}
            </div>

        <div class="col-md-12">
            {# Product description full width #}

            {% if settings.full_width_description %}
                {% include 'snipplets/product/product-description.tpl' %}
            {% endif %}
        </div>
        </div>
    </div>
</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}