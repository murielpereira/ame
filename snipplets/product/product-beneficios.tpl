<div id="exibir_beneficios_rapidos"></div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        var fonteBeneficios = document.getElementById('beneficios_rapidos');
        var destinoBeneficios = document.getElementById('exibir_beneficios_rapidos');

        if (fonteBeneficios && destinoBeneficios) {
            if (fonteBeneficios.innerHTML.trim() !== "") {
                destinoBeneficios.innerHTML = fonteBeneficios.innerHTML;
            } else {
                destinoBeneficios.style.display = 'none';
            }
            fonteBeneficios.remove();
        }
    });
</script>