{#
    DOCUMENTAÇÃO: home-ad-bar.tpl (ATUALIZADO com Ícones SVG e Link do WhatsApp)
    Função: Contém a estrutura, estilos e lógica para a barra de anúncios rotativa com ícones e um link direto para o WhatsApp.
#}

<style>
/* --------------------------------------
    CSS: Estilos da Barra de Anúncios (AJUSTADO PARA ÍCONES E LINKS)
-------------------------------------- */
.ad-bar-container {
    background-color: #e8e3df;
    color: #735e59;
    text-align: center;
    padding: 10px 20px;
    overflow: hidden;
    height: 55px;
    position: relative;
    font-size: 14px;
    font-weight: bold;
    margin-bottom: 20px;
}

/* Aplica estilos de mensagem a SPANs e ANCHORs dentro do container */
.ad-bar-container .ad-bar-message,
.ad-bar-container .ad-bar-link {
    /* Usamos flexbox para centralizar o conteúdo (ícone + texto) */
    display: flex;
    align-items: center; /* Alinha verticalmente ícone e texto */
    justify-content: center; /* Centraliza horizontalmente o bloco */
    padding: 0px 10px;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 100%;
    opacity: 0;
    transition: opacity 0.5s ease-in-out;
    white-space: nowrap;
    /* Estilos para o link do WhatsApp */
    text-decoration: none; /* Remove sublinhado padrão do link */
    color: inherit; /* Garante que o link tenha a mesma cor do texto */
}

/* Garante que o link da mensagem ativa e as SPANs ativas apareçam */
.ad-bar-container .is-active {
    opacity: 1;
}

/* Estilo para os Ícones SVG */
.ad-bar-container svg {
    height: 20px;
    width: 20px;
    fill: currentColor;
    margin-right: 8px; /* Espaço entre o ícone e o texto */
    vertical-align: middle;
}

.ad-bar-container img {
    height: 20px;
    width: 20px;
    fill: currentColor;
    margin-right: 8px; /* Espaço entre o ícone e o texto */
    vertical-align: middle;
}

@media (max-width: 576px) {
    
    /* Reduz o tamanho da fonte em telas pequenas para caber mais texto */
    .ad-bar-container {
        font-size: 13px; 
        padding: 8px 5px; /* Reduz o padding vertical do container se necessário */
    }
    
    /* Garante que o conteúdo que está sendo exibido não toque as bordas */
    .ad-bar-container .ad-bar-message,
    .ad-bar-container .ad-bar-link {
        padding: 0 10px; /* Padding lateral de 10px para dar respiro */
    }
    
    /* Reduz o tamanho do ícone e o espaçamento para otimizar o espaço */
    .ad-bar-container svg {
        height: 16px;
        width: 16px;
        margin-right: 4px;
    }
}
</style>

<div class="ad-bar-container">
    
    <span class="ad-bar-message is-active">
        <svg viewBox="0 0 24 24"><path d="M20 7h-4V4c0-1.1-.9-2-2-2h-4c-1.1 0-2 .9-2 2v3H4c-1.1 0-2 .9-2 2v10h24v-10c0-1.1-.9-2-2-2zm-6 0h-4V4h4v3zm-4 14c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zm10 0c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zM21 16H3v-5h18v5z"/></svg>
        ENTREGA PARA TODO O BRASIL!
    </span>
    
    <span class="ad-bar-message">
        <svg viewBox="0 0 24 24"><path d="M20 4H4c-1.11 0-1.99.89-1.99 2L2 18c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V6c0-1.11-.89-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z"/></svg>
        PAGUE COM CARTÃO EM ATÉ 6X SEM JUROS
    </span>
    
    <span class="ad-bar-message">
        <img src="//acdn-us.mitiendanube.com/stores/004/916/830/themes/recife/2-img-155908607-1720639326-9e85023d21bee9fb258c774376ee3be31720639327-480-0.webp?3514067600">
        DESCONTOS DE 5% PARA PAGAMENTOS COM PIX
    </span>
    
    <a href="https://wa.me/5548991574943" target="_blank" class="ad-bar-link">
        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-whatsapp" viewBox="0 0 16 16">
  <path d="M13.601 2.326A7.85 7.85 0 0 0 7.994 0C3.627 0 .068 3.558.064 7.926c0 1.399.366 2.76 1.057 3.965L0 16l4.204-1.102a7.9 7.9 0 0 0 3.79.965h.004c4.368 0 7.926-3.558 7.93-7.93A7.9 7.9 0 0 0 13.6 2.326zM7.994 14.521a6.6 6.6 0 0 1-3.356-.92l-.24-.144-2.494.654.666-2.433-.156-.251a6.56 6.56 0 0 1-1.007-3.505c0-3.626 2.957-6.584 6.591-6.584a6.56 6.56 0 0 1 4.66 1.931 6.56 6.56 0 0 1 1.928 4.66c-.004 3.639-2.961 6.592-6.592 6.592m3.615-4.934c-.197-.099-1.17-.578-1.353-.646-.182-.065-.315-.099-.445.099-.133.197-.513.646-.627.775-.114.133-.232.148-.43.05-.197-.1-.836-.308-1.592-.985-.59-.525-.985-1.175-1.103-1.372-.114-.198-.011-.304.088-.403.087-.088.197-.232.296-.346.1-.114.133-.198.198-.33.065-.134.034-.248-.015-.347-.05-.099-.445-1.076-.612-1.47-.16-.389-.323-.335-.445-.34-.114-.007-.247-.007-.38-.007a.73.73 0 0 0-.529.247c-.182.198-.691.677-.691 1.654s.71 1.916.81 2.049c.098.133 1.394 2.132 3.383 2.992.47.205.84.326 1.129.418.475.152.904.129 1.246.08.38-.058 1.171-.48 1.338-.943.164-.464.164-.86.114-.943-.049-.084-.182-.133-.38-.232"/>
</svg>
        DÚVIDAS? ESTAMOS AQUI!!
    </a>
    
</div>

<script>
/* --------------------------------------
    JAVASCRIPT: Lógica de Rotação (Ajustada para incluir links)
-------------------------------------- */
document.addEventListener('DOMContentLoaded', function() {
    // Seleciona todas as mensagens e links que precisam de rotação
    const messages = document.querySelectorAll('.ad-bar-container .ad-bar-message, .ad-bar-container .ad-bar-link');
    let currentIndex = 0;
    const intervalTime = 4000; // 3000ms = 3 segundos

    // A primeira mensagem é sempre ativada no HTML, mas garantimos que as outras não estejam
    messages[0].classList.add('is-active');

    function showNextMessage() {
        // 1. Remove a classe 'is-active' da mensagem/link atual
        messages[currentIndex].classList.remove('is-active');

        // 2. Calcula o índice da próxima mensagem (volta para 0 se for a última)
        currentIndex = (currentIndex + 1) % messages.length;

        // 3. Adiciona a classe 'is-active' à próxima mensagem/link
        messages[currentIndex].classList.add('is-active');
    }

    // Inicia a rotação a cada 3 segundos
    setInterval(showNextMessage, intervalTime);
});
</script>