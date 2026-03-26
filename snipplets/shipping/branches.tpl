<div class="js-accordion-private-container{% if store.branches|length > 1 %} js-toggle-branches{% endif %}">
    <a href="#" class="js-accordion-private-toggle py-2 row align-items-center">
        <div class="col">
            <div class="m-0">
                <svg class="icon-inline icon-lg svg-icon-text mr-1"><use xlink:href="#store"/></svg>
                {% if store.branches|length > 1 %}
                    {{ 'Nuestros locales' | translate }}
                {% else %}
                    {{ 'Nuestro local' | translate }}
                {% endif %}
            </div>
        </div>
        <div class="col-auto">
            <span class="js-accordion-private-toggle-inactive" {% if store.branches|length == 1 %}style="display: none;"{% endif %}>
                <svg class="icon-inline svg-icon-text"><use xlink:href="#plus"/></svg>
            </span>
            <span class="js-accordion-private-toggle-active" {% if store.branches|length > 1 %}style="display: none;"{% endif %}>
                <svg class="icon-inline svg-icon-text"><use xlink:href="#minus"/></svg>
            </span>
        </div>
    </a>
    <div class="js-accordion-private-content mt-2 pt-1"{% if store.branches|length > 1 %} style="display: none;"{% endif %}>
    {% if not product_detail %}
        <div class="radio-buttons-group">
    {% else %}
        <div class="list">
    {% endif %}
            <ul class="radio-button-container list-unstyled">

                {% for branch in store.branches %}
                    <li class="card {% if product_detail %}list-item list-item-shipping radio-button{% else %}radio-button-item{% endif %} p-3 {% if loop.last %}mb-0{% endif %}" data-store="branch-item-{{ branch.code }}">

                        {# If cart use radiobutton #}

                        {% if not product_detail %}
                            <label class="js-shipping-radio js-branch-radio radio-button" data-loop="branch-radio-{{loop.index}}">
                        
                                <input 
                                class="js-branch-method {% if cart.shipping_data.code == branch.code %} js-selected-shipping-method {% endif %} shipping-method" 
                                data-price="0" 
                                {% if cart.shipping_data.code == branch.code %}checked{% endif %} type="radio" 
                                value="{{branch.code}}" 
                                data-name="{{ branch.name }} - {{ branch.extra }}"
                                data-code="{{branch.code}}" 
                                data-cost="{{ 'Gratis' | translate }}"
                                name="option" 
                                style="display:none">
                                <div class="shipping-option row-fluid radio-button-content">
                                   <div class="radio-button-icons-container">
                                        <span class="radio-button-icons">
                                            <span class="radio-button-icon unchecked"></span>
                                            <span class="radio-button-icon checked"></span>
                                        </span>
                                    </div>
                        {% endif %}
                                    <div class="{% if product_detail %}list-item-content{% else %}radio-button-label ml-1{% endif %}">
                                        <div class="row">
                                            <div class="col font-small {% if not product_detail %}pr-3{% endif %}">
                                                <div>{{ branch.name }} - {{ branch.extra }}</div>
                                            </div>
                                            <div class="col-auto text-right">
                                                <p class="text-accent mb-0 d-inline-block">{{ 'Gratis' | translate }}</p>
                                            </div>
                                        </div>
                                    </div>
                        {% if not product_detail %}
                                </div>
                            </label>
                        {% endif %}
                    </li>
                {% endfor %}
            </ul>
        </div>
    </div>
</div>