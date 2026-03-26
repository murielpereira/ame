{% if not settings.search_big_mobile or not settings.search_big_desktop %}

	{# Modal Search #}

	{% embed "snipplets/modal.tpl" with{modal_id: 'nav-search',modal_class: 'nav-search', modal_header_class: 'd-none', modal_body_class: 'p-0 h-100',  modal_transition: 'fade', modal_header_title: false, modal_mobile_full_screen: true } %}
		{% block modal_body %}
			{% include "snipplets/header/header-search.tpl" with {search_modal: true} %}
		{% endblock %}
	{% endembed %}

{% endif %}

{% set modal_with_desktop_only_overlay_val = false %}

{# Modal Hamburger #}

{% embed "snipplets/modal.tpl" with{modal_id: 'nav-hamburger',modal_class: 'nav-hamburger modal-docked-md pb-0', modal_position: 'left', modal_transition: 'slide', modal_width: 'full', modal_mobile_full_screen: false, modal_hide_close: 'true',modal_header_class: 'd-none', modal_body_class: 'nav-body', modal_footer_class: 'hamburger-footer mb-0 p-0',modal_header_title: false, modal_fixed_footer: true, modal_footer: true, desktop_overlay_only: modal_with_desktop_only_overlay_val} %}
	{% block modal_body %}
		{% include "snipplets/navigation/navigation-panel.tpl" %}
	{% endblock %}
	{% block modal_foot %}
		{% include 'snipplets/navigation/navigation-banners.tpl' %}
	{% endblock %}
{% endembed %}

{# Modal Cart #}

{% if not store.is_catalog and settings.ajax_cart and template != 'cart' %}           

	{# Cart Ajax #}

	{% embed "snipplets/modal.tpl" with{modal_id: 'modal-cart',modal_class: 'cart', modal_position: 'right', modal_position_desktop: 'right', modal_transition: 'slide', modal_width: 'docked-md', modal_form_action: store.cart_url, modal_form_class: 'js-ajax-cart-panel h-100', modal_body_class: 'h-100', modal_header_title: true, modal_mobile_full_screen: true, modal_form_hook: 'cart-form', data_component:'cart', desktop_overlay_only: modal_with_desktop_only_overlay_val } %}
		{% block modal_head %}
			{% block page_header_text %}{{ "Carrito de compras" | translate }}{% endblock page_header_text %}
		{% endblock %}
		{% block modal_body %}
			{% snipplet "cart-panel.tpl" %}
		{% endblock %}
	{% endembed %}

{% endif %}