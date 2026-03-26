{% if settings.main_categories and settings.slider_categories and settings.slider_categories is not empty %}
    {% set categories_background_image = "main_categories_image.jpg" %}
    {% set categories_mobile_background_image = "main_categories_image_mobile.jpg" %}
    {% set has_categories_background_image = categories_background_image | has_custom_image %}
    {% set has_categories_mobile_background_image = categories_mobile_background_image | has_custom_image %}
    <section class="section-home section-categories-home{% if settings.main_categories_colors or has_categories_background_image or has_categories_mobile_background_image %} section-home-color{% endif %} position-relative" data-store="home-categories-featured" data-transition="fade-in-up">
        <div class="container position-relative px-0 px-md-3">
            {% if settings.main_categories_title %}
                <h3 class="section-title mb-4 text-center">{{ settings.main_categories_title }}</h3>
            {% endif %}

            <div class="js-swiper-categories swiper-container w-auto">
                <div class="swiper-wrapper">
                    {% for slide in settings.slider_categories %}
                        <div class="swiper-slide w-md-auto">
                            {% if slide.link %}
                                <a href="{{ slide.link | setting_url }}" class="js-home-category" aria-label="{{ 'Categoría' | translate }} {{ loop.index }}">
                            {% endif %}
                                <div class="home-category text-center">
                                    <div class="home-category-image">
                                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ slide.image | static_url | settings_image_url('medium') }}" class="swiper-lazy" alt="{{ 'Categoría' | translate }} {{ loop.index }}">
                                        <div class="placeholder-fade"></div>
                                    </div>
                            {% if slide.link %}
                                        {% set category_handle = slide.link | trim('/') | split('/') | last %}
                                        {% include 'snipplets/home/home-categories-name.tpl' %}
                                    </div>
                                </a>
                            {% else %}
                                </div>
                            {% endif %}
                        </div>
                    {% endfor %}
                </div>
            </div>
            <div class="js-swiper-categories-prev swiper-button-prev swiper-button-outside svg-icon-text d-none d-md-block">
                <svg class="icon-inline icon-lg icon-flip-horizontal svg-icon-text"><use xlink:href="#chevron"/></svg>
            </div>
            <div class="js-swiper-categories-next swiper-button-next swiper-button-outside svg-icon-text d-none d-md-block">
                <svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#chevron"/></svg>
            </div>
        </div>

        {% if has_categories_background_image or has_categories_mobile_background_image %}
            {% if has_categories_background_image %}
                <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ categories_background_image | static_url | settings_image_url('large') }} 480w, {{ categories_background_image | static_url | settings_image_url('huge') }} 640w, {{ categories_background_image | static_url | settings_image_url('original') }} 1024w, {{ categories_background_image | static_url | settings_image_url('1080p') }} 1920w' class='lazyload background-home-image{% if categories_mobile_background_image | has_custom_image %} d-none d-md-block{% endif %}'/>
            {% endif %}
            {% if has_categories_mobile_background_image %}
                <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ categories_mobile_background_image | static_url | settings_image_url('large') }} 480w, {{ categories_mobile_background_image | static_url | settings_image_url('huge') }} 640w, {{ categories_mobile_background_image | static_url | settings_image_url('original') }} 1024w' class="lazyload background-home-image{% if categories_background_image | has_custom_image %} d-block d-md-none{% endif %}"/>
            {% endif %}
        {% endif %}
    </section>
{% endif %}
