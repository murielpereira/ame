<div id="campo-seguranca">
    <template>
        {{ product.description }}
    </template>
    <script>
        (function(){
            var scripts = document.getElementsByTagName('script');
            var currentScript = scripts[scripts.length - 1];
            var temp = currentScript.previousElementSibling;
            var campo = currentScript.parentElement;

            if (temp && temp.tagName === 'TEMPLATE' && campo) {
                var target = temp.content.querySelector('#seguranca');
                if (target && target.innerHTML.trim() !== "") {
                    campo.innerHTML = target.innerHTML;
                } else {
                    campo.style.display = 'none';
                    temp.remove();
                }
            }
        })();
    </script>
</div>

<style>
    /* Oculta o conteúdo original instantaneamente para não dar pulo no rodapé */
    #seguranca { display: none !important; }
</style>