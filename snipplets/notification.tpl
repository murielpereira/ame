{# Cookie validation #}

{% if show_cookie_banner and not params.preview %}
    <div class="js-notification js-notification-cookie-banner notification notification-fixed-bottom notification-above notification-primary text-left font-small" style="display: none;">
        {{ 'Al navegar por este sitio <strong>aceptás el uso de cookies</strong> para agilizar tu experiencia de compra.' | translate }}
        <a href="#" class="js-notification-close js-acknowledge-cookies btn btn-link font-small pt-1 pl-1 d-inline-block" data-amplitude-event-name="cookie_banner_acknowledge_click">{{ "Entendido" | translate }}</a>
    </div>
{% endif %}

{% if order_notification and status_page_url %}
    <div class="js-notification js-notification-status-page notification notification-primary notification-order notification-fixed" style="display:none;" data-url="{{ status_page_url }}">
        <div class="container px-0">
            <div class="d-flex align-items-center">
                <div class="col px-0">
                    <a class="mr-4 d-block" href="{{ status_page_url }}"><span class="btn-link font-small">{{ "Seguí acá" | translate }}</span> {{ "tu última compra" | translate }}</a>
                    <a class="js-notification-close js-notification-status-page-close notification-close" href="#">
                        <svg class="icon-inline font-body"><use xlink:href="#times"/></svg>
                    </a>
                </div>
            </div>
        </div>
    </div>
{% endif %}
{% if add_to_cart %}
    <div class="js-alert-added-to-cart notification-floating notification-cart-container notification-hidden notification-fixed position-absolute{% if not settings.head_fix_desktop %} position-fixed-md{% endif %}" style="display: none;">
        <div class="notification notification-primary notification-cart">
            <div class="js-cart-notification-close notification-close mt-2 mr-1">
                <svg class="icon-inline icon-lg notification-icon"><use xlink:href="#times"/></svg>
            </div>
            <div class="js-cart-notification-item row no-gutters" data-store="cart-notification-item">
                <div class="col-auto pr-0 notification-img">
                    <img src="" class="js-cart-notification-item-img img-absolute-centered-vertically" />
                </div>
                <div class="col text-left pl-2 font-small">
                    <div class="mb-1 mr-4">
                        <span class="js-cart-notification-item-name"></span>
                        <span class="js-cart-notification-item-variant-container" style="display: none;">
                            (<span class="js-cart-notification-item-variant"></span>)
                        </span>
                    </div>
                    <div class="mb-1">
                        <span class="js-cart-notification-item-quantity"></span>
                        <span> x </span>
                        <span class="js-cart-notification-item-price"></span>
                    </div>
                    <strong>{{ '¡Agregado al carrito con éxito!' | translate }}</strong>
                </div>
            </div>
        </div>
    </div>
{% endif %}
