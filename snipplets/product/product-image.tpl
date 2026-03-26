{% if home_main_product %}
	{% set has_multiple_slides = product.images_count > 1 %}
{% else %}
	{% set has_multiple_slides = product.images_count > 1 or product.video_url %}
{% endif %}

<div class="row" data-store="product-image-{{ product.id }}" style="margin-left: 0!important; margin-right: 0!important;"> 
	{% if has_multiple_slides %}
		<div class="d-none d-md-block{% if home_main_product %}{% else %} order-last order-md-0{% endif %} col-md-2 pr-md-0 mt-3 mt-md-0">
			<div class="product-thumbs-container position-relative">
				<div class="text-center d-none d-md-block">
					<div class="js-swiper-product-thumbs-prev swiper-button-prev swiper-product-thumb-control  svg-icon-text">
						<svg class="icon-inline icon-lg icon-flip-vertical"><use xlink:href="#chevron-down"/></svg>
					</div>
				</div>
				<div class="js-swiper-product-thumbs swiper-product-thumb"> 
					<div class="swiper-wrapper">
						{% for image in product.images %}
							<div class="swiper-slide w-auto">
								{% include 'snipplets/product/product-image-thumb.tpl' %}
							</div>
						{% endfor %}
						{% if not home_main_product %}
							{# Video thumb #}
							<div class="swiper-slide w-auto">
								{% include 'snipplets/product/product-video.tpl' with {thumb: true} %}
							</div>
						{% endif %}
					</div>
				</div>
				<div class="text-center d-none d-md-block">
					<div class="js-swiper-product-thumbs-next swiper-button-next swiper-product-thumb-control  svg-icon-text">
						<svg class="icon-inline icon-lg"><use xlink:href="#chevron-down"/></svg>
					</div>
				</div>
			</div>
		</div>
	{% endif %}
	{% if product.images_count > 0 %}
		<div class="col-md-10 {% if not has_multiple_slides %}product-with-one-image pr-md-3{% else %}p-0 px-md-3{% endif %}">
			<div class="js-swiper-product swiper-container product-detail-slider" style="visibility:hidden; height:0;" data-product-images-amount="{{ product.images_count }}">
                {% include 'snipplets/labels.tpl' with {product_detail: true, labels_floating: true} %}
				<div class="swiper-wrapper">
					{% for image in product.images %}
					 <div class="js-product-slide swiper-slide product-slide{% if home_main_product %}-small{% endif %} slider-slide" data-image="{{image.id}}" data-image-position="{{loop.index0}}">
						{% if home_main_product %}
							<div class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100}}%;">
						{% else %}
							<a href="{{ image | product_image_url('original') }}" data-fancybox="product-gallery" class="js-product-slide-link d-block position-relative" style="padding-bottom: {{ image.dimensions['height'] / image.dimensions['width'] * 100}}%;">
						{% endif %}
							<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w, {{  image | product_image_url('original') }} 1024w' data-sizes="auto" class="js-product-slide-img product-slider-image img-absolute img-absolute-centered lazyautosizes lazyload" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
							<img src="{{ image | product_image_url('tiny') }}" class="js-product-slide-img product-slider-image img-absolute img-absolute-centered blur-up" {% if image.alt %}alt="{{image.alt}}"{% endif %} />
						{% if home_main_product %}
							</div>
						{% else %}
							</a>
						{% endif %}
					</div>
					{% endfor %}
					{% if not home_main_product %}
						{% include 'snipplets/product/product-video.tpl' %}
					{% endif %}
				</div>
			</div>

			<div class="drag-to-left-icon">
			<svg width="64px" height="64px" viewBox="0 0 24 24" id="Layer_1" data-name="Layer 1" xmlns="http://www.w3.org/2000/svg" fill="currentColor"><g id="SVGRepo_bgCarrier" stroke-width="0"></g><g id="SVGRepo_tracerCarrier" stroke-linecap="round" stroke-linejoin="round"></g><g id="SVGRepo_iconCarrier"><defs><style>.cls-1{fill:none;stroke:#020202;stroke-miterlimit:10;stroke-width:1.91px;}</style></defs><path class="cls-1" d="M13,22.5,7.82,17.36a2,2,0,0,1-.59-1.43,2,2,0,0,1,2-2,2,2,0,0,1,1.43.59L12,15.82V6.38a2,2,0,0,1,1.74-2,1.87,1.87,0,0,1,1.51.56,1.83,1.83,0,0,1,.57,1.34V12l5,.72a1.91,1.91,0,0,1,1.64,1.89h0a17.18,17.18,0,0,1-1.82,7.71l-.09.18"></path><path class="cls-1" d="M15.82,10.64a4.54,4.54,0,0,0,1.47-1,4.78,4.78,0,1,0-6.76,0,4.54,4.54,0,0,0,1.47,1"></path><polyline class="cls-1" points="4.36 9.14 1.5 6.27 4.36 3.41"></polyline><line class="cls-1" x1="9.14" y1="6.27" x2="1.5" y2="6.27"></line></g></svg>
			</div>
			
			{% snipplet 'placeholders/product-detail-image-placeholder.tpl' %}
			{% if has_multiple_slides and home_main_product %}
				<div class="js-swiper-product-pagination swiper-pagination position-relative pt-3 pb-1 d-md-none"></div>
			{% endif %}
		</div>
	{% endif %}
</div>