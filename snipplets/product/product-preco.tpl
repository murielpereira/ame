{# ========================================================= #}
{# CONFIGURAÇÃO MANUAL DE IDIOMAS E TRADUÇÕES                #}
{# ========================================================= #}

{% set lang = current_language.lang %}

{# Definindo os textos padrão (Português) #}
{% set text_from = 'a partir de' %}
{% set text_details = 'Ver mais detalhes' %}
{% set is_brazil = true %}

{# Ajustes para Espanhol #}
{% if lang == 'es' %}
    {% set text_from = 'a partir de' %} 
    {% set text_details = 'Ver más detalles' %}
    {% set is_brazil = false %}
{# Ajustes para Inglês #}
{% elseif lang == 'en' %}
    {% set text_from = 'from' %}
    {% set text_details = 'See details' %}
    {% set is_brazil = false %}
{% endif %}

{# ========================================================= #}

{# Container Principal #}
<div>
    
    {# --- 1. PREÇO "DE" (Igual para todos) --- #}
    <div class="d-flex align-items-center mb-1" style="gap: 10px; flex-wrap: wrap;">
        <span id="compare_price_display" class="js-compare-price-display price-compare" style="text-decoration: line-through; color: var(--main-foreground); opacity: 0.6; font-size: 15px; {% if not product.compare_at_price or not product.display_price %}display:none;{% else %}display:inline-block;{% endif %}">
            {# "De:" fixo ou traduzido manualmente #}
            {% if lang == 'en' %}From:{% else %}De:{% endif %} 
            {% if product.compare_at_price and product.display_price %}{{ product.compare_at_price | money }}{% endif %}
        </span>
        
        {# Etiqueta de desconto #}
        {% include 'snipplets/labels.tpl' with {product_detail: true} %}
    </div>

    {# ========================================================= #}
    {# LÓGICA DE EXIBIÇÃO: BRASIL vs INTERNACIONAL               #}
    {# ========================================================= #}

    {% if is_brazil %}
    
        {# === VERSÃO BRASIL === #}

        {# 2. PREÇO NO CARTÃO (AGORA PRIMEIRO) #}
        <div class="mb-1 d-flex align-items-baseline" style="gap: 5px; flex-wrap: wrap; margin-top: 3px;">
            <span style="font-size: 16px; font-weight: normal; color: var(--main-foreground); opacity: 0.8;">
                {{ text_from }}
            </span>
            <span class="js-price-display font-weight-bold" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}" style="font-size: 24px; color: var(--main-foreground);">
                {% if product.display_price %}{{ product.price | money }}{% endif %}
            </span>
            <span style="font-size: 16px; color: var(--main-foreground); opacity: 0.8;">
                {% if lang == 'en' %}on card{% elseif lang == 'es' %}en tarjeta{% else %}no cartão{% endif %}
            </span>
        </div>

        {# 3. PREÇO PIX (AGORA SEGUNDO) #}
        <div class="mb-0 d-flex align-items-baseline" style="gap: 5px; flex-wrap: wrap;">
            <span style="font-size: 15px; color: var(--main-foreground); opacity: 0.8;">
                {% if lang == 'en' %}or{% elseif lang == 'es' %}o{% else %}ou{% endif %}
            </span>
            <div class="js-pix-discount-container" style="color: var(--main-foreground);">
                {{ component('payment-discount-price', {
                        visibility_condition: settings.payment_discount_price,
                        location: 'product',
                        container_classes: "d-inline-block",
                        text_classes: { price: 'h3 font-weight-bold mb-0' },
                    }) 
                }}
            </div>
            {# Texto "no PIX" removido conforme solicitado #}
        </div>

    {% else %}

        {# === VERSÃO INTERNACIONAL (SEM PIX) === #}
        
        {# O Pix é ocultado e o Preço "Normal" (Cartão) ganha destaque #}
        <div class="mb-1">
            <div class="h2 font-weight-bold mb-0" style="color: var(--main-foreground); display: flex; align-items: baseline; flex-wrap: wrap; gap: 5px; margin-top: 3px">
                
                {# Texto "A partir de" traduzido manualmente #}
                <span style="font-size: 16px; font-weight: normal; color: var(--main-foreground); opacity: 0.8;">
                    {{ text_from }}
                </span>

                {# Preço Principal (Cartão) #}
                <span class="js-price-display font-weight-bold" id="price_display" {% if not product.display_price %}style="display:none;"{% endif %} data-product-price="{{ product.price }}" style="font-size: 24px; color: var(--main-foreground);">
                    {% if product.display_price %}{{ product.price | money }}{% endif %}
                </span>
            </div>
        </div>

    {% endif %}

    {# ========================================================= #}

    <div class="parcelamento">
        {# --- 4. PARCELAMENTO (SEM JUROS) E LINK DO MODAL --- #}
        
        {% set installments_info = product.installments_info_from_any_variant %}
        {% set hasDiscount = product.maxPaymentDiscount.value > 0 %}
        {% set show_payments_info = settings.product_detail_installments and product.show_installments and product.display_price and installments_info %}

        {# LÓGICA: Verifica se há mais de 1 parcela disponível no geral para manter o botão modal funcionando #}
        {% set max_installments_data = product.get_max_installments %}
        {% set has_multiple_installments = max_installments_data and max_installments_data.installment > 1 %}
        
        {# Exibição das Parcelas (Lista de x vezes APENAS SEM JUROS) #}
        {% if show_payments_info and is_brazil %}
            {% set max_installments_without_interest = product.get_max_installments(false) %}
            {% if max_installments_without_interest and max_installments_without_interest.installment > 1 %}
                <div class="mb-1 font-small installments-manual" style="color: var(--main-foreground); opacity: 0.9; margin-top: 2px; margin-bottom: 0px !important;">
                    {{ "Até" | translate }} 
                    <strong>{{ max_installments_without_interest.installment }}x</strong> 
                    {{ "de" | translate }} 
                    <strong>{{ max_installments_without_interest.installment_data.installment_value_cents | money }}</strong>
                    {{ "sem juros" | translate }}
                </div>
            {% endif %}
        {% endif %}

        {# Link "Ver mais detalhes" - AGORA SÓ APARECE SE TIVER MAIS DE 1 PARCELA #}
        {% if not home_main_product and (show_payments_info or hasDiscount) and has_multiple_installments %}
            <a id="btn-installments" 
            href="javascript:void(0)" 
            class="js-modal-open js-fullscreen-modal-open font-small d-block mt-1" 
            data-toggle="#installments-modal" 
            data-modal-url="modal-fullscreen-payments"
            style="color: var(--main-foreground); text-decoration: underline; margin-top: 2px !important; opacity: 0.8;">
                <svg class="icon-inline icon-lg" style="fill: var(--main-foreground);"><use xlink:href="#credit-card"/></svg>
                {# Usa a variável de texto definida no topo #}
                {{ text_details }}
            </a>
        {% endif %}
    </div>

    {# --- 5. CASHBACK --- #}
    <div class="mt-2">
        {% include 'snipplets/product/product-cashback.tpl' %}
    </div>
    
</div>