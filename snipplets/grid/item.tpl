{# /*============================================================================
  #Item grid - Atualizado: Nomes Múltiplas Linhas, Botões Alinhados e Parcelas S/ Juros
==============================================================================*/ #}

{# verifica se o produto tem a tag "agrupamento_" #}
{% set video_mode = video_mode | default(false) %}
{% set product_have_agruped_tag = false %}
{% set product_have_customization_tag = false %}
{% set special_product = false %}
{% set hide_product = false %}

{# percorrer as tags do produto #}
{% for tag in product.tags %}
    {% set split_tag = tag|split('_') %}
    {% if split_tag[0] == 'agrupamento' %}
        {% set product_have_agruped_tag = true %}
    {% elseif tag == 'produto_principal' %}
        {% set special_product = true %}
    {% elseif split_tag[0] == 'customizacao' %}
        {% set product_have_customization_tag = true %}
    {% endif %}
{% endfor %}

{% if product_have_agruped_tag and not special_product %}
    {% set hide_product = true %}
{% endif %}

{% set slide_item = slide_item | default(false) %}

{% if template == 'home'%}
    {% set columns_desktop = section_columns_desktop %}
    {% set columns_mobile = section_columns_mobile %}
    {% set section_slider = section_slider %}
{% else %}
    {% set columns_desktop = settings.grid_columns_desktop %}
    {% set columns_mobile = settings.grid_columns_mobile %}
    {% if template == 'product'%}
        {% set section_slider = true %}
    {% endif %}
{% endif %}

{% set productName = product.name %}
{% if special_product %}
    {% set name_parts = productName|split(' -') %}
    {% set productName = name_parts|slice(0, name_parts|length - 1)|join(' -') %}
{% endif %}

{# Ajuste 2: Adicionamos display flex e flex-direction column diretamente na raiz do item para garantir altura igual #}
<div class="js-item-product{% if not video_mode %}{% if slide_item %} js-item-slide swiper-slide{% endif %} col-{% if columns_mobile == 1 %}12{% else %}6{% endif %} col-md-{% if columns_desktop == 4 %}3{% elseif columns_desktop == 5 %}2-4{% else %}2{% endif %} item-product col-grid{% else %} w-100{% endif %}" data-product-type="list" data-product-id="{{ product.id }}" data-store="product-item-{{ product.id }}" data-component="product-list-item" data-component-value="{{ product.id }}" style="{% if hide_product and not video_mode %}display: none;{% else %}display: flex; flex-direction: column; height: auto;{% endif %}">
    
    {# ALINHAMENTO BOTÕES: .item transformado em coluna flexível com flex-grow para preencher o espaço total #}
    <div class="item" style="display: flex; flex-direction: column; flex-grow: 1; height: 100%; width: 100%;">
        {% if settings.quick_shop or settings.product_color_variants %}
            <div class="js-product-container js-quickshop-container{% if product.variations %} js-quickshop-has-variants{% endif %} position-relative" data-variants="{{ product.variants_object | json_encode }}" data-quickshop-id="quick{{ product.id }}" style="display: flex; flex-direction: column; flex-grow: 1; height: 100%; width: 100%;">
        {% endif %}
        
        {% set product_url_with_selected_variant = has_filters ?  ( product.url | add_param('variant', product.selected_or_first_available_variant.id)) : product.url  %}

        {% set item_img_width = product.featured_image.dimensions['width'] %}
        {% set item_img_height = product.featured_image.dimensions['height'] %}
        {% set item_img_srcset = special_product ? product.other_images | last : product.featured_image %}
        {% set item_img_alt = product.featured_image.alt %}
        {% set item_img_spacing = item_img_height / item_img_width * 100 %}
        {% set show_secondary_image = settings.product_hover and product.other_images %}

        {# --- CONTAINER DA IMAGEM --- #}
        <div class="{% if show_secondary_image %}js-item-with-secondary-image{% endif %} item-image">
            
            {# --- TAGS SOBRE A IMAGEM (ESGOTADO / DESCONTO) --- #}
            {% if not product.available %}
                <div style="position: absolute; top: 5px; left: 5px; z-index: 10; background: #999; color: #fff; padding: 8px 10px; font-size: 10px; border-radius: 5px; letter-spacing: 1px; text-transform: uppercase;">
                    {{ "Sin stock" | translate }}
                </div>
            {% elseif product.compare_at_price > product.price %}
                <div style="position: absolute; top: 5px; left: 5px; z-index: 10; background: var(--button-foreground); color: var(--button-background); padding: 8px 10px; font-size: 10px; border-radius: 5px; font-weight: bold; letter-spacing: 1px; text-transform: uppercase;">
                    {{ (100 - (product.price * 100 / product.compare_at_price)) | round }}% OFF
                </div>
            {% endif %}

            <div style="padding-bottom: {{ item_img_spacing }}%;" class="js-item-image-padding position-relative">
                <a href="{{ product_url_with_selected_variant }}">
                    <img alt="{{ item_img_alt }}" 
                        src="{{ 'images/empty-placeholder.png' | static_url }}" 
                        data-srcset="{{ item_img_srcset | product_image_url('medium')}} 320w" 
                        width="{{ item_img_width }}"
                        height="{{ item_img_height }}"
                        class="js-item-image lazyload img-absolute img-absolute-centered fade-in {% if not product.available %}opacity-50{% endif %} {% if show_secondary_image %}item-image-primary{% endif %}"/> 
                    
                    {% if show_secondary_image %}
                        <img alt="{{ item_img_alt }}" 
                            src="{{ 'images/empty-placeholder.png' | static_url }}" 
                            data-srcset="{{ product.other_images | first | product_image_url('medium')}} 320w" 
                            width="{{ item_img_width }}"
                            height="{{ item_img_height }}"
                            class="js-item-image js-item-image-secondary lazyload img-absolute img-absolute-centered fade-in item-image-secondary" 
                            style="display:none;" />
                    {% endif %}
                </a>
            </div>
        </div>

        {# ALINHAMENTO BOTÕES: description ocupa o espaço restante (flex-grow: 1) e tem mt-2 para aproximar da foto #}
        <div class="item-description mt-2" style="display: flex; flex-direction: column; flex-grow: 1;">
            
            <a href="{{ product_url_with_selected_variant }}" class="item-link" style="text-decoration: none; display: flex; flex-direction: column; flex-grow: 1;">
                
                {# AJUSTE 1: Nome do Produto (Força a quebra de linha com white-space: normal !important) #}
                <div class="js-item-name item-name mb-2 font-weight-bold text-center" style="font-size: 15px; white-space: normal !important; overflow: visible !important; display: block !important;">
                    {{ productName }}
                </div>

                {# ========================================================= #}
                {# SELO KONFIDENCY TOP RATED AQUI                            #}
                {# ========================================================= #}
                <div class="kfc-card-rating mb-2" style="display: flex; justify-content: center; width: 100%;">
                    <div class="konfidency-badges" data-sku="{{ product.id }}"></div>
                </div>
                {# ========================================================= #}

                {% if product.display_price %}
                    
                    {# CONFIGURAÇÃO MANUAL DE IDIOMAS #}
                    {% set lang = current_language.lang %}
                    {% set text_from = 'a partir de' %}
                    {% set text_cashback_prefix = 'Ganhe' %}
                    {% set text_cashback_suffix = 'de cashback' %}
                    {% set is_brazil = true %}

                    {% if lang == 'es' %}
                        {% set text_from = 'a partir de' %}
                        {% set text_cashback_prefix = 'Gana' %}
                        {% set text_cashback_suffix = 'de cashback' %}
                        {% set is_brazil = false %}
                    {% elseif lang == 'en' %}
                        {% set text_from = 'from' %}
                        {% set text_cashback_prefix = 'Earn' %}
                        {% set text_cashback_suffix = 'cashback' %}
                        {% set is_brazil = false %}
                    {% endif %}

                    {# ========================================================= #}
                    {# NOVO CONTAINER DE PREÇOS (Empurrado para baixo com margin-top: auto) #}
                    {# ========================================================= #}
                    <div class="item-price-container mb-1 w-100" style="margin-top: auto;">
                        
                        {# 1. PREÇO COM DESCONTO (Usa opacity para herdar o main-foreground e o hover) #}
                        <div class="js-compare-price-display price-compare" style="text-decoration: line-through; opacity: 0.6; font-size: 13px; margin-bottom: 2px; {% if not product.compare_at_price or not product.display_price %}display:none;{% else %}display:block;{% endif %}">
                            {% if lang == 'en' %}From:{% else %}De:{% endif %}
                            {% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}
                        </div>

                        {# 2. PREÇO CHEIO DO PRODUTO #}
                        <div class="price-main d-flex align-items-baseline" style="gap: 4px; margin-bottom: 2px;">
                            <span style="font-size: 13px; opacity: 0.8;">{{ text_from }}</span>
                            <span class="js-price-display item-price-main font-weight-bold" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}" style="font-size: 16px;">
                                {% if product.display_price %}{{ product.price | money }}{% endif %}
                            </span>
                        </div>

                        {# LÓGICA BRASIL VS INTERNACIONAL #}
                        {% if is_brazil %}

                            {# 3. QUANTIDADE DE PARCELAS (SOMENTE SEM JUROS) #}
                            {% set max_installments_without_interest = product.get_max_installments(false) %}
                            {% set has_multiple_installments_without_interest = max_installments_without_interest and max_installments_without_interest.installment > 1 %}

                            {% if has_multiple_installments_without_interest %}
                                <div class="installments-manual font-small" style="opacity: 0.8; font-size: 12px; margin-bottom: 4px;">
                                    ou {{ max_installments_without_interest.installment }}x de {{ max_installments_without_interest.installment_data.installment_value_cents | money }}
                                </div>
                            {% endif %}

                            {# 4. PREÇO COM DESCONTO DO PIX #}
                            {% if settings.payment_discount_price %}
                                <div class="js-pix-discount-container" style="margin-bottom: 6px;">
                                    {{ component('payment-discount-price', {
                                            visibility_condition: settings.payment_discount_price,
                                            location: 'product',
                                            container_classes: "d-inline-block",
                                            text_classes: { price: 'font-size: 14px; font-weight: bold' },
                                        })
                                    }}
                                </div>
                            {% endif %}

                        {% endif %}

                        {# 5. MENSAGEM DE CASHBACK (Distância ajustada e cor mantida fixa para o badge promocional) #}
                        {% set porcentagem_cashback = theme.settings.PORCENTAGEM_CASHBACK | default("10") %}
                        <div class="cashback-badge mt-1" style="font-size: 12px; color: var(--main-foreground); font-weight: 600; display: flex; align-items: center; gap: 4px;">
                            <svg width="14" height="14" viewBox="0 0 74 68" fill="none" xmlns="http://www.w3.org/2000/svg">
                                <path d="M73.5001 34C73.5001 52.5 58.5001 67.5 40.0001 67.5C21.5001 67.5 6.5001 52.5 6.5001 34C6.5001 33.7 6.60009 33.4 6.70009 33.2L3.40009 36.5C3.10009 36.8 2.60009 37 2.20009 37C1.80009 37 1.3001 36.8 1.0001 36.5C0.300098 35.8 0.300098 34.7 1.0001 34.1L7.1001 28C7.3001 27.8 7.50009 27.7 7.70009 27.6C8.20009 27.4 8.8001 27.4 9.3001 27.8C9.4001 27.9 9.5001 27.9 9.6001 28L15.7001 34.1C16.4001 34.8 16.4001 35.9 15.7001 36.5C15.4001 36.8 14.9001 37 14.5001 37C14.1001 37 13.6001 36.8 13.3001 36.5L10.0001 33.2C10.1001 33.4 10.2001 33.7 10.2001 34C10.2001 50.6 23.7001 64.1 40.3001 64.1C56.9001 64.1 70.4001 50.6 70.4001 34C70.4001 17.4 56.9001 3.89999 40.3001 3.89999C32.1001 3.89999 24.5001 7.1 18.8001 13C18.1001 13.7 17.0001 13.7 16.4001 13C15.7001 12.3 15.7001 11.2 16.4001 10.6C22.8001 4.10001 31.3001 0.5 40.4001 0.5C58.5001 0.5 73.5001 15.5 73.5001 34ZM40.0001 15.9C39.1001 15.9 38.3001 16.7 38.3001 17.6V21.2H37.5001C33.5001 21.2 30.3001 24.4 30.3001 28.4C30.3001 32.4 33.5001 35.6 37.5001 35.6H42.5001C44.6001 35.6 46.3001 37.3 46.3001 39.4C46.3001 41.5 44.6001 43.2 42.5001 43.2H42.4001H42.3001H33.4001C32.5001 43.2 31.7001 44 31.7001 44.9C31.7001 45.8 32.5001 46.6 33.4001 46.6H38.2001V50.2C38.2001 51.1 39.0001 51.9 39.9001 51.9C40.8001 51.9 41.6001 51.1 41.6001 50.2V46.6H42.2001H42.3001H42.4001C46.4001 46.6 49.6001 43.4 49.6001 39.4C49.6001 35.4 46.4001 32.2 42.4001 32.2H37.4001C35.3001 32.2 33.6001 30.5 33.6001 28.4C33.6001 26.3 35.3001 24.6 37.4001 24.6H46.3001C47.2001 24.6 48.0001 23.8 48.0001 22.9C48.0001 22 47.2001 21.2 46.3001 21.2H41.7001V17.6C41.8001 16.7 41.0001 15.9 40.0001 15.9Z" fill="var(--main-foreground)"></path>
                            </svg>
                            {{ text_cashback_prefix }} {{ porcentagem_cashback }}% {{ text_cashback_suffix }}
                        </div>

                    </div>
                {% endif %}
            </a>
        </div>

        {# BOTÃO COMPRAR / AVISE-ME (Afastado do item de baixo com mb-3) #}
        {% if product.available %}
            <a href="{{ product.url }}" class="btn btn-primary btn-small btn-smallest-md px-4 mt-2 mb-3 w-100">
                <span>{{ 'Comprar' | translate }}</span>
            </a>
        {% else %}
            <a href="{{ product.url }}" class="btn btn-secondary btn-small btn-smallest-md px-4 mt-2 mb-3 w-100">
                <span>{{ "Hágamelo Saber" | translate }}</span>
            </a>
        {% endif %}

        {% if settings.quick_shop or settings.product_color_variants %}
            </div>
        {% endif %}
    </div>
</div>