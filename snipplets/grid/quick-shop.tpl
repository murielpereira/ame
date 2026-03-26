{% if settings.quick_shop %}
    {% embed "snipplets/modal.tpl" with{modal_id: 'quickshop-modal', modal_class: 'quickshop bottom modal-overflow-none modal-bottom-sheet', modal_position: 'bottom', modal_transition: 'slide', modal_footer: false, modal_width: 'centered-md modal-centered-medium', modal_header_class: 'js-quickshop-header d-md-none', modal_body_class: 'modal-scrollable p-0 p-md-3'} %}
        {% block modal_head %}
            {% block page_header_text %}<div class="js-item-name"></div>{% endblock page_header_text %}
        {% endblock %}
        {% block modal_body %}
            <div class="js-item-product modal-scrollable modal-scrollable-area" data-product-id="">
                <div class="js-product-container js-quickshop-container js-quickshop-modal js-quickshop-modal-shell" data-variants="" data-quickshop-id="">
                    <div class="row no-gutters">
                        <div class="col-md-6 mb-1">
                            <div class="quickshop-image-container px-3 px-md-0">
                                <div class="js-quickshop-image-padding">
                                    <img srcset="" class="js-item-image js-quickshop-img quickshop-image img-absolute-centered"/>
                                </div>
                            </div>
                        </div>
                        <div class="js-item-variants col-md-6 p-3 pt-md-2 pr-md-3">
                            <div class="row no-gutters align-items-start mr-md-1 mb-3 d-none d-md-flex">
                                <div class="col">
                                    <div class="js-item-name h2 mb-2 mb-md-0" data-store="product-item-price-{{ product.id }}"></div>
                                </div>
                                <div class="col-auto d-none d-md-block">
                                    <a class="js-modal-close modal-close pr-0 py-0">
                                        <svg class="icon-inline svg-icon-text"><use xlink:href="#times"/></svg>
                                    </a>
                                </div>
                            </div>
                            <div class="mb-4 mr-md-1">
                                <div class="d-flex align-items-center" data-store="product-item-price-{{ product.id }}">
                                    <span class="js-price-display h4"></span>
                                    <span class="js-compare-price-display price-compare font-weight-normal ml-2"></span>
                                </div>
                                {{ component('payment-discount-price', {
                                        visibility_condition: settings.payment_discount_price,
                                        location: 'product',
                                        container_classes: "mt-2 font-body",
                                        text_classes: {
                                            price: 'font-big text-accent font-weight-bold',
                                        },
                                    }) 
                                }}
                            </div>
                            {# Image is hidden but present so it can be used on cart notifiaction #}
                            
                            <div id="quickshop-form" class="mr-md-1"></div>
                        </div>
                    </div>
                </div>
            </div>
        {% endblock %}
    {% endembed %}
{% endif %}