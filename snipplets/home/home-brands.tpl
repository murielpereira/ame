{% if settings.brands and settings.brands is not empty %}
	<section class="section-home section-brands-home {% if settings.brands_colors %}section-home-color section-brands-home-colors{% endif %} overflow-none" data-store="home-brands">
		<div class="container">
			{% if settings.brands_title %}
				<h2 class="h3 text-center mb-4">{{ settings.brands_title }}</h2>
			{% endif %}
			{% if settings.brands_format == 'slider' %}
				<div class="position-relative pb-2">
					<div class="js-swiper-brands swiper-container text-center w-auto mx-4 m-md-0">
						<div class="js-swiper-brands-wrapper swiper-wrapper">
			{% else %}
				<div class="row justify-content-center">
			{% endif %}
					{% for slide in settings.brands %}
						<div class="{% if settings.brands_format == 'slider' %}swiper-slide slide-container{% else %}col-md-1-5 col-4 mb-3{% endif %} brand-image-container text-center">
							{% if slide.link %}
								<a href="{{ slide.link | setting_url }}" title="{{ 'Marca {1} de' | translate(loop.index) }} {{ store.name }}" aria-label="{{ 'Marca {1} de' | translate(loop.index) }} {{ store.name }}">
							{% endif %}
								<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ slide.image | static_url | settings_image_url('large') }}" class="lazyload brand-image" alt="{{ 'Marca {1} de' | translate(loop.index) }} {{ store.name }}">
							{% if slide.link %}
								</a>
							{% endif %}
						</div>
					{% endfor %}
				</div>
			{% if settings.brands_format == 'slider' %}
					</div>
					<div class="js-swiper-brands-prev swiper-button-prev swiper-button-outside svg-icon-text">
						<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
					</div>
					<div class="js-swiper-brands-next swiper-button-next swiper-button-outside svg-icon-text">
						<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
					</div>
				</div>
			{% endif %}
		</div>
	</section>
{% endif %}
