<div id="campo_descricao_curta"></div>

<style>
    /* Oculta o conteúdo original instantaneamente para não dar pulo no rodapé */
    #descricao_curta { display: none !important; }
</style>

<script>
    // DOMContentLoaded atua antes da página ser visível para o cliente
    document.addEventListener('DOMContentLoaded', function() {
        var fonte = document.getElementById('descricao_curta');
        var destino = document.getElementById('campo_descricao_curta');

        if (fonte && destino) {
            if (fonte.innerHTML.trim() !== "") {
                destino.innerHTML = fonte.innerHTML;
            }
            // Removemos o original do código para limpar o DOM
            fonte.remove();
        }
    });
</script>