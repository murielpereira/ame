{% if settings.show_instafeed and store.instagram and store.hasInstagramToken() %}
    <section class="section-home section-instafeed-home overflow-none py-2 py-md-4" data-store="home-instagram-feed">
        <div class="container">
            <div class="row align-items-center">
                {% set instuser = store.instagram|split('/')|last %}
                <div class="col-md-3 p-0 pl-md-3">
                    <a target="_blank" href="{{ store.instagram }}" class="instafeed-link instafeed-title mb-0" aria-label="{{ 'Instagram de' | translate }} {{ store.name }}">
                        <div class="img-absolute-centered-vertically h-auto px-4 text-center">
                            <svg class="icon-inline icon-2x mb-2 svg-icon-text"><use xlink:href="#instagram"/></svg> 
                            <h2 class="h4 mb-0">{{ instuser }}</h2>
                            {# Instagram fallback info in case feed fails to load #}
                            <div class="js-ig-fallback">
                                <p class="btn-link font-small mt-2 mb-0">{{ 'Ver perfil' | translate }}</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-9 p-0 px-md-3">
                    {% if store.hasInstagramToken() %}
                        <div class="js-ig-success js-swiper-instafeed swiper-container">
                            <div class="swiper-wrapper"
                                data-ig-feed
                                data-ig-items-count="6"
                                data-ig-item-class="swiper-slide"
                                data-ig-link-class="instafeed-link m-md-0"
                                data-ig-image-class="instafeed-img w-100 fade-in"
                                data-ig-aria-label="{{ 'Publicación de Instagram de' | translate }} {{ store.name }}"
                                style="display: none;">
                            </div>
                        </div>
                    {% endif %}
                </div>
            </div>
        </div>
    </section>
{% endif %}