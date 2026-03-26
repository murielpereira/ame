<div class="js-addtocart js-addtocart-placeholder btn {% if direct_add %}btn-small btn-smallest-md px-4{% endif %} btn-primary btn-block btn-transition {{ custom_class }} disabled" style="display: none;">
    <div class="d-inline-block">
        <span class="js-addtocart-text">
            {% if direct_add %}
                <div class="d-flex justify-content-center align-items-center">
                    {{ 'Comprar' | translate }}
                </div>
            {% else %}
                {{ 'Agregar al carrito' | translate }}
            {% endif %}
        </span>
        <span class="js-addtocart-success transition-container">
            {{ '¡Listo!' | translate }}
        </span>
        <div class="js-addtocart-adding transition-container">
            {{ 'Agregando...' | translate }}
        </div>
    </div>
</div>