{# /*============================================================================
  #Home featured grid
==============================================================================*/

#Properties

#Featured Slider

#}

{% set featured_products = featured_products | default(false) %}
{% set new_products = new_products | default(false) %}
{% set sale_products = sale_products | default(false) %}
{% set promotion_products = promotion_products | default(false) %}
{% set best_seller_products = best_seller_products | default(false) %}

{# Check if slider is used #}

{% set has_featured_products_and_slider = featured_products and (settings.featured_products_format_mobile == 'slider' or settings.featured_products_format_desktop == 'slider')  %}
{% set has_new_products_and_slider = new_products and (settings.new_products_format_mobile == 'slider' or settings.new_products_format_desktop == 'slider') %}
{% set has_sale_products_and_slider = sale_products and (settings.sale_products_format_mobile == 'slider' or settings.sale_products_format_desktop == 'slider') %}
{% set has_promotion_products_and_slider = promotion_products and (settings.promotion_products_format_mobile == 'slider' or settings.promotion_products_format_desktop == 'slider') %}
{% set has_best_seller_products_and_slider = best_seller_products and (settings.best_seller_products_format_mobile == 'slider' or settings.best_seller_products_format_desktop == 'slider') %}
{% set use_slider = has_featured_products_and_slider or has_new_products_and_slider or has_sale_products_and_slider or has_promotion_products_and_slider or has_best_seller_products_and_slider %}

{% if featured_products %}
    {% set sections_products = sections.primary.products %}
    {% set section_name = 'primary' %}
    {% set section_columns_desktop = settings.featured_products_desktop %}
    {% set section_columns_mobile = settings.featured_products_mobile %}
    {% set section_slider = settings.featured_products_format_mobile == 'slider' or settings.featured_products_format_desktop == 'slider' %}
    {% set section_slider_both = settings.featured_products_format_mobile == 'slider' and settings.featured_products_format_desktop == 'slider' %}
    {% set section_slider_mobile_only = settings.featured_products_format_mobile == 'slider' and settings.featured_products_format_desktop == 'grid' %}
    {% set section_slider_desktop_only = settings.featured_products_format_desktop == 'slider' and settings.featured_products_format_mobile == 'grid' %}
    {% set section_slider_desktop = settings.featured_products_format_desktop == 'slider' %}
    {% set section_format_desktop = settings.featured_products_format_desktop %}
    {% set section_format_mobile = settings.featured_products_format_mobile %}
    {% set section_id = 'featured' %}
    {% set section_title = settings.featured_products_title %}
{% endif %}
{% if new_products %}
    {% set sections_products = sections.new.products %}
    {% set section_name = 'new' %}
    {% set section_columns_desktop = settings.new_products_desktop %}
    {% set section_columns_mobile = settings.new_products_mobile %}
    {% set section_slider = settings.new_products_format_mobile == 'slider' or settings.new_products_format_desktop == 'slider' %}
    {% set section_slider_both = settings.new_products_format_mobile == 'slider' and settings.new_products_format_desktop == 'slider' %}
    {% set section_slider_mobile_only = settings.new_products_format_mobile == 'slider' and settings.new_products_format_desktop == 'grid' %}
    {% set section_slider_desktop_only = settings.new_products_format_desktop == 'slider' and settings.new_products_format_mobile == 'grid' %}
    {% set section_slider_desktop = settings.new_products_format_desktop == 'slider' %}
    {% set section_format_desktop = settings.new_products_format_desktop %}
    {% set section_format_mobile = settings.new_products_format_mobile %}
    {% set section_id = 'new' %}
    {% set section_title = settings.new_products_title %}
{% endif %}
{% if sale_products %}
    {% set sections_products = sections.sale.products %}
    {% set section_name = 'sale' %}
    {% set section_columns_desktop = settings.sale_products_desktop %}
    {% set section_columns_mobile = settings.sale_products_mobile %}
    {% set section_slider = settings.sale_products_format_mobile == 'slider' or settings.sale_products_format_desktop == 'slider' %}
    {% set section_slider_both = settings.sale_products_format_mobile == 'slider' and settings.sale_products_format_desktop == 'slider' %}
    {% set section_slider_mobile_only = settings.sale_products_format_mobile == 'slider' and settings.sale_products_format_desktop == 'grid' %}
    {% set section_slider_desktop_only = settings.sale_products_format_desktop == 'slider' and settings.sale_products_format_mobile == 'grid' %}
    {% set section_slider_desktop = settings.sale_products_format_desktop == 'slider' %}
    {% set section_format_desktop = settings.sale_products_format_desktop %}
    {% set section_format_mobile = settings.sale_products_format_mobile %}
    {% set section_id = 'sale' %}
    {% set section_title = settings.sale_products_title %}
{% endif %}
{% if promotion_products %}
    {% set sections_products = sections.promotion.products %}
    {% set section_name = 'promotion' %}
    {% set section_columns_desktop = settings.promotion_products_desktop %}
    {% set section_columns_mobile = settings.promotion_products_mobile %}
    {% set section_slider = settings.promotion_products_format_mobile == 'slider' or settings.promotion_products_format_desktop == 'slider' %}
    {% set section_slider_both = settings.promotion_products_format_mobile == 'slider' and settings.promotion_products_format_desktop == 'slider' %}
    {% set section_slider_mobile_only = settings.promotion_products_format_mobile == 'slider' and settings.promotion_products_format_desktop == 'grid' %}
    {% set section_slider_desktop_only = settings.promotion_products_format_desktop == 'slider' and settings.promotion_products_format_mobile == 'grid' %}
    {% set section_slider_desktop = settings.promotion_products_format_desktop == 'slider' %}
    {% set section_format_desktop = settings.promotion_products_format_desktop %}
    {% set section_format_mobile = settings.promotion_products_format_mobile %}
    {% set section_id = 'promotion' %}
    {% set section_title = settings.promotion_products_title %}
{% endif %}
{% if best_seller_products %}
    {% set sections_products = sections.best_seller.products %}
    {% set section_name = 'best_seller' %}
    {% set section_columns_desktop = settings.best_seller_products_desktop %}
    {% set section_columns_mobile = settings.best_seller_products_mobile %}
    {% set section_slider = settings.best_seller_products_format_mobile == 'slider' or settings.best_seller_products_format_desktop == 'slider' %}
    {% set section_slider_both = settings.best_seller_products_format_mobile == 'slider' and settings.best_seller_products_format_desktop == 'slider' %}
    {% set section_slider_mobile_only = settings.best_seller_products_format_mobile == 'slider' and settings.best_seller_products_format_desktop == 'grid' %}
    {% set section_slider_desktop_only = settings.best_seller_products_format_desktop == 'slider' and settings.best_seller_products_format_mobile == 'grid' %}
    {% set section_slider_desktop = settings.best_seller_products_format_desktop == 'slider' %}
    {% set section_format_desktop = settings.best_seller_products_format_desktop %}
    {% set section_format_mobile = settings.best_seller_products_format_mobile %}
    {% set section_id = 'best-seller' %}
    {% set section_title = settings.best_seller_products_title %}
{% endif %}
{% set section_columns_slider_mobile = section_columns_mobile == '1' ? '1.15' : '2.25' %}

<div class="js-products-{{ section_id }}-container container">
    <div class="row">
        <div class="js-products-{{ section_id }}-col col-12{% if use_slider %} pr-0 pr-md-3{% endif %}">
            <h2 class="js-products-{{ section_id }}-title section-title h3 mb-4 text-center" {% if not section_title %}style="display: none;"{% endif %}>{{ section_title }}</h2>
            {% if use_slider %}
                <div class="js-swiper-{{ section_id }} swiper-container">
            {% endif %}
                     {% set section_slider_classes = section_slider_both ? 'swiper-products-slider flex-nowrap' : section_slider_mobile_only ? 'swiper-mobile-only flex-nowrap flex-md-wrap' : section_slider_desktop_only ? 'swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0' %}

                    <div class="js-products-{{ section_id }}-grid {% if use_slider %}swiper-wrapper {{ section_slider_classes }}{% endif %} row row-grid" data-desktop-columns="{{ section_columns_desktop }}" data-mobile-columns="{{ section_columns_mobile }}" data-desktop-format="{{ section_format_desktop }}" data-mobile-format="{{ section_format_mobile }}" data-mobile-slider-columns="{{ section_columns_slider_mobile }}">
                        {% for product in sections_products %}
                            {% if use_slider %}
                                {% include 'snipplets/grid/item.tpl' with {'slide_item': true, 'section_name': section_name, 'section_columns_desktop': section_columns_desktop, 'section_columns_mobile': section_columns_mobile } %}
                            {% else %}
                                {% include 'snipplets/grid/item.tpl' %}
                            {% endif %}
                        {% endfor %}
                    </div>
            {% if use_slider %}
                </div>
                {% if section_slider_desktop %}
                    <div class="js-swiper-{{ section_id }}-prev swiper-button-prev swiper-button-outside d-none d-md-block svg-icon-text">
                        <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
                    </div>
                    <div class="js-swiper-{{ section_id }}-next swiper-button-next swiper-button-outside d-none d-md-block svg-icon-text">
                        <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
                    </div>
                {% endif %}
            {% endif %}
        </div>
    </div>
</div>
