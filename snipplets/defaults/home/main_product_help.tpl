{% set product_view_box = '0 0 1000 1000' %}

<div id="single-product" class="js-has-new-shipping section-home" data-store="home-product-main">
    <div class="container">
        <div class="row justify-content-md-center">
            <div class="col-md-9">
                <div class="row">
                    <div class="col-md-8">
                        <div class="row">
                            <div class="d-none d-md-block order-last order-md-0 col-md-auto pr-md-0 mt-3 mt-md-0">
                                <div class="product-thumbs-container position-relative">
                                    <div class="text-center d-none d-md-block">
                                        <div class="js-swiper-product-thumbs-prev-demo swiper-button-prev swiper-product-thumb-control svg-icon-text">
                                            <svg class="icon-inline icon-lg icon-flip-vertical"><use xlink:href="#chevron-down"/></svg>
                                        </div>
                                    </div>
                                    <div class="js-swiper-product-thumbs-demo swiper-product-thumb">
                                        <div class="swiper-wrapper">
                                            <div class="swper-slide w-auto">
                                                <div class="js-product-thumb-demo d-block position-relative mb-3 selected">
                                                    <svg viewBox='{{ product_view_box }}'><use xlink:href="#item-product-placeholder-3"/></svg>
                                                </div>
                                            </div>
                                            <div class="swper-slide w-auto">
                                                <div class="js-product-thumb-demo d-block position-relative mb-3 selected">
                                                    <svg viewBox='{{ product_view_box }}'><use xlink:href="#product-image-green-placeholder"/></svg>
                                                </div>
                                            </div>
                                            <div class="swper-slide w-auto">
                                                <div class="js-product-thumb-demo d-block position-relative mb-3 selected">
                                                    <svg viewBox='{{ product_view_box }}'><use xlink:href="#product-image-red-placeholder"/></svg>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-center d-none d-md-block">
                                        <div class="js-swiper-product-thumbs-next-demo swiper-button-next swiper-product-thumb-control svg-icon-text">
                                            <svg class="icon-inline icon-lg"><use xlink:href="#chevron-down"/></svg>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md p-0 px-md-3">
                                <div class="js-swiper-product-demo swiper-container product-detail-slider">
                                    <div class="labels-absolute">
                                        <div class="label label-big label-accent">
                                            {{ "Envío gratis" | translate }}
                                        </div>
                                    </div>
                                    <div class="swiper-wrapper">
                                         <div class="js-product-slide-demo w-100 swiper-slide product-slide-small slider-slide" data-image="0" data-image-position="0">
                                            <div class="d-block p-relative">
                                                <svg viewBox='{{ product_view_box }}'><use xlink:href="#item-product-placeholder-3"/></svg>
                                            </div>
                                         </div>
                                         <div class="js-product-slide-demo w-100 swiper-slide product-slide-small slider-slide" data-image="1" data-image-position="1">
                                            <div class="d-block p-relative">
                                                <svg viewBox='{{ product_view_box }}'><use xlink:href="#product-image-green-placeholder"/></svg>
                                            </div>
                                         </div>
                                         <div class="js-product-slide-demo w-100 swiper-slide product-slide-small slider-slide" data-image="2" data-image-position="2">
                                            <div class="d-block p-relative">
                                                <svg viewBox='{{ product_view_box }}'><use xlink:href="#product-image-red-placeholder"/></svg>
                                            </div>
                                         </div>
                                    </div>
                                </div>
                                <div class="js-swiper-product-pagination-demo swiper-pagination position-relative pt-3 pb-1 d-md-none"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col">
                        <div class="pt-md-3">
                            <h2 class="mb-3">{{ "Producto de ejemplo" | translate }}</h2>

                            {# Product price #}

                            {% set price_value = store.country == 'BR' ? '18200' : '182000' %}
                            {% set price_compare_value = store.country == 'BR' ? '28000' : '280000' %}

                            <div class="price-container">
                                <div class="mb-3">
                                    <span class="d-inline-block mr-1 h3">
                                        {{ price_value | money }}
                                    </span>
                                    <div class=" labels d-inline-block align-text-top">
                                        <div class="label label-inline label-big">
                                          -35% OFF
                                        </div>
                                    </div>
                                    <div class="d-block price-compare font-big title-font-family mt-1">
                                        {{ price_value | money }}
                                    </div>
                                </div>
                            </div>

                            {# Product installments #}

                            <div class="mb-3">{{ "Hasta 12 cuotas" | translate }}</div>

                            {# Product form, includes: Variants, CTA and Shipping calculator #}

                            <form id="product_form" class="js-product-form mt-4" method="post" action="">
                                <div class="js-product-variants form-row mb-1">
                                    <div class="col-12 mb-2">
                                        <div class="form-group">
                                            <label class="form-label" for="variation_1">{{ "Color" | translate }}</label>
                                            <select id="variation_1" class="form-select js-variation-option js-refresh-installment-data  " name="variation[0]">
                                                <option value="{{ "Verde" | translate }}">{{ "Verde" | translate }}</option>
                                                <option value="{{ "Rojo" | translate }}">{{ "Rojo" | translate }}</option>
                                            </select>
                                            <div class="form-select-icon">
                                                <svg class="icon-inline icon-w-14"><use xlink:href="#chevron-down"/></svg>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row no-gutters mb-4">
                                    <div class="col-4 mx-neg-1">
                                        {% embed "snipplets/forms/form-input.tpl" with{
                                        type_number: true, input_value: '1', 
                                        input_name: 'quantity' ~ item.id, 
                                        input_custom_class: 'js-quantity-input form-control-big form-control-inline', 
                                        input_label: false, 
                                        input_append_content: true, 
                                        input_group_custom_class: 'js-quantity form-quantity', 
                                        form_control_container_custom_class: 'col px-0', 
                                        form_control_quantity: true,
                                        input_min: '1'} %}
                                            {% block input_prepend_content %}
                                            <div class="form-row m-0 align-items-center">
                                                <span class="js-quantity-down form-quantity-icon btn icon-30px ml-1">
                                                    <svg class="icon-inline"><use xlink:href="#minus"/></svg>
                                                </span>
                                            {% endblock input_prepend_content %}
                                            {% block input_append_content %}
                                                <span class="js-quantity-up form-quantity-icon btn icon-30px mr-1">
                                                    <svg class="icon-inline"><use xlink:href="#plus"/></svg>
                                                </span>
                                            </div>
                                            {% endblock input_append_content %}
                                        {% endembed %}
                                    </div>
                                    <div class="col-8">
                                        <input type="submit" class="btn-add-to-cart btn btn-primary btn-big btn-block cart" value="{{ 'Agregar al carrito' | translate }}" />
                                    </div>
                                </div>
                            </form>

                            {# Product description #}

                            <h6 class="mb-4">{{ "Descripción" | translate }}</h6>

                            <div class="user-content font-small mb-4">
                                <p>{{ "¡Este es un producto de ejemplo! Para poder probar el proceso de compra, debes" | translate }}
                                    <a href="/admin/products" target="_top">{{ "agregar tus propios productos." | translate }}</a>
                                </p>
                            </div>
                        </div>                
                    </div>
                </div>
            </div>
        </div>
    </div>  
</div>