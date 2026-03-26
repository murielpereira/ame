<div class="swiper-slide col-auto w-md-auto {% if num_banners_services == 1 %}mw-md-100 px-3 px-md-0{% elseif num_banners_services == 2 %}mw-md-50{% elseif num_banners_services == 3 %}mw-md-33{% else %}mw-md-25{% endif %} p-0{% if loop.last %} mr-md-0{% endif %}">
    {% if banner_services_url %}
        <a href="{{ banner_services_url | setting_url }}">
    {% endif %}
        <div class="row no-gutters">
            <div class="col-auto">
                {% set banner_services_icon_classes = 'icon-inline h2 align-item-middle svg-icon-text' %}
                {% if banner_services_icon == 'image' and banner_services_image %}
                    <img class="service-item-image align-item-middle lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src='{{ "#{banner}.jpg" | static_url | settings_image_url("large") }}' {% if banner_services_title %}alt="{{ banner_services_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
                {% elseif banner_services_icon == 'shipping' %}
                    <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#truck"/></svg>
                {% elseif banner_services_icon == 'card' %}
                    <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#credit-card"/></svg>
                {% elseif banner_services_icon == 'security' %}
                    <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#security"/></svg>
                {% elseif banner_services_icon == 'returns' %}
                    <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#returns"/></svg>
                {% elseif banner_services_icon == 'whatsapp' %}
                    <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#whatsapp-line"/></svg>
                {% elseif banner_services_icon == 'promotions' %}
                    <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#promotions"/></svg>
                {% elseif banner_services_icon == 'cash' %}
                    <svg class="{{ banner_services_icon_classes }}"><use xlink:href="#wallet"/></svg>
                {% endif %}
            </div>
            {% if banner_services_title or banner_services_description %}
                <div class="col pl-3">
                    <div class="align-item-middle">
                        {% if banner_services_title %}
                            <h3 class="h6 font-weight-bold mb-1">{{ banner_services_title }}</h3>
                        {% endif %}
                        {% if banner_services_description %}
                            <p class="m-0 service-text">{{ banner_services_description }}</p>
                        {% endif %}
                    </div>
                </div>
            {% endif %}
        </div>
    {% if banner_services_url %}
        </a>
    {% endif %}
</div>
