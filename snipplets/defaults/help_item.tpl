{# /*============================================================================
  #Item grid
==============================================================================*/

#Properties

#Slide Item

#}

{% set slide_item = slide_item | default(false) %}
{% set item_view_box = '0 0 1000 1000' %}

{% if template == 'home'%}
    {% set columns_desktop = section_columns_desktop %}
    {% set columns_mobile = section_columns_mobile %}
{% else %}
    {% set columns_desktop = settings.grid_columns_desktop %}
    {% set columns_mobile = settings.grid_columns_mobile %}
{% endif %}

<div class="js-item-product{% if slide_item %} js-item-slide swiper-slide{% endif %} col-{% if columns_mobile == 1 %}12{% else %}6{% endif %} col-md-{% if columns_desktop == 4 %}3{% elseif columns_desktop == 5 %}2-4{% else %}2{% endif %} item-product col-grid">
    <div class="item{% if slide_item %} mb-0{% endif %} {{ item_class }}">
        <div class="item-image">
            <div class="position-relative">
                <a href="{{ store.url }}/product/example" title="{{ "Producto de ejemplo" | translate }}">
                    {% if help_item_1 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-1"/></svg>
                    {% elseif help_item_2 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-2"/></svg>
                    {% elseif help_item_3 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-3"/></svg>
                    {% elseif help_item_4 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-4"/></svg>
                    {% elseif help_item_5 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-5"/></svg>
                    {% elseif help_item_6 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-6"/></svg>
                    {% elseif help_item_7 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-7"/></svg>
                    {% elseif help_item_8 %}
                        <svg viewBox="{{ item_view_box }}"><use xlink:href="#item-product-placeholder-8"/></svg>
                    {% endif %}
                </a>
            </div>
            {% if help_item_2 %}
                <div class="labels-absolute">
                    <div class="label label-accent">
                        {{ "Envío gratis" | translate }}
                    </div>
                </div>
            {% endif %}
        </div>
        <div class="item-description">
            <a href="{{ store.url }}/product/example" title="{{ "Producto de ejemplo" | translate }}" class="item-link">
                <div class="mb-2 font-small opacity-80">{{ "Producto de ejemplo" | translate }}</div>
                {% if help_item_1 or help_item_3 or help_item_7 %}
                    <div class="labels mb-2">
                        <div class="label label-inline">
                            {% if help_item_1 %}
                                -20% OFF
                            {% elseif help_item_3 %}
                                -35% OFF
                            {% elseif help_item_7 %}
                                -25% OFF
                            {% endif %}
                        </div>
                    </div>
                {% endif %}          
                <div class="item-price-container">
                    {% if help_item_1 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"9600" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"120000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"96000" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"1200000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_2 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"68000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"680000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_3 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"18200" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"28000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"182000" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"280000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_4 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"32000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"320000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_5 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"24900" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"249000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_6 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"42000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"420000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_7 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"36800" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"46000" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"368000" | money }}
                            </span>
                            <span id="compare_price_display" class="js-compare-price-display price-compare">
                                {{"460000" | money }}
                            </span>
                        {% endif %}
                    {% elseif help_item_8 %}
                        {% if store.country == 'BR' %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"12200" | money }}
                            </span>
                        {% else %}
                            <span id="price_display" class="js-price-display item-price font-weight-bold">
                                {{"122000" | money }}
                            </span>
                        {% endif %}
                    {% endif %}
                </div>
            </a>
        </div>
    </div>
</div>