<ul class="list {% if footer %}font-small{% endif %} py-2">
	{% if store.whatsapp %}
		<li class="{% if footer %}footer-menu-item{% else %}mb-3{% endif %}">
			<a href="{{ store.whatsapp }}" class="{% if btn_link %}btn{% else %}contact{% endif %}-link">
				{% if with_icons %}
					<svg class="icon-inline icon-lg icon-w mr-2"><use xlink:href="#whatsapp-line"/></svg>
				{% endif %}
				{{ store.whatsapp |trim('https://wa.me/') }}
			</a>
		</li>
	{% endif %}
	{% if store.phone %}
		<li class="{% if footer %}footer-menu-item{% else %}mb-3{% endif %}">
			<a href="tel:{{ store.phone }}" class="{% if btn_link %}btn{% else %}contact{% endif %}-link">
				{% if with_icons %}
					<svg class="icon-inline icon-lg icon-w mr-2"><use xlink:href="#phone"/></svg>
				{% endif %}
				{{ store.phone }}
			</a>
		</li>
	{% endif %}
	{% if store.email %}
		<li class="{% if footer %}footer-menu-item{% else %}mb-3{% endif %}">
			<a href="mailto:{{ store.email }}" class="{% if btn_link %}btn{% else %}contact{% endif %}-link">
				{% if with_icons %}
					<svg class="icon-inline icon-lg icon-w mr-2"><use xlink:href="#email"/></svg>
				{% endif %}
				{{ store.email }}
			</a>
		</li>
	{% endif %}
	{% if not phone_and_mail_only %}
		{% if store.address and not is_order_cancellation %}
			<li class="{% if footer %}footer-menu-item{% else %}mb-3{% endif %}">
				{% if with_icons %}
					<svg class="icon-inline icon-lg icon-w mr-2"><use xlink:href="#map-marker-alt"/></svg>
				{% endif %}
				{{ store.address }}
			</li>
		{% endif %}
		{% if store.blog %}
			<li class="{% if footer %}footer-menu-item{% else %}mb-3{% endif %}">
				<a target="_blank" href="{{ store.blog }}" class="{% if btn_link %}btn{% else %}contact{% endif %}-link">
					{% if with_icons %}
						<svg class="icon-inline icon-lg icon-w mr-2"><use xlink:href="#comments"/></svg>
					{% endif %}
					{{ "¡Visitá nuestro Blog!" | translate }}
				</a>
			</li>
		{% endif %}
	{% endif %}
</ul>