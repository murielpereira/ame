<div class="head-banners row align-items-center justify-content-end" data-store="head-banners">
    {% set has_1_banner = (not settings.head_informative_banner_01_show and settings.head_informative_banner_02_show) or (settings.head_informative_banner_01_show and not settings.head_informative_banner_02_show) %}
    {% for banner in ['head_informative_banner_01', 'head_informative_banner_02'] %}
        {% set head_informative_banner = attribute(settings,"#{banner}_show") %}
        {% set head_informative_banner_icon = attribute(settings,"#{banner}_icon") %}
        {% set head_informative_banner_image = "#{banner}.jpg" | has_custom_image %}
        {% set head_informative_banner_title = attribute(settings,"#{banner}_title") %}
        {% set head_informative_banner_url = attribute(settings,"#{banner}_url") %}
        {% set has_head_informative_banner =  head_informative_banner and head_informative_banner_title %}
        {% if has_head_informative_banner %}
            <div class="col-auto">
                {% if head_informative_banner_url %}
                    <a href="{{ head_informative_banner_url | setting_url }}">
                {% endif %}
                <div class="row align-items-center {% if has_1_banner %}justify-content-center{% endif %}">
                    {% if head_informative_banner_icon != 'none' %}
                        <div class="col-auto pr-0 font-big">
                            {% if head_informative_banner_icon == 'image' and head_informative_banner_image %}
                                <img class="head-banner-item-image lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src='{{ "#{banner}.jpg" | static_url | settings_image_url("thumb") }}' {% if head_informative_banner_title %}alt="{{ head_informative_banner_title }}"{% else %}alt="{{ 'Banner de' | translate }} {{ store.name }}"{% endif %} />
                            {% elseif head_informative_banner_icon == 'shipping' %}
                                <svg class="topbar-icon icon-inline"><use xlink:href="#truck"/></svg>
                            {% elseif head_informative_banner_icon == 'store' %}
                                <svg class="topbar-icon icon-inline"><use xlink:href="#store"/></svg>
                            {% elseif head_informative_banner_icon == 'payment' %}
                                <svg class="topbar-icon icon-inline"><use xlink:href="#credit-card"/></svg>
                            {% elseif head_informative_banner_icon == 'promotions' %}
                                <svg class="topbar-icon icon-inline"><use xlink:href="#promotions"/></svg>
                            {% elseif head_informative_banner_icon == 'returns' %}
                                <svg class="topbar-icon icon-inline"><use xlink:href="#returns"/></svg>
                            {% elseif head_informative_banner_icon == 'help' %}
                                <svg class="topbar-icon icon-inline"><use xlink:href="#comments"/></svg>
                            {% endif %}
                        </div>
                    {% endif %}
                    {% if head_informative_banner_title %}
                        <div class="{% if has_1_banner %}col-auto{% else %}col{% endif %} {% if has_1_banner or head_informative_banner_icon == 'none' %} justify-content-center{% endif %} {% if head_informative_banner_icon == 'none' %}col-md-auto text-center text-md-left{% endif %} pl-2">
                            {{ head_informative_banner_title }}
                        </div>
                    {% endif %}
                </div>
                {% if head_informative_banner_url %}
                    </a>
                {% endif %}
            </div>
        {% endif %}
    {% endfor %}
    <div class="languages">
        <a href="#" data-toggle="#languages" class="js-modal-open btn-link" role="button" aria-label="{{ 'Elegir idioma' | translate }}">
			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-globe-americas" viewBox="0 0 16 16" aria-hidden="true">
            <path d="M8 0a8 8 0 1 0 0 16A8 8 0 0 0 8 0M2.04 4.326c.325 1.329 2.532 2.54 3.717 3.19.48.263.793.434.743.484q-.121.12-.242.234c-.416.396-.787.749-.758 1.266.035.634.618.824 1.214 1.017.577.188 1.168.38 1.286.983.082.417-.075.988-.22 1.52-.215.782-.406 1.48.22 1.48 1.5-.5 3.798-3.186 4-5 .138-1.243-2-2-3.5-2.5-.478-.16-.755.081-.99.284-.172.15-.322.279-.51.216-.445-.148-2.5-2-1.5-2.5.78-.39.952-.171 1.227.182.078.099.163.208.273.318.609.304.662-.132.723-.633.039-.322.081-.671.277-.867.434-.434 1.265-.791 2.028-1.12.712-.306 1.365-.587 1.579-.88A7 7 0 1 1 2.04 4.327Z"/>
            </svg>
        </a>
    </div>
</div>