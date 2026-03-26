<div id="campo-seguranca"></div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var fonteSeguranca = document.getElementById('seguranca');
        var destinoSeguranca = document.getElementById('campo-seguranca');

        if (fonteSeguranca && destinoSeguranca) {
            if (fonteSeguranca.innerHTML.trim() !== "") {
                destinoSeguranca.innerHTML = fonteSeguranca.innerHTML;
            } else {
                destinoSeguranca.style.display = 'none';
            }
            fonteSeguranca.remove();
        }
    });
</script>