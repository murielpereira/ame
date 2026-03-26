<div id="campo_descricao_tamanho"></div>

<style>
#campo_descricao_tamanho {
    max-width: 860px;
    margin: 20px auto;
    padding: 15px 18px;
    background: #f7f3ef;
    border-radius: 12px;
    text-align: center;
}
#campo_descricao_tamanho p {
    font-size: 15px;
    color: #4d3f39;
    line-height: 1.6;
    margin: 0 0 8px 0;
    text-align: center;
}
</style>

<script>
    window.addEventListener('load', function() {
        // 1. Busca a origem (o que você escreveu no editor da Nuvemshop)
        var fonteDescricaoTamanho = document.getElementById('descricao_tamanho');
        
        // 2. Busca o destino (este tpl)
        var destinoDescricaoTamanho = document.getElementById('campo_descricao_tamanho');

        // 3. Verifica se existem e move o conteúdo
        if (fonteDescricaoTamanho && destinoDescricaoTamanho) {
            // Se o campo de origem não estiver vazio
            if (fonteDescricaoTamanho.innerHTML.trim() !== "") {
                destinoDescricaoTamanho.innerHTML = fonteDescricaoTamanho.innerHTML;
                
                // Esconde o original lá embaixo
                fonteDescricaoTamanho.style.display = 'none';
            } else {
                // Se estiver vazio, remove o fundo cinza do destino
                destinoDescricaoTamanho.style.display = 'none';
            }
        } else {
            // Se não encontrar o ID, não mostra nada
            if(destinoDescricaoTamanho) destinoDescricaoTamanho.style.display = 'none';
        }
    });
</script>