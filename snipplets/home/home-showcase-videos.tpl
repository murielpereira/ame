{% set has_showcase_video = settings.showcase_video_enable and ( settings.showcase_video_01 or settings.showcase_video_02 or settings.showcase_video_03 or settings.showcase_video_04 or settings.showcase_video_05 or settings.showcase_video_06 ) %}

{% if has_showcase_video %}
<section class="section-home lb-showcase-videos js-section-video-products-lazy">
	<div class="container">
        {% if settings.showcase_video_title %}
		<h2 class="lb-showcase-videos-title">{{ settings.showcase_video_title }}</h2>
		{% endif %}
        {% if settings.showcase_video_subtitle %}
		<p class="lb-showcase-videos-subtitle text-center">{{ settings.showcase_video_subtitle }}</p>
		{% endif %}
        
        <div class="lb-showcase-videos-container">
			<div class="js-section-video-products swiper-container" data-store="home-video-product">
                <div class="swiper-wrapper" data-store="home-video-product-swiper">
                    {% for video_index in 1..6 %}
                        {% set video_url = 'showcase_video_0' ~ video_index %}
                        {% set video_url = attribute(settings, video_url) %}

                        {% if video_url and video_url is not empty %}
                            {% set product = null %}

                            {% if sections.video.products[loop.index - 1] %}
                                {% set product = sections.video.products[loop.index - 1] %}
                            {% endif %}

                            {% set video_url = 'VIDEOS/' ~ video_url %}
                            <div class="swiper-slide" id="video-{{ video_index }}" data-index="{{ loop.index }}" data-store="home-video-product-{{ video_index }}">
                                <div class="lb-showcase-video-item">
                                    <button class="js-lb-showcase-video-play-button lb-showcase-video-play-button" aria-label="Play no vídeo">
                                        <span class="lb-showcase-video-play-button-icon">
                                            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M22.7524 10.0499L3.86361 0.306386C2.30743 -0.489961 0 0.306386 0 2.22699V21.7141C0 23.4941 2.14645 24.5715 3.86361 23.6815L22.7524 13.938C24.4159 13.0479 24.4159 10.94 22.7524 10.0499Z" fill="#FCFCFC"></path></svg>
                                        </span>
                                    </button>
                                    <div class="lb-showcase-video-item-video">
                                        <div class="lb-showcase-video-item-video-image">

                                            <div class="lb-showcase-video-item-video-video-wrapper video-responsive">
                                                <!-- Barra de progresso personalizada -->
                                                <div class="video-progress-container">
                                                    <div class="video-progress-bar">
                                                        <div class="video-progress-fill"></div>
                                                    </div>
                                                </div>
                                                <img src="{{ 'images/empty-placeholder.png' | static_url }}" alt="video" class="video-thumbnail">
                                                <video src="{{ video_url | static_url }}" muted loop playsinline></video>

                                                {% if product %}
                                                <div class="lb-showcase-video-item-product-actions">
                                                    {% include 'snipplets/grid/item.tpl' with { video_mode: true} %}
                                                </div>
                                                {% endif %}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {% endif %}
                    {% endfor %}
                </div>
                <div class="js-section-video-products-prev swiper-button-prev swiper-button-outside d-none d-md-block svg-icon-text" aria-label="{{ 'Anterior' | translate }}" role="button" tabindex="0">
                    <svg class="icon-inline icon-lg icon-flip-horizontal" aria-hidden="true"><use xlink:href="#chevron"/></svg>
                </div>
                <div class="js-section-video-products-next swiper-button-next swiper-button-outside d-none d-md-block svg-icon-text" aria-label="{{ 'Próxima' | translate }}" role="button" tabindex="0">
                    <svg class="icon-inline icon-lg" aria-hidden="true"><use xlink:href="#chevron"/></svg>
                </div>
            </div>
		</div>
	</div>
</section>

<div class="lb-showcase-videos-modal" style="display: none;">
    <div class="lb-showcase-videos-modal-close">
        <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M18 6L6 18M6 6L18 18" stroke="white" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
    </div>
    <div class="lb-showcase-videos-modal-container">
        <div class="js-section-video-products-modal swiper-container" data-store="home-video-product">
            <div class="swiper-wrapper">
                {% for video_index in 1..6 %}
                    {% set video_url = 'showcase_video_0' ~ video_index %}
                    {% set video_url = attribute(settings, video_url) %}

                    {% if video_url and video_url is not empty %}
                        {% set product = null %}

                        {% if sections.video.products[loop.index - 1] %}
                            {% set product = sections.video.products[loop.index - 1] %}
                        {% endif %}

                        {% set video_url = 'VIDEOS/' ~ video_url %}
                        <div class="swiper-slide" data-index="{{ loop.index }}" id="video-{{ video_index }}" data-store="home-video-product-{{ video_index }}">
                            <div class="js-lb-showcase-video-item-product">
                                <div class="lb-showcase-video-item-product-video">
                                    <div class="lb-showcase-video-item-product-video-wrapper video-responsive">
                                        <!-- aqui vamos duplicar o video do produto ao lado do video do modal -->
                                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ video_url | replace('.MOV', '.png') | static_url }}" alt="video" class="video-thumbnail">
                                        <video src="{{ video_url | static_url }}" data-src="{{ video_url | static_url }}" playsinline controls loop></video>

                                        {% if product %}
                                        <a href="{{ product.url }}" class="lb-showcase-video-item-product-video-link d-block d-md-none btn btn-primary btn-small btn-smallest-md px-4" title="{{ 'Comprar' | translate }}" aria-label="{{ 'Comprar' | translate }}">
                                            <span>{{ 'Comprar' | translate }}</span>
                                        </a>
                                        {% endif %}
                                    </div>
                                </div>
                                {% if product %}
                                <div class="lb-showcase-video-item-product-content d-none d-md-block">
                                    {% include 'snipplets/grid/item.tpl' with { video_mode: true} %}
                                </div>
                                {% endif %}
                            </div>
                        </div>
                    {% endif %}
                {% endfor %}
            </div>
            <div class="js-section-video-products-modal-prev swiper-button-prev swiper-button-outside d-none d-md-block svg-icon-text" aria-label="{{ 'Anterior' | translate }}" role="button" tabindex="0">
                <svg class="icon-inline icon-lg icon-flip-horizontal" aria-hidden="true"><use xlink:href="#chevron"/></svg>
            </div>
            <div class="js-section-video-products-modal-next swiper-button-next swiper-button-outside d-none d-md-block svg-icon-text" aria-label="{{ 'Próxima' | translate }}" role="button" tabindex="0">
                <svg class="icon-inline icon-lg" aria-hidden="true"><use xlink:href="#chevron"/></svg>
            </div>
        </div>
    </div>
</div>
{% endif %}