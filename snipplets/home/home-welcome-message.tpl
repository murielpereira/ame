{% if settings.welcome_message %}
	{% set welcome_animated = settings.welcome_animate %}
	<section class="section-home{% if settings.welcome_colors %} section-home-color section-welcome-home-colors{% endif %}{% if welcome_animated %} section-welcome-animated{% endif %}" data-store="home-welcome-message">
		{% if not welcome_animated %}
			<div class="container">
				<div class="row text-center justify-content-center">
		{% endif %}
				<div class="{% if welcome_animated %}js-welcome-animated welcome-animated{% else %}col-md-7{% endif %}">
					{% if settings.welcome_link %}
						<a href="{{ settings.welcome_link }}">
					{% endif %}
					{% if settings.welcome_message %}
						{% if welcome_animated %}
							<span class="js-welcome-text-container">
								{% for i in 1..16 %}
									<span class="welcome-text h3 mr-4">
										{{ settings.welcome_message }}
									</span>
								{% endfor %}
							</span>
						{% else %}
							<h2 class="h3 mb-1">{{ settings.welcome_message }}</h2>
						{% endif %}
					{% endif %}
					{% if settings.welcome_link %}
						</a>
					{% endif %}
				</div>
		{% if not welcome_animated %}
				</div>
			</div>
		{% endif %}
	</section>
{% endif %}
