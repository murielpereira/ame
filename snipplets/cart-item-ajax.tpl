<div class="js-cart-item {% if item.product.is_non_shippable %}js-cart-item-non-shippable{% else %}js-cart-item-shippable{% endif %} cart-item row no-gutters pb-3 align-items-md-center" data-item-id="{{ item.id }}" data-store="cart-item-{{ item.product.id }}" data-component="cart.line-item">

  {% set show_free_shipping_label = item.product.free_shipping and not (cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price) %}
  {% set show_promotion_label = item.product.promotional_offer.script.is_discount_for_quantity or item.product.promotional_offer %}

  {# Cart item image #}
  <div class="col-auto">
    <a href="{{ item.url }}" class="d-block cart-item-image-col {% if cart_page%}cart-item-image-col-md{% endif %}">
      <img src="{{ item.featured_image | product_image_url('medium') }}" class="img-fluid cart-item-image {% if cart_page %}cart-item-image-md{% endif %}" />
    </a>
  </div>
  <div class="col pl-3 align-items-center">
    <div class="row align-items-center">
      
      <div class="col-12 {% if cart_page %}col-md-4 d-md-flex{% endif %}">

        {# Cart item name #}

        <div class="row w-100 no-gutters {% if cart_page %}align-items-md-center{% endif %}">

          <div class="cart-item-name-container col {% if cart_page %}col-md-8 font-md-body d-md-block{% endif %} {% if show_free_shipping_label or show_promotion_label %}mb-2{% else %}mb-3{% endif %}" data-component="line-item.name">
            <a href="{{ item.url }}" data-component="name.short-name" class="cart-item-name d-block">
              {{ item.short_name }}
              <span class="font-small" data-component="name.short-variant-name">{{ item.short_variant_name }}</span>
            </a>

            {% for key, value in item.attributes if key[:1] != '_' %}
              <div><strong>{{key}}</strong>: {{value}}</div>
            {% endfor %}

            {{ component(
              'cart-labels', {
                group: true,
                labels_classes: {
                  group: 'my-2',
                  label: 'text-accent font-smallest font-weight-bold text-uppercase w-100',
                  shipping: 'mb-1'
                },
              })
            }}
          </div>
          {# Cart item delete #}
          <div class="col-auto {% if cart_page %}d-md-none{% endif %} text-center" >
            <button type="button" class="btn btn-link no-underline text-capitalize font-weight-normal font-small pr-0 pl-2" onclick="LS.removeItem({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="line-item.remove">
              {{ "Borrar" | translate }}
            </button>
          </div>
        </div>
      </div>

      {# Cart item quantity controls #}

      {% set cart_quantity_class = cart_page ? 'float-md-none m-auto ' : '' %}
      {% set cart_quantity_input_class = cart_page ? 'py-md-2 my-1' : '' %}

      <div class="cart-item-quantity col-auto" data-component="line-item.subtotal">
        {% set cart_qty_margin = '' %}
        {% if cart_page %}
          {% set cart_qty_margin = 'm-md-auto' %}
        {% endif %}
        {% embed "snipplets/forms/form-input.tpl" with{
          type_number: true, 
          input_value: item.quantity, 
          input_name: 'quantity[' ~ item.id ~ ']', 
          input_data_attr: 'item-id',
          input_data_val: item.id,
          input_group_custom_class: cart_quantity_class ~ ' float-left form-quantity cart-item-quantity small p-0 mb-0 ' ~ cart_qty_margin, 
          input_custom_class: 'js-cart-quantity-input text-center py-1 ' ~  cart_quantity_input_class, 
          input_label: false, input_append_content: true, 
          data_component: 'quantity.value',
          form_control_container_custom_class: 'js-cart-quantity-container col px-0'} %}
            {% block input_prepend_content %}
            <div class="form-row m-0 align-items-center">
              <span class="js-cart-quantity-btn form-quantity-icon icon-30px font-small" onclick="LS.minusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="quantity.minus">
                <svg class="icon-inline"><use xlink:href="#minus"/></svg>
              </span>
            {% endblock input_prepend_content %}
            {% block input_append_content %}
              
              {# Always place this spinner before the quantity input #}
        
              <span class="js-cart-input-spinner cart-item-spinner" style="display: none;">
                <svg class="icon-inline icon-spin svg-icon-text"><use xlink:href="#spinner-third"/></svg>
              </span>

              <span class="js-cart-quantity-btn form-quantity-icon icon-30px font-small" onclick="LS.plusQuantity({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="quantity.plus">
                <svg class="icon-inline"><use xlink:href="#plus"/></svg>
              </span>
            </div>
            {% endblock input_append_content %}
        {% endembed %}
      </div>

      {% if cart_page %}
        {# Cart item unit price #}
        <span class="col-3 d-none d-md-flex justify-content-center">
          <span class="d-flex align-self-center" data-line-item-id="{{ item.id }}">{{ item.unit_price | money }}</span>
        </span>
      {% endif %}

      {# Cart item subtotal #}

      <span class="col {% if cart_page %}col-md-3 d-flex justify-content-end justify-content-md-center pr-md-0{% else %} cart-item-subtotal{% endif %} text-right">
        <span class="js-cart-item-subtotal font-weight-bold {% if cart_page %}d-md-flex align-self-center{% endif %}" data-line-item-id="{{ item.id }}" data-component="subtotal.value" data-component-value={{ item.subtotal | money }}'>{{ item.subtotal | money }}</span>
      </span>

      {% if cart_page %}
        {# Cart item delete #}
        <div class="cart-item-delete col d-none d-md-block text-center" >
          <button type="button" class="btn btn-link font-small" onclick="LS.removeItem({{ item.id }}{% if not cart_page %}, true{% endif %})" data-component="line-item.remove">
            {{ "Borrar" | translate }}
          </button>
        </div>
      {% endif %}
    </div>
  </div>
</div>