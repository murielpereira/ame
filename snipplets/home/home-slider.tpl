{% set has_main_slider = settings.slider and settings.slider is not empty %}
{% set has_mobile_slider = settings.toggle_slider_mobile and settings.slider_mobile and settings.slider_mobile is not empty %}
{% set slider_align = settings.slider_align %}
{% set slider_animation = settings.slider_animation ? 'true' : 'false' %}

{% if not mobile %}
<div class="js-home-main-slider-container {% if not has_main_slider and not params.preview %}hidden{% endif %}">
{% endif %}
    <div class="{% if mobile %}js-home-mobile-slider{% else %}js-home-main-slider{% endif %}-visibility {% if has_main_slider and has_mobile_slider %}{% if mobile %}d-md-none{% else %}d-none d-md-block{% endif %}{% elseif not settings.toggle_slider_mobile and mobile %}hidden{% endif %}">
        <div class="js-home-slider-section section-slider position-relative">
            {% if not settings.slider_full %}
                <div class="js-home-slider-container container">
            {% endif %}
                <div class="js-home-slider{% if mobile %}-mobile{% endif %} h-100 swiper-container swiper-container-horizontal" data-align="{{ slider_align }}" data-animation="{{ slider_animation }}">
                    <div class="swiper-wrapper">
                        {% if mobile %}
                            {% set slider = settings.slider_mobile %}
                        {% else %}
                            {% set slider = settings.slider %}
                        {% endif %}
                        {% for slide in slider %}
                            {% set has_text = slide.title or slide.description or slide.button %}
                            <div class="swiper-slide slide-container swiper-{{ slide.color }}">
                                {% if slide.link %}
                                    <a href="{{ slide.link | setting_url }}" aria-label="{{ 'Carrusel' | translate }} {{ loop.index }}">
                                {% endif %}
                                <div class="slider-slide">
                                    {% if loop.first %}
                                        <link rel="preload" as="image" href="{{ slide.image | static_url | settings_image_url('large') }}" imagesrcset="{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {{ slide.image | static_url | settings_image_url('original') }} 1024w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w" imagesizes="100vw">
                                        <img
                                            {% if slide.width and slide.height %} width="{{ slide.width }}" height="{{ slide.height }}" {% endif %}
                                            src="{{ slide.image | static_url | settings_image_url('large') }}"
                                            srcset="{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {{ slide.image | static_url | settings_image_url('original') }} 1024w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w"
                                            class="js-slider-image slider-image {% if settings.slider_animation %}slider-image-animation{% endif %} swiper-lazy fade-in"
                                            alt="{{ 'Carrusel' | translate }} {{ loop.index }}"
                                            fetchpriority="high"
                                            loading="eager"
                                        />
                                    {% else %}
                                        <img
                                            {% if slide.width and slide.height %} width="{{ slide.width }}" height="{{ slide.height }}" {% endif %}
                                            src="images/empty-placeholder.png"
                                            data-src="{{ slide.image | static_url | settings_image_url('large') }}"
                                            data-srcset="{{ slide.image | static_url | settings_image_url('large') }} 480w, {{ slide.image | static_url | settings_image_url('huge') }} 640w, {{ slide.image | static_url | settings_image_url('original') }} 1024w, {{ slide.image | static_url | settings_image_url('1080p') }} 1920w"
                                            class="js-slider-image slider-image {% if settings.slider_animation %}slider-image-animation{% endif %} swiper-lazy fade-in"
                                            alt="{{ 'Carrusel' | translate }} {{ loop.index }}"
                                            loading="lazy"
                                        />
                                    {% endif %}
                                    <div class="placeholder-fade"></div>
                                    {% if has_text %}
                                        <div class="js-swiper-text swiper-text{% if slider_align == 'center' %} swiper-text-centered{% endif %} swiper-text-{{ slide.color }}">
                                            {% if slide.description %}
                                                <p class="mb-3">{{ slide.description }}</p>
                                            {% endif %}
                                            {% if slide.title %}
                                                <div class="h1-huge mb-3">{{ slide.title }}</div>
                                            {% endif %}
                                            {% if slide.button and slide.link %}
                                                <div class="btn btn-default btn-small d-inline-block">{{ slide.button }}</div>
                                            {% endif %}
                                        </div>
                                    {% endif %}
                                </div>
                                {% if slide.link %}
                                    </a>
                                {% endif %}
                            </div>
                        {% endfor %}
                    </div>
                    <div class="js-swiper-home-arrows d-none d-md-block">
                        <div class="js-swiper-home-control js-swiper-home-prev{% if mobile %}-mobile{% endif %} swiper-button-prev svg-icon-text">
                            <svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
                        </div>
                        <div class="js-swiper-home-control js-swiper-home-next{% if mobile %}-mobile{% endif %} swiper-button-next svg-icon-text">
                            <svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
                        </div>
                    </div>
                    <div class="js-swiper-home-control js-swiper-home-pagination{% if mobile %}-mobile{% endif %} swiper-pagination swiper-pagination-bullets my-3">
                        {% if slider | length > 1 and not params.preview %}
                            {% for slide in slider %}
                                <span class="swiper-pagination-bullet"></span>
                            {% endfor %}
                        {% endif %}
                    </div>
                </div>
            {% if not settings.slider_full %}
                </div>
            {% endif %}
        </div>
    </div>
{% if not mobile %}
</div>
{% endif %}