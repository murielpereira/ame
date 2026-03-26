{% if product.compare_at_price > product.price %}
{% set price_discount_percentage = ((product.compare_at_price) - (product.price)) * 100 / (product.compare_at_price) %}
{% endif %}

{% set has_product_available = product.available and product.display_price %}

{% set store_has_free_shipping = not product.is_non_shippable and (product.free_shipping or (has_product_available and (cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price))) %}

{% set product_price_above_free_shipping_minimum = cart.free_shipping.min_price_free_shipping and (product.price >= cart.free_shipping.min_price_free_shipping.min_price_raw) %}

{% set show_out_of_stock_label = not (product.has_stock and product.variations) or (product.variations and ((not product_detail and (settings.quick_shop or settings.product_color_variants)) or product_detail)) %}
{% set show_discount_labels = product.compare_at_price or product.promotional_offer %}

{% set has_multiple_slides = product.images_count > 1 or product.video_url %}

<div class="{% if product.video_url and product_detail %}js-labels-group{% endif %} labels{% if labels_floating %}-absolute{% endif %} {% if show_discount_labels and not labels_floating %}d-inline-block align-text-top{% else %}mb-2{% endif %}" {% if not labels_floating %}data-store="product-item-labels"{% endif %}>
  {% if store_has_free_shipping and labels_floating %}
    <div class="{% if not product.free_shipping %}js-free-shipping-minimum-label {% endif %} label label-accent mb-1 {% if product_detail %}label-big{% endif %}" {% if not (product.free_shipping or product_price_above_free_shipping_minimum) %}style="display: none;"{% endif %}>{{ "Envío gratis" | translate }}</div>
  {% endif %}
  {% if show_out_of_stock_label and labels_floating %}
      <div class="js-stock-label label label-default {% if product_detail %}label-big{% endif %}" {% if product.has_stock %}style="display:none;"{% endif %}>{{ "Sin stock" | translate }}</div>
  {% endif %}
  {% if show_discount_labels and not labels_floating %}
    {% if product.compare_at_price or product.promotional_offer %}
      <div class="js-offer-label label label-inline {% if product_detail %}label-big{% endif %}" {% if (not product.compare_at_price and not product.promotional_offer) or not product.display_price %}style="display:none;"{% endif %} data-store="product-item-{% if product.compare_at_price %}offer{% else %}promotion{% endif %}-label">
        {% if product.promotional_offer.script.is_percentage_off and not product_detail %}
          {{ product.promotional_offer.parameters.percent * 100 }}% OFF
        {% elseif product.promotional_offer.script.is_discount_for_quantity and not product_detail %}
          -{{ product.promotional_offer.selected_threshold.discount_decimal_percentage * 100 }}%
          {{ "Comprando {1} o más" | translate(product.promotional_offer.selected_threshold.quantity) }}
        {% elseif product.promotional_offer and not product_detail %}
          {% if store.country == 'BR' %}
            {{ "Leve {1} Pague {2}" | translate(product.promotional_offer.script.quantity_to_take, product.promotional_offer.script.quantity_to_pay) }}
          {% else %}
            {{ product.promotional_offer.script.type }} 
          {% endif %}
        {% elseif product.compare_at_price %}
          -<span class="js-offer-percentage">{{ price_discount_percentage |round }}</span>% OFF
        {% endif %}
      </div>
    {% endif %}
  {% endif %}
</div>
<span class="hidden" data-store="stock-product-{{ product.id }}-{% if product.has_stock %}{% if product.stock %}{{ product.stock }}{% else %}infinite{% endif %}{% else %}0{% endif %}"></span>