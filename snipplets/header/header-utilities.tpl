{% if use_menu %}
	<span class="utilities-container d-inline-block">
		<a href="#" class="js-modal-open utilities-item btn btn-utility pl-0" data-toggle="#nav-hamburger" aria-label="{{ 'Menú' | translate }}" data-component="menu-button">
			<svg class="icon-inline utilities-icon align-bottom"><use xlink:href="#bars"/></svg>
		</a>
	</span>
{% elseif use_account %}
	<span class="utilities-container {% if header_desktop %}d-none d-md-inline-block mr-4{% endif %}">
		{% if icon_only %}
			<a href="{% if not customer %}{{ store.customer_login_url }}{% else %}{{ store.customer_home_url }}{% endif %}" class="btn btn-utility">
				<svg class="icon-inline utilities-icon"><use xlink:href="#user"/></svg>
			</a>
		{% else %}
			<div class="row no-gutters align-items-center">
				<div class="col-auto pr-0">
					<svg class="icon-inline font-big"><use xlink:href="#user"/></svg>
				</div>
				<div class="col pl-2 text-left font-small">
					{% if not customer %}
						{{ "Iniciar sesión" | translate | a_tag(store.customer_login_url, '', 'mr-1 text-underline') }} 
						{% if 'mandatory' not in store.customer_accounts %}
							{{ 'o' | translate }}{{ "Crear cuenta" | translate | a_tag(store.customer_register_url, '', 'ml-2 text-underline') }}
						{% endif %}
					{% else %}
						{% set customer_short_name = customer.name|split(' ')|slice(0, 1)|join %} 
						{{ "¡Hola, {1}!" | t(customer_short_name) | a_tag(store.customer_home_url, '', 'font-weight-bold mr-1') }}
						{% if not header_desktop %}.{% endif %}
						{{ "Cerrar sesión" | translate | a_tag(store.customer_logout_url, '', 'ml-1 text-underline') }}
					{% endif %}
				</div>
			</div>
		{% endif %}
	</span>
{% elseif use_search %}
	<span class="utilities-container d-inline-block">
		<a href="#" class="js-search-button js-modal-open js-fullscreen-modal-open btn btn-utility utilities-item" data-modal-url="modal-fullscreen-search" data-toggle="#nav-search" aria-label="{{ 'Buscador' | translate }}">
			<svg class="icon-inline align-bottom utilities-icon"><use xlink:href="#search"/></svg>
		</a>
	</span>
{% else %}
	<span class="utilities-container d-inline-block">
		<div id="ajax-cart" class="cart-summary" data-component='cart-button'>
			<a 
				{% if settings.ajax_cart and template != 'cart' %}
					href="#"
					data-toggle="#modal-cart" 
					data-modal-url="modal-fullscreen-cart"
				{% else %}
					href="{{ store.cart_url }}" 
				{% endif %}
				class="{% if settings.ajax_cart and template != 'cart' %}js-modal-open js-fullscreen-modal-open{% endif %} btn btn-utility position-relative pr-0"
				>
				<svg class="icon-inline utilities-icon cart-icon mr-md-1"><use xlink:href="#cart"/></svg>
				<span class="js-cart-widget-amount badge">{{ "{1}" | translate(cart.items_count ) }}</span>
			</a>	
		</div>
	</span>
{% endif %}