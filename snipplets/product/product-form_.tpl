<div class="pt-md-3{% if not home_main_product %} px-md-3{% endif %}">

    {# Product name and breadcrumbs for product page #}

    {% if home_main_product %}
        {# Product name #}
        <h2 class="mb-3">{{ product.name }}</h2>
    {% else %}
        <div class="d-none d-md-block">
        {% embed "snipplets/page-header.tpl" with {container: false, padding: false, page_header_title_class: 'js-product-name mb-3'} %}
            {% block page_header_text %}{{ product.name }}{% endblock page_header_text %}
        {% endembed %}
        </div>
    {% endif %}

    {# Product SKU #}

    {% if settings.product_sku and product.sku %}
        <div class="font-small opacity-60 mb-3">
            {{ "SKU" | translate }}: <span class="js-product-sku">{{ product.sku }}</span>
        </div>
    {% endif %}

    {# Product price #}

    <div class="price-container" data-store="product-price-{{ product.id }}">
        <div class="mb-3">
            
            {# 1. Preço de Comparação (Riscado - Opcional se houver desconto) #}
            <span class="d-block font-big title-font-family mt-1 mb-1">
               <div id="compare_price_display" class="js-compare-price-display price-compare {% if settings.payment_discount_price %}font-body{% endif %}" {% if not product.compare_at_price or not product.display_price %}style="display:none;"{% else %} style="display:block;"{% endif %} style="text-decoration: line-through; opacity: 0.6;">
                   {% if product.compare_at_price and product.display_price %}De: {{ product.compare_at_price | money }}{% endif %}
               </div>
            </span>

            {# 2. Preço do Cartão (Principal com 'a partir de') #}
            <div class="d-flex align-items-baseline mb-1" style="gap: 5px;">
                <span class="font-small opacity-80">{{ 'a partir de' | translate }}</span>
                <span class="d-inline-block mr-1">
                    <div class="js-price-display h3 mb-0" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}">
                        {% if product.display_price %}{{ product.price | money }}{% endif %}
                    </div>
                </span>
                {% include 'snipplets/labels.tpl' with {product_detail: true} %}
            </div>

            {# 3. Preço Pix ('ou R$ VALOR no PIX') #}
            {% if settings.payment_discount_price %}
                <div class="d-flex align-items-baseline mt-1" style="gap: 5px;">
                    <span class="font-small opacity-80">{{ 'ou' | translate }}</span>
                    {{ component('payment-discount-price', {
                            visibility_condition: settings.payment_discount_price,
                            location: 'product',
                            container_classes: "d-inline-block",
                            text_classes: {
                                price: 'h5 text-accent font-weight-bold mb-0',
                            },
                        }) 
                    }}
                    <span class="font-small opacity-80">no PIX</span>
                </div>
            {% endif %}

            {# 4. Parcelas sem juros (Abaixo do PIX) #}
            {% set max_installments_without_interest = product.get_max_installments(false) %}
            {% if max_installments_without_interest and max_installments_without_interest.installment > 1 %}
                <div class="installments-manual font-small mt-1 opacity-80">
                    ou {{ max_installments_without_interest.installment }}x de {{ max_installments_without_interest.installment_data.installment_value_cents | money }} sem juros
                </div>
            {% endif %}

        </div>

        {% set installments_info = product.installments_info_from_any_variant %}
        {% set hasDiscount = product.maxPaymentDiscount.value > 0 %}
        {% set show_payments_info = settings.product_detail_installments and product.show_installments and product.display_price and installments_info %}
        {% set showDiscount = hasDiscount and product.showMaxPaymentDiscount %}
        {% set discountContainerStyle = not (showDiscount) ? "display: none" %}

        {% if not home_main_product and (show_payments_info or showDiscount) %}
            <div {% if installments_info %}data-toggle="#installments-modal" data-modal-url="modal-fullscreen-payments"{% endif %} class="{% if installments_info %}js-modal-open js-fullscreen-modal-open{% endif %} js-product-payments-container mb-3 {% if not home_main_product %}col-md-8{% endif %} px-0" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
        {% endif %}
        
            <div class="js-product-discount-container mb-2 font-small" style="{{ discountContainerStyle }}">
                <span class="text-accent">{{ product.maxPaymentDiscount.value }}% {{'de descuento' | translate }}</span> {{'pagando con' | translate }} {{ product.maxPaymentDiscount.paymentProviderName }}
                {% set discountDisclaimerStyle = not product.showMaxPaymentDiscountNotCombinableDisclaimer ? "display: none" %}
                    <div class="js-product-discount-disclaimer font-small mt-1 opacity-60" style="{{ discountDisclaimerStyle }}">
                        {{ "No acumulable con otras promociones" | translate }}
                    </div>
            </div>
            
        {% if not home_main_product and (show_payments_info or hasDiscount) %}
                <a id="btn-installments" class="font-small" href="#installments-modal" {% if not (product.get_max_installments and product.get_max_installments(false)) %}style="display: none;"{% endif %}>
                    <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#credit-card"/></svg>
                    {% if not hasDiscount and not settings.product_detail_installments %}
                        {{ "Ver medios de pago" | translate }}
                    {% else %}
                        {{ "Ver más detalles" | translate }}
                    {% endif %}
                </a>
            </div>
        {% endif %}

        {# Product availability #}
    
        {% set show_product_quantity = product.available and product.display_price %}

        {# Free shipping minimum message #}
        {% set has_free_shipping = cart.free_shipping.cart_has_free_shipping or cart.free_shipping.min_price_free_shipping.min_price %}
        {% set has_product_free_shipping = product.free_shipping %}

        {% if not product.is_non_shippable and show_product_quantity and (has_free_shipping or has_product_free_shipping) %}
            <div class="free-shipping-message mb-4">
                <span class="float-left mr-1">
                    <svg class="icon-inline svg-icon-accent icon-lg"><use xlink:href="#truck"/></svg>
                </span>
                <span class="font-small">
                    <span class="text-accent">{{ "Envío gratis" | translate }}</span>
                    <span {% if has_product_free_shipping %}style="display: none;"{% else %}class="js-shipping-minimum-label"{% endif %}>
                        {{ "superando los" | translate }} <span>{{ cart.free_shipping.min_price_free_shipping.min_price }}</span>
                    </span>
                </span>
            </div>
        {% endif %}
    </div>

    {# Promotional text #}

    {% if product.promotional_offer and not product.promotional_offer.script.is_percentage_off and product.display_price %}
        <div class="js-product-promo-container {% if not home_main_product %}col-md-8{% endif %} px-0" data-store="product-promotion-info">
            {% if product.promotional_offer.script.is_discount_for_quantity %}
                {% for threshold in product.promotional_offer.parameters %}
                    <div class="mb-1 mt-4 text-accent">{{ "¡{1}% OFF comprando {2} o más!" | translate(threshold.discount_decimal_percentage * 100, threshold.quantity) }}</div>
                {% endfor %}
            {% else %}
                <div class="mb-1 mt-4 text-accent">{{ "¡Llevá {1} y pagá {2}!" | translate(product.promotional_offer.script.quantity_to_take, product.promotional_offer.script.quantity_to_pay) }}</div>
            {% endif %}
            {% if product.promotional_offer.scope_type == 'categories' %}
                <p class="font-small">{{ "Válido para" | translate }} {{ "este producto y todos los de la categoría" | translate }}:
                {% for scope_value in product.promotional_offer.scope_value_info %}
                   {{ scope_value.name }}{% if not loop.last %}, {% else %}.{% endif %}
                {% endfor %}</br>{{ "Podés combinar esta promoción con otros productos de la misma categoría." | translate }}</p>
            {% elseif product.promotional_offer.scope_type == 'all'  %}
                <p class="font-small">{{ "Vas a poder aprovechar esta promoción en cualquier producto de la tienda." | translate }}</p>
            {% endif %}
        </div>
    {% endif %}

    {# Product form, includes: Variants, CTA and Shipping calculator #}

     <form id="product_form" class="js-product-form mt-4" method="post" action="{{ store.cart_url }}" data-store="product-form-{{ product.id }}">
        <input type="hidden" name="add_to_cart" value="{{product.id}}" />
        {% if template == "product" %}
            {% set show_size_guide = true %}
        {% endif %}
        {% if product.variations %}
            {% include "snipplets/product/product-variants.tpl" with {show_size_guide: show_size_guide} %}
        {% endif %}

        {% set tags = product.tags %}
        {% set customizations = ['product_custom_fields_1', 'product_custom_fields_2', 'product_custom_fields_3', 'product_custom_fields_4', 'product_custom_fields_5', 'product_custom_fields_6', 'product_custom_fields_7', 'product_custom_fields_8', 'product_custom_fields_9', 'product_custom_fields_10', 'product_custom_fields_11', 'product_custom_fields_12', 'product_custom_fields_13', 'product_custom_fields_14', 'product_custom_fields_15', 'product_custom_fields_16'] %}
        {% set cta_group_1 = settings.product_custom_fields_cta_group_1_tag %}
        {% set cta_group_2 = settings.product_custom_fields_cta_group_2_tag %}
        {% set cta_group_3 = settings.product_custom_fields_cta_group_3_tag %}
        {% set cta_group_4 = settings.product_custom_fields_cta_group_4_tag %}
        {% set cta_group_5 = settings.product_custom_fields_cta_group_5_tag %}

        {% set has_cta_group = false %}
        {% set has_cta_text = '' %}

        {% for tag in tags %}
            {% if cta_group_1 == tag or cta_group_2 == tag or cta_group_3 == tag or cta_group_4 == tag or cta_group_5 == tag %}
                {% set has_cta_group = true %}
                {% if cta_group_1 == tag %}
                    {% set has_cta_text = settings.product_custom_fields_cta_group_1_text %}
                {% elseif cta_group_2 == tag %}
                    {% set has_cta_text = settings.product_custom_fields_cta_group_2_text %}
                {% elseif cta_group_3 == tag %}
                    {% set has_cta_text = settings.product_custom_fields_cta_group_3_text %}
                {% elseif cta_group_4 == tag %}
                    {% set has_cta_text = settings.product_custom_fields_cta_group_4_text %}
                {% elseif cta_group_5 == tag %}
                    {% set has_cta_text = settings.product_custom_fields_cta_group_5_text %}
                {% endif %}
            {% endif %}
        {% endfor %}

        {% if has_cta_group %}
            <div class="cta-group-container mb-3">
                <div class="cta-group-item">
                    <a href="#" class="btn btn-default w-100 d-block text-center js-cta-group-button">{{ has_cta_text }}</a>
                </div>
            </div>
        {% endif %}

        <div class="customizations-container mb-3" {% if has_cta_group %}style="display: none;"{% endif %}>
        {% for tag in tags %}
            {% for customization in customizations %}



                {% set customization_enabled = attribute(settings,"#{customization}_enable") %}
                {% set customization_tag = attribute(settings,"#{customization}_tag") %}

                {% if tag | trim == customization_tag | trim and customization_enabled %}
                    {% set customization_name = attribute(settings,"#{customization}_name") %}
                    {% set customization_title = attribute(settings,"#{customization}_title") %}
                    {% set customization_helper = attribute(settings,"#{customization}_helper") %}
                    {% set customization_type = attribute(settings,"#{customization}_type") %}
                    {% set customization_options = attribute(settings,"#{customization}_options") %}
                    {% set customization_images = attribute(settings,"#{customization}_images") %}
                    {% set customization_order = attribute(settings,"#{customization}_order") %}
                    {% set customization_limiter = attribute(settings,"#{customization}_limiter") %}
                    {% set customization_required = attribute(settings,"#{customization}_required") %}

                    {% if customization_type == 'text' %}
                        <div class="lb-relative lb-input-container" style="order: {{ customization_order }};">
                            <input 
                                data-name="{{ customization_name }}"
                                {% if customization_required %}
                                    data-required="true"
                                {% endif %}
                                type="text"
                                tabindex="{{ customization_order }}" 
                                name="properties[{{ customization_name }}]" 
                                placeholder="{{ customization_title }}" 
                                minlength="1" 
                                {% if customization_limiter %}
                                maxlength="{{ customization_limiter }}" 
                                {% endif %}
                                class="form-control js-customization-input-validation" 
                                value=""
                            />
                            <div class="lb-customization-input-validation-message" data-name="{{ customization_name }}" style="display: none;">
                                {{ "Por favor, preencha todos os campos obrigatórios." | translate }}
                            </div>
                            {% if customization_limiter %}
                                <div class="lb-imput-helper-limiter" data-name="{{ customization_name }}">{{ customization_limiter }}</div>
                            {% endif %}
                            {% if customization_helper %}
                                <div class="lb-imput-helper">{{ customization_helper }}</div>
                            {% endif %}
                        </div>
                    {% elseif customization_type == 'date' %}
                        <div class="lb-relative lb-input-container" style="order: {{ customization_order }};">
                            <label class="form-label">{{ customization_title }}</label>
                            <input 
                                data-name="{{ customization_name }}"
                                {% if customization_required %}
                                    data-required="true"
                                {% endif %}
                                type="text"
                                tabindex="{{ customization_order }}"
                                name="properties[{{ customization_name }}]" 
                                placeholder="{{ customization_title }}" 
                                minlength="1" 
                                {% if customization_limiter %}
                                maxlength="{{ customization_limiter }}" 
                                {% endif %}
                                class="form-control js-customization-input-validation flatpickr" 
                                value=""
                            />
                            <div class="lb-customization-input-validation-message" data-name="{{ customization_name }}" style="display: none;">
                                {{ "Por favor, preencha todos os campos obrigatórios." | translate }}
                            </div>
                            {% if customization_limiter %}
                                <div class="lb-imput-helper-limiter" data-name="{{ customization_name }}">{{ customization_limiter }}</div>
                            {% endif %}
                            {% if customization_helper %}
                                <div class="lb-imput-helper">{{ customization_helper }}</div>
                            {% endif %}
                        </div>
                    {% elseif customization_type == 'long_text' %}
                        <div class="lb-relative lb-input-container" style="order: {{ customization_order }};">
                            <textarea 
                                data-name="{{ customization_name }}"
                                {% if customization_required %}
                                    data-required="true"
                                {% endif %}
                                tabindex="{{ customization_order }}"
                                type="textarea"
                                name="properties[{{ customization_name }}]" 
                                placeholder="{{ customization_title }}" 
                                minlength="1" 
                                {% if customization_limiter %}
                                maxlength="{{ customization_limiter }}" 
                                {% endif %}
                                class="form-control js-customization-input-validation" 
                                style="max-height: 150px; resize: vertical; min-height: 80px;"
                            ></textarea>
                            <div class="lb-customization-input-validation-message" data-name="{{ customization_name }}" style="display: none;">
                                {{ "Por favor, preencha todos os campos obrigatórios." | translate }}
                            </div>
                            {% if customization_limiter %}
                                <div class="lb-imput-helper-limiter" data-name="{{ customization_name }}">{{ customization_limiter }}</div>
                            {% endif %}
                            {% if customization_helper %}
                                <div class="lb-imput-helper">{{ customization_helper }}</div>
                            {% endif %}
                        </div>
                    {% elseif customization_type == 'radio' %}
                        <div class="lb-relative lb-input-container" style="order: {{ customization_order }};">
                            <label class="form-label">{{ customization_title }}: <strong class="js-insta-variation-label"></strong></label>
                            <div class="lb-customization-radio-container">
                            {% if customization_images and customization_images is not empty %}
                                {% for slide in customization_images %}
                                    <button type="button" class="lb-customization-radio-label lb-customization-radio-label-image" title="{{ slide.link }}" data-value="{{ slide.link }}">
                                        <img src="{{ slide.image | static_url | settings_image_url('large') }}" alt="{{ slide.link }}" class="lb-image-customization" />
                                        {% if slide.link %}
                                            <span class="lb-image-customization-placeholder">
                                                {{ slide.link }}   
                                            </span>
                                        {% endif %}
                                    </button>
                                {% endfor %}
                            {% elseif customization_options | split(',') | length > 0 %}
                                {% set optionsArray = customization_options | split(',') %}
                                {% if optionsArray | length > 0 %}
                                    {% for option in optionsArray %}
                                        <button type="button" class="btn btn-variant lb-customization-radio-label" title="{{ option }}" data-value="{{ option }}">
                                            <span class="btn-variant-content" data-name="{{ option }}">{{ option }}</span>
                                        </button>
                                    {% endfor %}
                                {% endif %}
                            {% endif %}
                            </div>
                            <div class="lb-customization-input-validation-message" data-name="{{ customization_name }}" style="display: none;">
                                {{ "Por favor, preencha todos os campos obrigatórios." | translate }}
                            </div>

                            <input type="hidden"
                                data-name="{{ customization_name }}"
                                {% if customization_required %}
                                    data-required="true"
                                {% endif %}
                                name="properties[{{ customization_name }}]" 
                                minlength="1" 
                                {% if customization_limiter %}
                                maxlength="{{ customization_limiter }}" 
                                {% endif %}
                                class="js-customization-radio-input js-customization-input-validation"
                                value=""
                            />
                            {% if customization_helper %}
                                <div class="lb-imput-helper">{{ customization_helper }}</div>
                            {% endif %}
                        </div>
                    {% endif %}
                    
                    
                {% endif %}
            {% endfor %}
        {% endfor %}
        </div>

        {% if settings.last_product and show_product_quantity %}
            <div class="{% if product.variations %}js-last-product{% endif %} text-accent mb-3"{% if product.selected_or_first_available_variant.stock != 1 %} style="display: none;"{% endif %}>
                {{ settings.last_product_text }}
            </div>
        {% endif %}

        <div class="row no-gutters mb-4 {% if settings.product_stock %}mb-md-3{% endif %}">
            {% set product_quantity_home_product_value = home_main_product ? true : false %}
            {% if show_product_quantity %}
                {% include "snipplets/product/product-quantity.tpl" with {home_main_product: product_quantity_home_product_value} %}
            {% endif %}
            {% set state = store.is_catalog ? 'catalog' : (product.available ? product.display_price ? 'cart' : 'contact' : 'nostock') %}
            {% set texts = {'cart': "Agregar al carrito", 'contact': "Consultar precio", 'nostock': "Sin stock", 'catalog': "Consultar"} %}
            <div class="{% if show_product_quantity %}col-8 {% if not home_main_product %}col-md-9{% endif %}{% else %}col-12{% endif %}">

                {# Add to cart CTA #}

                <input type="submit" class="js-addtocart js-prod-submit-form btn-add-to-cart btn btn-primary btn-big btn-block {{ state }}" value="{{ texts[state] | translate }}" {% if state == 'nostock' %}disabled{% endif %} data-store="product-buy-button" data-component="product.add-to-cart"/>

                {# Fake add to cart CTA visible during add to cart event #}

                {% include 'snipplets/placeholders/button-placeholder.tpl' with {custom_class: "btn-big"} %}

            </div>

            {% if settings.ajax_cart %}
                <div class="col-12">
                    <div class="js-added-to-cart-product-message font-small my-3" style="display: none;">
                        <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#check"/></svg>
                        <span>
                            {{'Ya agregaste este producto.' | translate }}<a href="#" class="js-modal-open js-open-cart js-fullscreen-modal-open btn-link font-small ml-1" data-toggle="#modal-cart" data-modal-url="modal-fullscreen-cart">{{ 'Ver carrito' | translate }}</a>
                        </span>
                    </div>
                </div>
            {% endif %}

            {# Free shipping visibility message #}

            {% set free_shipping_minimum_label_changes_visibility = has_free_shipping and cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

            {% set include_product_free_shipping_min_wording = cart.free_shipping.min_price_free_shipping.min_price_raw > 0 %}

            {% if not product.is_non_shippable and show_product_quantity and has_free_shipping and not has_product_free_shipping %}

                {# Free shipping add to cart message #}

                {% if include_product_free_shipping_min_wording %}

                    {% include "snipplets/shipping/shipping-free-rest.tpl" with {'product_detail': true} %}

                {% endif %}

                {# Free shipping achieved message #}

                <div class="{% if free_shipping_minimum_label_changes_visibility %}js-free-shipping-message{% endif %} text-accent font-weight-bold my-2 pt-1 h6" {% if not cart.free_shipping.cart_has_free_shipping %}style="display: none;"{% endif %}>
                    {{ "¡Genial! Tenés envío gratis" | translate }}
                </div>

            {% endif %}
        </div>

        {% if template == 'product' %}

            {% set show_product_fulfillment = settings.shipping_calculator_product_page and (store.has_shipping or store.branches) and not product.free_shipping and not product.is_non_shippable %}

            {% if show_product_fulfillment %}
                <div class="mb-4 pb-2">
                    {# Shipping calculator and branch link #}

                    <div id="product-shipping-container" class="product-shipping-calculator list" {% if not product.display_price or not product.has_stock %}style="display:none;"{% endif %} data-shipping-url="{{ store.shipping_calculator_url }}">
                        {% if store.has_shipping %}
                            {% include "snipplets/shipping/shipping-calculator.tpl" with {'shipping_calculator_variant' : product.selected_or_first_available_variant, 'product_detail': true} %}
                        {% endif %}
                    </div>

                    {% if store.branches %} 
                        {# Link for branches #}
                        {% include "snipplets/shipping/branches.tpl" with {'product_detail': true} %}
                    {% endif %}
                </div>

            {% endif %}
        {% endif %}
     </form>
</div>

{% if not home_main_product %}
   {# Product payments details #}
    {% include 'snipplets/product/product-payment-details.tpl' %}
{% endif %}