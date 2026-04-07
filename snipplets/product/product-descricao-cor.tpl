<div id="campo_descricao_cor"></div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var fonteDescricaoCor = document.getElementById('descricao_cor');
        var destinoDescricaoCor = document.getElementById('campo_descricao_cor');

        if (destinoDescricaoCor) {
            if (fonteDescricaoCor && fonteDescricaoCor.innerHTML.trim() !== "") {
                destinoDescricaoCor.innerHTML = fonteDescricaoCor.innerHTML;
            } else {
                destinoDescricaoCor.remove();
            }
        }

        if (fonteDescricaoCor) {
            fonteDescricaoCor.remove();
        }
    });
</script>