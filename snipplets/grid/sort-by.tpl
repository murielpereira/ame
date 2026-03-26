{% set sort_text = {
'score-descending': 'Relevancia',
'user': 'Destacado',
'price-ascending': 'Precio: Menor a Mayor',
'price-descending': 'Precio: Mayor a Menor',
'alpha-ascending': 'A - Z',
'alpha-descending': 'Z - A',
'created-ascending': 'Más Viejo al más Nuevo',
'created-descending': 'Más Nuevo al más Viejo',
'best-selling': 'Más Vendidos',
} %}
{% if list %}
	<div class="js-sort-by-list radio-button-container mb-4 pb-2"> 
		{% for sort_method in sort_methods %}
			{# This is done so we only show the user sorting method when the user chooses it #}
			{% if sort_method != 'user' or category.sort_method == 'user' %}
				<a href="#" class="js-apply-sort radio-button radio-button-item {% if sort_by == sort_method %}selected{% endif %}" data-sort-value="{{ sort_method }}">
					<div class="radio-button-content {% if sort_method == 'user' %}mb-0{% endif %}">
						<span class="radio-button-icons-container">
							<div class="radio-button-icons">
								<div class="radio-button-icon unchecked"></div>
								<div class="radio-button-icon checked"></div>
							</div>
						</span>
						<span class="radio-button-label">
							{{ sort_text[sort_method] | t }}
						</span>
					</div>
				</a>
			{% endif %}
		{% endfor %}
	</div>
{% else %}
	<div class="mb-4 pb-2">
		<h6 class="font-big font-weight-bold mb-3">{{ "Ordenar por" | translate }}</h6>

		{% embed "snipplets/forms/form-select.tpl" with{select_label: false, select_group_custom_class: "d-inline-block w-auto mb-0", select_custom_class: 'js-sort-by form-select-small', select_aria_label: 'Ordenar por:' | translate } %}
			{% block select_options %}
				{% for sort_method in sort_methods %}
					{# This is done so we only show the user sorting method when the user chooses it #}
					{% if sort_method != 'user' or category.sort_method == 'user' %}
						<option value="{{ sort_method }}" {% if sort_by == sort_method %}selected{% endif %}>{{ sort_text[sort_method] | t }}</option>
					{% endif %}
				{% endfor %}
			{% endblock select_options%}
		{% endembed %}
	</div>
{% endif %}
