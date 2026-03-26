{# Mobile Sharing #}

<div class="social-share {% if product.description is empty %}mt-3{% endif %}">
	<span class="position-relative d-none d-md-block">
		<span class="js-tooltip-open font-small">
			<svg class="icon-inline icon-lg svg-icon-text mr-1"><use xlink:href="#share"/></svg>
			<span class="btn-link">{{ 'Compartir' | translate }}</span>
		</span>
		<div class="js-tooltip tooltip" style="display: none;">
			<span class="tooltip-arrow tooltip-arrow-up"></span>
			{% include 'snipplets/social/social-share-links.tpl' %}
			<a class="js-tooltip-close ml-2" href="#">
				<svg class="icon-inline svg-icon-text"><use xlink:href="#times"/></svg>
			</a>
		</div>
	</span>

	<a data-toggle="#social-share-modal" data-modal-url="modal-fullscreen-social-share" class="js-modal-open mb-3 d-md-none font-small">
		<svg class="icon-inline icon-lg svg-icon-text mr-1"><use xlink:href="#share"/></svg>
		<span class="btn-link">{{ 'Compartir' | translate }}</span>
	</a>

	{% embed "snipplets/modal.tpl" with{modal_id: 'social-share-modal',modal_class: 'bottom-sheet', modal_position: 'bottom', modal_transition: 'slide', modal_header_title: true, modal_footer: true, modal_width: 'centered', modal_mobile_full_screen: 'true'} %}
		{% block modal_head %}
			{{ 'Compartir' | translate }}
		{% endblock %}
		{% block modal_body %}
			{% include 'snipplets/social/social-share-links.tpl' with {modal: true} %}
		{% endblock %}
	{% endembed %}
</div>