{% set has_home_testimonials = false %}
{% set num_testimonials = 0 %}
{% for testimonial in ['testimonial_01', 'testimonial_02', 'testimonial_03', 'testimonial_04'] %}
	{% set testimonial_image = "#{testimonial}.jpg" | has_custom_image %}
	{% set testimonial_name = attribute(settings,"#{testimonial}_name") %}
	{% set testimonial_description = attribute(settings,"#{testimonial}_description") %}
	{% set has_testimonial = testimonial_name or testimonial_description or testimonial_image %}
	{% if has_testimonial %}
		{% set has_home_testimonials = true %}
		{% set num_testimonials = num_testimonials + 1 %}
	{% endif %}
{% endfor %}

{% if has_home_testimonials %}
	<section class="section-home section-testimonials-home overflow-none" data-store="home-testimonials">
		<div class="container">
			{% if settings.testimonials_title %}
				<h2 class="h3 mb-4 text-center">{{ settings.testimonials_title }}</h2>
			{% endif %}
			<div class="row">
				<div class="col-12{% if num_testimonials > 1 %} p-0 px-md-3{% endif %}">
					<div class="js-swiper-testimonials swiper-testimonials swiper-container">
						<div class="swiper-wrapper">
							{% for testimonial in ['testimonial_01', 'testimonial_02', 'testimonial_03', 'testimonial_04'] %}
								{% set testimonial_image = "#{testimonial}.jpg" | has_custom_image %}
								{% set testimonial_name = attribute(settings,"#{testimonial}_name") %}
								{% set testimonial_description = attribute(settings,"#{testimonial}_description") %}
								{% set has_testimonial = testimonial_name or testimonial_description or testimonial_image %}
								{% if has_testimonial %}
									<div class="swiper-slide p-0 text-center">
										{% if testimonial_image %}
											<div class="position-relative">
												<img class="d-block w-100 mb-3 lazyautosizes lazyload" src="{{ 'images/empty-placeholder.png' | static_url }}" data-sizes="auto" data-expand="-10" data-srcset='{{ "#{testimonial}.jpg" | static_url | settings_image_url("medium") }} 320w, {{ "#{testimonial}.jpg" | static_url | settings_image_url("large") }} 480w' {% if testimonial_name %}alt="{{ testimonial_name }}"{% else %}alt="{{ 'Testimonio de' | translate }} {{ store.name }}"{% endif %} />
												<div class="placeholder-fade"></div>
											</div>
										{% endif %}
										{% if testimonial_name %}
											<h3 class="h6 mb-2">{{ testimonial_name }}</h3>
										{% endif %}
										{% if testimonial_description %}
											<p class="font-small mb-2">{{ testimonial_description }}</p>
										{% endif %}
									</div>
								{% endif %}
							{% endfor %}
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
{% endif %}
