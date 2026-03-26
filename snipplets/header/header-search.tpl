{% set input_class = search_modal ? 'background-secondary' : '' %}
{% set submit_class = search_modal ? 'mr-2' : '' %}
{% set suggestions_container_class = search_modal ? '' : 'card mt-2' %}

{% if search_modal %}
    <a href="#" class="js-modal-close js-fullscreen-modal-close search-btn search-close-btn">
        <svg class="icon-inline font-big svg-icon-text icon-flip-horizontal {% if not settings.search_big_desktop %}d-md-none{% endif %}"><use xlink:href="#chevron"/></svg>
        <svg class="icon-inline icon-lg svg-icon-text d-none d-md-block"><use xlink:href="#times"/></svg>
    </a>
{% endif %}

{{ component('search/search-form', {
    placeholder_text: 'Buscar' | translate,
    form_classes: { 
        input_group: 'm-0', 
        input: input_class, 
        submit: 'svg-icon-mask ' ~ submit_class, 
        delete_content: 'svg-icon-mask',  
        search_suggestions_container: suggestions_container_class}
    }) 
}}