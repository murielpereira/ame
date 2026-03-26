<div id="campo_descricao_cor"></div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var fonteDescricaoCor = document.getElementById('descricao_cor');
        var destinoDescricaoCor = document.getElementById('campo_descricao_cor');

        if (fonteDescricaoCor && destinoDescricaoCor) {
            if (fonteDescricaoCor.innerHTML.trim() !== "") {
                destinoDescricaoCor.innerHTML = fonteDescricaoCor.innerHTML;
            } else {
                destinoDescricaoCor.style.display = 'none';
            }
            fonteDescricaoCor.remove();
        }
    });
</script>