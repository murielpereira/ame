{% if settings.institutional_subtitle or settings.institutional_message or settings.institutional_text %}
	{% set institutional_container_color = settings.institutional_colors and not settings.institutional_full %}
	<section class="section-home {% if settings.institutional_colors and settings.institutional_full %}section-institutional-home-colors section-home-color{% endif %}" data-store="home-institutional-message">
		<div class="container">
			{% if institutional_container_color %}
				<div class="section-institutional-home-colors">
			{% endif %}
			<div class="row text-center justify-content-center{% if institutional_container_color %} py-5 px-3{% endif %}">
				<div class="col-md-7">
					{% if settings.institutional_subtitle %}
						<div class="mb-3">{{ settings.institutional_subtitle }}</div>
					{% endif %}
					{% if settings.institutional_message %}
						<h2 class="h1-huge mb-3">{{ settings.institutional_message }}</h2>
					{% endif %}
					{% if settings.institutional_text %}
						<p class="mb-3">{{ settings.institutional_text }}</p>
					{% endif %}
					{% if settings.institutional_button and settings.institutional_link %}
						<a href="{{ settings.institutional_link }}" class="btn btn-default btn-small mt-1">{{ settings.institutional_button }}</a>
					{% endif %}
				</div>
			</div>
			{% if institutional_container_color %}
				</div>
			{% endif %}
		</div>
	</section>
{% endif %}
