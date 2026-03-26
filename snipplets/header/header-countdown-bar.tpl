<div class="contador-regressivo-container" style="display: none;">
    <a class="contador-link" href="https://ameacessoriospet.com.br/cachorros1/kits1/?mpage=100" target="_blank">
        <div class="contador-mensagem">
            <p class="contador-mensagem-texto">ESQUENTA BLACK FRIDAY: KITS COM 20% OFF</p>
        </div>
            
        <div class="contador">
            <div id="countdown-container">
                <div class="time-block">
                    <span id="days" class="time-value">00</span>
                    <span class="time-label">dias</span>
                </div>
                <span class="separator">:</span>

                <div class="time-block">
                    <span id="hours" class="time-value">00</span>
                    <span class="time-label">horas</span>
                </div>
                <span class="separator">:</span>

                <div class="time-block">
                    <span id="minutes" class="time-value">00</span>
                    <span class="time-label">min</span>
                </div>
                <span class="separator">:</span>

                <div class="time-block">
                    <span id="seconds" class="time-value">00</span>
                    <span class="time-label">seg</span>
                </div>
            </div>
        </div>   
    </a>       
</div>

<script>
// --- Injeção Ultra-Segura (sem filtros 'default') ---
const rawEnabled = '{{ settings.COUNTDOWN_ENABLE }}';
const rawDate = '{{ settings.COUNTDOWN_DATE }}';
const rawMessage = '{{ settings.COUNTDOWN_MESSAGE }}';
const rawLink = '{{ settings.COUNTDOWN_LINK }}';

// --- JavaScript aplica os defaults ---
const countdownEnabled = rawEnabled || '0'; 
const countdownDateString = rawDate || 'Oct 31, 2026 23:59:59'; 
const countdownMessage = rawMessage || 'Super Oferta: Contagem Regressiva!';
const countdownLink = rawLink || '#';

const fullContainerEl = document.querySelector('.contador-regressivo-container');

// LOG para você conferir no console do navegador (F12)
console.log("Contador Status:", countdownEnabled);
console.log("Contador Data:", countdownDateString);
console.log("Contador Mensagem:", countdownMessage);

// --- Lógica Principal ---
if (countdownEnabled === '1' && fullContainerEl) {
    
    // 1. Atualiza o HTML estático com os valores corretos
    fullContainerEl.querySelector('.contador-link').href = countdownLink;
    fullContainerEl.querySelector('.contador-mensagem-texto').textContent = countdownMessage;
    
    // Tenta criar a data. new Date() é tolerante, mas o getTime() deve funcionar
    const finalDate = new Date(countdownDateString).getTime();

    // 2. Verifica se a data é válida E se a promoção AINDA NÃO EXPIROU
    const now = new Date().getTime();
    
    if (isNaN(finalDate) || finalDate <= now) {
        // Data inválida OU data expirada, o contador fica oculto.
        console.error("Contador inválido ou expirado. Data lida:", countdownDateString);
    } else {
        // Se ativo e válido, inicia o contador
        
        function formatTime(time) { return time < 10 ? `0${time}` : time; }
        const daysEl = document.getElementById("days");
        const hoursEl = document.getElementById("hours");
        const minutesEl = document.getElementById("minutes");
        const secondsEl = document.getElementById("seconds");

        const updateCountdown = function() {
            const now = new Date().getTime();
            const distance = finalDate - now;

            if (distance < 0) {
                clearInterval(x);
                if (fullContainerEl) fullContainerEl.style.display = 'none'; // Oculta ao expirar
                return; 
            }
            const days = Math.floor(distance / (1000 * 60 * 60 * 24));
            const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);
            daysEl.innerHTML = formatTime(days);
            hoursEl.innerHTML = formatTime(hours);
            minutesEl.innerHTML = formatTime(minutes);
            secondsEl.innerHTML = formatTime(seconds);
        };
        updateCountdown(); 
        const x = setInterval(updateCountdown, 1000);
        
        // Exibe o contador
        fullContainerEl.style.display = ''; 
    }
}
// Se 'countdownEnabled' não for '1', o container permanece oculto
</script>