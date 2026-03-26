{# Site Overlay #}
<div class="js-overlay site-overlay" style="display: none;"></div>

{# Header #}

{# Header logo dynamic classes #}

{% set header_logo_mobile_classes = settings.logo_position_mobile == 'center' ? 'head-logo-center' : 'head-logo-left' %}
{% set header_logo_mobile_search_icon_classes = settings.logo_position_mobile == 'center' and not settings.search_big_mobile  ? 'head-logo-center-search-small' : '' %}
{% set header_logo_desktop_classes = settings.logo_position_desktop == 'center' ? 'head-logo-md-center' : 'head-logo-md-left' %}
{% set header_logo_left_nav_below_desktop_classes = settings.logo_position_desktop == 'left' and settings.search_big_desktop ? 'head-logo-md-left-nav-below' : '' %}

{# Header colors dynamic classes #}

{% set header_colors_classes = settings.header_colors ? 'head-colors' : '' %}

{# Logo mobile dynamic classes #}

{% set logo_mobile_classes = settings.logo_position_mobile == 'center' ? 'text-center' : 'ml-2 ml-md-0 text-left' %}

{# Logo desktop dynamic classes + utilities desktop order #}

{% set logo_desktop_classes = settings.logo_position_desktop == 'center' ? 'col-md-6 order-md-1 text-md-center' : 'col-md-auto order-md-first text-md-left pr-md-4' %}

{# Header position type #}

{% set head_position_mobile = 'position-sticky' %}
{% set head_position_desktop = settings.head_fix_desktop ? 'position-fixed-md' : 'position-relative-md' %}

{# Header visibility classes #}

{% set show_inline_desktop_hide_mobile_class = 'd-none d-md-inline-block' %}
{% set show_inline_mobile_hide_desktop_class = 'd-inline-block d-md-none' %}
{% set show_block_desktop_hide_mobile_class = 'd-none d-md-block' %}
{% set show_block_mobile_hide_desktop_class = 'd-block d-md-none' %}

{# Search classes #}

{% set search_icon_visibility_classes = '' %}
{% if settings.search_big_mobile and not settings.search_big_desktop %}
    {% set search_icon_visibility_classes = show_block_desktop_hide_mobile_class %}
{% elseif not settings.search_big_mobile and settings.search_big_desktop %}
    {% set search_icon_visibility_classes = show_block_mobile_hide_desktop_class %}
{% endif %}

{% set search_col_md_classes = settings.logo_position_desktop == 'center' ? 'col-md-3' : settings.search_big_desktop  ? 'col-md' : 'col-md-auto' %}

{# Utilities conditions #}

{% set hamburger_icon_spacing_classes = settings.logo_position_mobile == 'left' ? 'ml-1 ml-md-0' : '' %}
{% set account_icon_col_classes = settings.logo_position_desktop == 'center' ? 'col-md order-md-1' : 'col-md-auto' %}

{# Header desktop nav dynamic classes #}

{% set head_nav_inline_desktop_classes =  settings.logo_position_desktop == 'left' and not settings.search_big_desktop ? 'head-nav-md-inline' : '' %}

{% set head_desktop_nav_color_classes =  settings.desktop_nav_colors and not head_nav_inline_desktop_classes ? 'head-nav-desktop-colors' %}

<header class="js-head-main head-main {{ header_colors_classes }} {{ head_position_mobile }} {{ head_position_desktop }} {{ header_logo_mobile_classes }} {{ header_logo_mobile_search_icon_classes }} {{ header_logo_desktop_classes }} {{ header_logo_left_nav_below_desktop_classes }} {{ head_nav_inline_desktop_classes }} {{ head_desktop_nav_color_classes }} transition-soft" data-store="head">

    {# Secondary nav and account links #}

    {% snipplet "header/header-top.tpl" %}

    <div class="head-logo-row position-relative">
        <div class="container">
            <div class="{% if not settings.head_fix_desktop %}js-nav-logo-bar{% endif %} row no-gutters align-items-center">

                {# Menu icon #}

                <div class="col-auto col-utility d-md-none">
                    {% include "snipplets/header/header-utilities.tpl" with {use_menu: true} %}
                </div>

                {# Logo #}

                <div class="js-logo-container col {{ logo_mobile_classes }} {{ logo_desktop_classes }} {{ hamburger_icon_spacing_classes }}">
                    {% set logo_size_class = settings.logo_size == 'medium' ? 'logo-img-medium' : settings.logo_size == 'big' ? 'logo-img-big' %}
                    {{ component('logos/logo', {logo_img_classes: 'transition-soft ' ~ logo_size_class, logo_text_classes: 'h3 m-0'}) }}
                </div>

                {# Desktop navigation next to logo #}

                {% if settings.logo_position_desktop == 'left' and not settings.search_big_desktop %}
                    {# Desktop nav next logo #}
                    <div class="js-desktop-nav-col desktop-nav-col transition-soft col {{ show_inline_desktop_hide_mobile_class }} align-items-center pr-md-4">
                        {% snipplet "navigation/navigation.tpl" %}
                    </div>
                {% endif %}

                {# Search: Icon or box #}

                <div class="js-utility-col js-search-utility col-auto desktop-utility-col {{ search_col_md_classes }} col-utility {% if settings.search_big_mobile %}{{ show_inline_desktop_hide_mobile_class }}{% elseif settings.logo_position_mobile == 'left' %}order-1{% endif %} order-md-0">
                    {% if settings.search_big_desktop %}
                        <span class="{{ show_block_desktop_hide_mobile_class }}">
                            {% include "snipplets/header/header-search.tpl" %}
                        </span>
                    {% endif %}
                    {% if not settings.search_big_mobile or not settings.search_big_desktop %}
                        <span class="{{ search_icon_visibility_classes }} {% if settings.logo_position_desktop == 'left' %}float-md-right{% endif %}">
                            {% include "snipplets/header/header-utilities.tpl" with {use_search: true} %}
                        </span>
                    {% endif %}
                </div>

                {# Account icon #}
                
                <div class="js-utility-col col-utility desktop-utility-col text-right {{ show_inline_desktop_hide_mobile_class }} {{ account_icon_col_classes }}">
                    {% include "snipplets/header/header-utilities.tpl" with {use_account: true, icon_only: true} %}
                </div>

                {# Cart icon #}

                <div class="js-utility-col col-auto col-utility desktop-utility-col order-2">
                    {% include "snipplets/header/header-utilities.tpl" %}
                </div>

                {# Add to cart notification #}

                {% if settings.ajax_cart %}
                    {% if not settings.head_fix_desktop %}
                        <div class="{{ show_block_mobile_hide_desktop_class }}">
                    {% endif %}
                            {% include "snipplets/notification.tpl" with {add_to_cart: true} %}
                    {% if not settings.head_fix_desktop %}
                        </div>
                    {% endif %}
                {% endif %}

            </div>
        </div>
    </div>   

    {# Mobile search big #}

    {% if settings.search_big_mobile %}
        <div class="js-big-search-mobile pb-3 container {{ show_block_mobile_hide_desktop_class }}">
            {% include "snipplets/header/header-search.tpl" %}
        </div>
    {% endif %}

    {% if settings.logo_position_desktop == 'center' or (settings.logo_position_desktop == 'left' and settings.search_big_desktop) %}

        {# Desktop navigation below logo #}
        <div class="head-nav d-none d-md-block">
            <div class="container {% if settings.logo_position_desktop == 'center' %}text-center{% endif %}">
                {% snipplet "navigation/navigation.tpl" %}
            </div>
        </div>
    {% endif %}
 
</header>

{# Follow order notification #}

{% include "snipplets/notification.tpl" with {order_notification: true} %}

{# Adversiting bar #}
    
{% if settings.ad_bar %}
    {% snipplet "header/header-advertising.tpl" %}
{% endif %}

{# Show cookie validation message #}

{% include "snipplets/notification.tpl" with {show_cookie_banner: true} %}

{# Add to cart notification for non fixed header #}

{% if settings.ajax_cart and not settings.head_fix_desktop %}
    <div class="{{ show_block_desktop_hide_mobile_class }}">
        {% include "snipplets/notification.tpl" with {add_to_cart: true, add_to_cart_fixed: true} %}
    </div>
{% endif %}

{% include "snipplets/header/header-modals.tpl" %}

