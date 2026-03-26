{# ========================================================= #}
{# CONFIGURAÇÃO MANUAL DE IDIOMAS E TEXTOS                   #}
{# ========================================================= #}

{% set lang = current_language.lang %}

{# Padrão (Português) #}
{% set text_prefix = 'Ganhe' %}
{% set text_suffix = 'de cashback' %}
{% set is_brazil = true %}

{# Espanhol #}
{% if lang == 'es' %}
    {% set text_prefix = 'Gana' %}
    {% set text_suffix = 'de cashback' %}
    {% set is_brazil = false %}
{# Inglês #}
{% elseif lang == 'en' %}
    {% set text_prefix = 'Earn' %}
    {% set text_suffix = 'cashback' %}
    {% set is_brazil = false %}
{% endif %}

{# ========================================================= #}

<div class="cashback-container">
    <svg viewBox="0 0 74 68" fill="none" xmlns="http://www.w3.org/2000/svg"> <path d="M73.5001 34C73.5001 52.5 58.5001 67.5 40.0001 67.5C21.5001 67.5 6.5001 52.5 6.5001 34C6.5001 33.7 6.60009 33.4 6.70009 33.2L3.40009 36.5C3.10009 36.8 2.60009 37 2.20009 37C1.80009 37 1.3001 36.8 1.0001 36.5C0.300098 35.8 0.300098 34.7 1.0001 34.1L7.1001 28C7.3001 27.8 7.50009 27.7 7.70009 27.6C8.20009 27.4 8.8001 27.4 9.3001 27.8C9.4001 27.9 9.5001 27.9 9.6001 28L15.7001 34.1C16.4001 34.8 16.4001 35.9 15.7001 36.5C15.4001 36.8 14.9001 37 14.5001 37C14.1001 37 13.6001 36.8 13.3001 36.5L10.0001 33.2C10.1001 33.4 10.2001 33.7 10.2001 34C10.2001 50.6 23.7001 64.1 40.3001 64.1C56.9001 64.1 70.4001 50.6 70.4001 34C70.4001 17.4 56.9001 3.89999 40.3001 3.89999C32.1001 3.89999 24.5001 7.1 18.8001 13C18.1001 13.7 17.0001 13.7 16.4001 13C15.7001 12.3 15.7001 11.2 16.4001 10.6C22.8001 4.10001 31.3001 0.5 40.4001 0.5C58.5001 0.5 73.5001 15.5 73.5001 34ZM40.0001 15.9C39.1001 15.9 38.3001 16.7 38.3001 17.6V21.2H37.5001C33.5001 21.2 30.3001 24.4 30.3001 28.4C30.3001 32.4 33.5001 35.6 37.5001 35.6H42.5001C44.6001 35.6 46.3001 37.3 46.3001 39.4C46.3001 41.5 44.6001 43.2 42.5001 43.2H42.4001H42.3001H33.4001C32.5001 43.2 31.7001 44 31.7001 44.9C31.7001 45.8 32.5001 46.6 33.4001 46.6H38.2001V50.2C38.2001 51.1 39.0001 51.9 39.9001 51.9C40.8001 51.9 41.6001 51.1 41.6001 50.2V46.6H42.2001H42.3001H42.4001C46.4001 46.6 49.6001 43.4 49.6001 39.4C49.6001 35.4 46.4001 32.2 42.4001 32.2H37.4001C35.3001 32.2 33.6001 30.5 33.6001 28.4C33.6001 26.3 35.3001 24.6 37.4001 24.6H46.3001C47.2001 24.6 48.0001 23.8 48.0001 22.9C48.0001 22 47.2001 21.2 46.3001 21.2H41.7001V17.6C41.8001 16.7 41.0001 15.9 40.0001 15.9Z" fill="var(--main-foreground)"></path> </svg>
    <p>
        {{ text_prefix }} 
        <span class="js-cifra-cashback" style="font-weight: bold;">R$</span>
        <span id="valor-cashback"></span> {{ text_suffix }}.
    </p>
</div>

<script>

// 1. Definições de Constantes

// Define se estamos no Brasil baseado na variável do Twig
const IS_BRAZIL = {{ is_brazil ? 'true' : 'false' }};

const PORCENTAGEM_CASHBACK_STRING = '{{ settings.PORCENTAGEM_CASHBACK | default("8") }}';
window.globalCashbackPercent = '{{ theme.settings.PORCENTAGEM_CASHBACK | default("8") }}'; 

const PORCENTAGEM_CASHBACK_INTEIRO = parseFloat(PORCENTAGEM_CASHBACK_STRING) || 8;
const PORCENTAGEM_CASHBACK = PORCENTAGEM_CASHBACK_INTEIRO / 100; 

// Define o texto de exibição (ex: '8 %')
const PORCENTAGEM_DISPLAY = Math.round(PORCENTAGEM_CASHBACK_INTEIRO) + ' %';

const LIMITE_VALOR_MINIMO = 10.00;

const SELETOR_PRECO_PIX = '.js-payment-discount-price-product'; 
const SELETOR_FORM_PRODUTO = '.js-product-form';

// Função auxiliar de limpeza (Mantida)
function limparEConverterPreco(valorBrutoString) {
    if (!valorBrutoString) return 0;
    let precoLimpo = valorBrutoString.replace(/[^\d,\.]/g, ''); 
    if (precoLimpo.includes(',')) {
        if (precoLimpo.includes('.')) {
            precoLimpo = precoLimpo.replace(/\./g, '');
        }
        precoLimpo = precoLimpo.replace(',', '.');
    }
    return parseFloat(precoLimpo);
}


// 3. Função principal (ATUALIZADA)
function calcularCashbackAutomatico() {
    
    const spanValorCashback = document.getElementById('valor-cashback');
    // Buscamos o cifrão de forma segura
    const containerP = spanValorCashback ? spanValorCashback.closest('p') : null;
    const cifraElement = containerP ? containerP.querySelector('.js-cifra-cashback') : null;

    if (!spanValorCashback) return;

    // --- NOVA LÓGICA INTERNACIONAL ---
    if (!IS_BRAZIL) {
        // Se NÃO for Brasil, mostra apenas a porcentagem fixa e esconde o R$
        spanValorCashback.textContent = PORCENTAGEM_DISPLAY;
        if (cifraElement) {
            cifraElement.style.display = 'none';
        }
        // Encerra a função aqui, sem calcular valores
        return;
    }
    // ----------------------------------

    // Lógica para o BRASIL (Mantida)
    const priceDisplayPix = document.querySelector(SELETOR_PRECO_PIX); 
    if (!priceDisplayPix) return;

    let valorPixString = priceDisplayPix.textContent.trim(); 
    let precoParaCalculo = limparEConverterPreco(valorPixString);

    if (isNaN(precoParaCalculo) || precoParaCalculo === 0) {
        spanValorCashback.textContent = PORCENTAGEM_DISPLAY;
        if (cifraElement) cifraElement.style.display = 'none';
        return;
    }

    const valorCashback = precoParaCalculo * PORCENTAGEM_CASHBACK;
    
    if (valorCashback < LIMITE_VALOR_MINIMO) {
        spanValorCashback.textContent = PORCENTAGEM_DISPLAY;
        if (cifraElement) cifraElement.style.display = 'none';

    } else {
        const valorEmReais = valorCashback.toFixed(2);
        let cashbackFormatado = valorEmReais.replace('.', ',');

        if (cashbackFormatado === 'NaN' || cashbackFormatado.length < 3) {
            cashbackFormatado = '0,00'; 
        }
        
        spanValorCashback.textContent = cashbackFormatado;
        if (cifraElement) cifraElement.style.display = 'inline'; 
    }
}


// 4. Lógica de Execução
document.addEventListener('DOMContentLoaded', () => {
    
    setTimeout(calcularCashbackAutomatico, 100); 

    const targetNode = document.querySelector(SELETOR_PRECO_PIX);

    if (targetNode) {
        const callback = function(mutationsList, observer) {
            for(const mutation of mutationsList) {
                if (mutation.type === 'characterData' || mutation.type === 'childList') {
                    setTimeout(calcularCashbackAutomatico, 10); 
                }
            }
        };

        const config = { 
            childList: true, 
            subtree: true, 
            characterData: true 
        };

        const observer = new MutationObserver(callback);
        observer.observe(targetNode, config);
    }
    
    const productForm = document.querySelector(SELETOR_FORM_PRODUTO);

    if (productForm) {
        productForm.addEventListener('change', () => {
            setTimeout(calcularCashbackAutomatico, 50); 
        });
    }
});

</script>