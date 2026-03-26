{% set has_banner = has_banner | default(false) %}
{% set has_banner_promotional = has_banner_promotional | default(false) %}
{% set has_banner_news = has_banner_news | default(false) %}

{% if has_banner %}
    {% set section_name = 'banner' %}
    {% set section_format_mobile = settings.banner_format_mobile %}
    {% set section_format_desktop = settings.banner_format_desktop %}
    {% set section_columns_desktop = settings.banner_columns_desktop %}
    {% set section_grid_classes = settings.banner_columns_desktop == 4 ? 'col-md-3' : settings.banner_columns_desktop == 3 ? 'col-md-4' : settings.banner_columns_desktop == 2 ? 'col-md-6' : 'col-md-12' %}
    {% set section_text_position = settings.banner_text_outside ? 'outside' : 'above' %}
    {% set section_image_size = settings.banner_same_size ? 'same' : 'original' %}
    {% set section_margin = settings.banner_without_margins ? 'false' : 'true' %}
    {% set section_align = settings.banner_align %}
{% elseif has_banner_promotional %}
    {% set section_name = 'banner-promotional' %}
    {% set section_format_mobile = settings.banner_promotional_format_mobile %}
    {% set section_format_desktop = settings.banner_promotional_format_desktop %}
    {% set section_columns_desktop = settings.banner_promotional_columns_desktop %}
    {% set section_grid_classes = settings.banner_promotional_columns_desktop == 4 ? 'col-md-3' : settings.banner_promotional_columns_desktop == 3 ? 'col-md-4' : settings.banner_promotional_columns_desktop == 2 ? 'col-md-6' : 'col-md-12' %}
    {% set section_text_position = settings.banner_promotional_text_outside ? 'outside' : 'above' %}
    {% set section_image_size = settings.banner_promotional_same_size ? 'same' : 'original' %}
    {% set section_margin = settings.banner_promotional_without_margins ? 'false' : 'true' %}
    {% set section_align = settings.banner_promotional_align %}
{% else %}
    {% set section_name = 'banner-news' %}
    {% set section_format_mobile = settings.banner_news_format_mobile %}
    {% set section_format_desktop = settings.banner_news_format_desktop %}
    {% set section_columns_desktop = settings.banner_news_columns_desktop %}
    {% set section_grid_classes = settings.banner_news_columns_desktop == 4 ? 'col-md-3' : settings.banner_news_columns_desktop == 3 ? 'col-md-4' : settings.banner_news_columns_desktop == 2 ? 'col-md-6' : 'col-md-12' %}
    {% set section_text_position = settings.banner_news_text_outside ? 'outside' : 'above' %}
    {% set section_image_size = settings.banner_news_same_size ? 'same' : 'original' %}
    {% set section_margin = settings.banner_news_without_margins ? 'false' : 'true' %}
    {% set section_align = settings.banner_news_align %}
{% endif %}

{% if has_banner or has_banner_promotional or has_banner_news %}
    <div class="js-home-{{ section_name }}" data-mobile-format="{{ section_format_mobile }}" data-desktop-format="{{ section_format_desktop }}" data-desktop-columns="{{ section_columns_desktop }}" data-grid-classes="{{ section_grid_classes }}" data-text="{{ section_text_position }}" data-image="{{ section_image_size }}" data-margin="{{ section_margin }}" data-align="{{ section_align }}">
        {% if has_banner %}
            {% include 'snipplets/home/home-banners-grid.tpl' with {'banner': true} %}
        {% endif %}
        {% if has_banner_promotional %}
            {% include 'snipplets/home/home-banners-grid.tpl' with {'banner_promotional': true} %}
        {% endif %}
        {% if has_banner_news %}
            {% include 'snipplets/home/home-banners-grid.tpl' with {'banner_news': true} %}
        {% endif %}
    </section>
{% endif %}
