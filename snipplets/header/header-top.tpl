{# NOVO BLOCO: BARRA DO CONTADOR  - INÍCIO #}

{% include 'snipplets/header/header-countdown-bar.tpl' %}

{# NOVO BLOCO: DO CONTADOR  - FIM #}

{% set has_social_network = store.facebook or store.twitter or store.pinterest or store.instagram or store.tiktok or store.youtube %}
{% set has_head_banner_1 = settings.head_informative_banner_01_show and settings.head_informative_banner_01_title %}
{% set has_head_banner_2 = settings.head_informative_banner_02_show and settings.head_informative_banner_02_title %}
{% set has_header_banners = has_head_banner_1 or has_head_banner_2 %}

{% if settings.top_bar and (has_social_network or has_header_banners or settings.top_menu_show) %}

	{% set social_links = has_social_network and (not has_header_banners or not settings.top_menu_show) %}

	<div class="js-topbar section-topbar {% if not (settings.topbar_colors and settings.header_colors) %}section-topbar-default{% endif %} d-none d-md-block py-2">
		<div class="container">
			<div class="row align-items-center justify-content-end h-100">
				{% if settings.top_menu_show %}
					<div class="col">
						{% include "snipplets/navigation/navigation-secondary.tpl" %}
					</div>
				{% endif %}
				{% if has_header_banners %}
					<div class="{% if settings.top_menu_show %}col-auto{% else %}col{% endif %}">
						{% include "snipplets/header/head-banners.tpl" %}
					</div>
				{% endif %}	
				{% if social_links %}
					<div class="col-auto {% if has_header_banners %}order-first{% endif %}">
						{% include "snipplets/social/social-links.tpl" with {header: true} %}
					</div>
				{% endif %}
			</div>
		</div>
	</div>
{% endif %}