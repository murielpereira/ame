{% set description_content = product.description is not empty or settings.show_product_fb_comment_box %}
<div class="{% if not description_content %}mt-2 mt-md-0{% endif %} {% if settings.full_width_description %}container pt-md-3{% else %}px-md-3{% endif %} pb-md-4" data-store="product-description-{{ product.id }}">

    {# Product description #}

    {% if product.description is not empty %}
        <h6 class="mb-4">{{ "Descripción" | translate }}</h6>
        <div class="user-content font-small mb-4">
            {{ product.description }}
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                var userContent = document.querySelector('.user-content');
                if (userContent) {
                    var iframes = userContent.querySelectorAll('iframe');
                    for (var i = 0; i < iframes.length; i++) {
                        if (!iframes[i].hasAttribute('title')) {
                            iframes[i].setAttribute('title', 'Vídeo descritivo');
                        }
                    }
                    var images = userContent.querySelectorAll('img');
                    for (var j = 0; j < images.length; j++) {
                        if (!images[j].hasAttribute('alt')) {
                            images[j].setAttribute('alt', 'Imagem descritiva');
                        }
                    }
                }
            });
        </script>
    {% endif %}

    {% if settings.show_product_fb_comment_box %}
        <div class="fb-comments section-fb-comments mb-3" data-href="{{ product.social_url }}" data-num-posts="5" data-width="100%"></div>
    {% endif %}
    <div id="reviewsapp"></div>
    
    {% include 'snipplets/social/social-share.tpl' %}

</div>
