<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:fb="http://www.facebook.com/2008/fbml" xmlns:og="http://opengraphprotocol.org/schema/">
    <head>
        <link rel="preconnect" href="{{ store_resource_hints }}" />
        <link rel="dns-prefetch" href="{{ store_resource_hints }}" />
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>{{ page_title }}</title>
        <meta name="description" content="{{ page_description }}" />
        <link rel="preload" href="{{ 'css/style-critical.scss' | static_url }}" as="style" />
        <link rel="preload" href="{{ 'js/external-no-dependencies.js.tpl' | static_url }}" as="script" />
        
        {{ component('social-meta') }}

        {#/*============================================================================
            #CSS and fonts
        ==============================================================================*/#}

        {# Critical CSS needed to show first elements of store while CSS async is loading #}

        <style>
            {# Font families #}

            {% if params.preview %}

                {# If page is loaded from customization page on the admin, load all fonts #}

                @import url('https://fonts.googleapis.com/css?family=Montserrat:400,600|Muli:400,600|Lato:400,600|Nunito:400,600|Plus+Jakarta+Sans:400,600|Outfit:400,600|Sora:400,600|Lexend:400,600|Lexend+Exa:400,600|Red+Hat+Display:400,600|Manrope:400,600|Work+Sans:400,600|Inter:400,600|Public+Sans:400,600|Kanit:400,600|Braah+One:400,600|Karla:400,600|Roboto+Mono:400,600|Playfair+Display:400,600|Ultra|Marcellus|Fraunces:400,600|Literata:400,600|Zilla+Slab:400,600|Oooh+Baby|Handlee|Domine:400,600|Corben:400,600|Tenor+Sans|Poppins:400,600|Libre+Franklin:400,600');

            {% else %}

                {# If page is NOT loaded from customization only load saved fonts #}

                {# Get only the saved fonts on settings #}

                @import url('{{ [settings.font_headings, settings.font_rest] | google_fonts_url('400, 600') | raw  }}');

            {% endif %}

            {# General CSS Tokens #}

            {% include "static/css/style-tokens.tpl" %}
        </style>

        {# Critical CSS #}

        {{ 'css/style-critical.scss' | static_url | static_inline }}

        {# Load async styling not mandatory for first meaningfull paint #}

        <link rel="stylesheet" href="{{ 'css/style-async.scss' | static_url }}" media="print" onload="this.media='all'">

        {# Loads custom CSS added from Advanced Settings on the admin´s theme customization screen #}

        <style>
            {{ settings.css_code | raw }}
        </style>

        {#/*============================================================================
            #Javascript: Needed before HTML loads
        ==============================================================================*/#}

        {# Defines if async JS will be used by using script_tag(true) #}

        {% set async_js = true %}

        {# Defines the usage of jquery loaded below, if nojquery = true is deleted it will fallback to jquery 1.5 #}

        {% set nojquery = true %}

        {# Jquery async by adding script_tag(true) #}

        {{ '//ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js' | script_tag(true) }}

        {# Loads private Tienda Nube JS #}

        {% head_content %}

        {# Structured data to provide information for Google about the page content #}

        {{ component('structured-data') }}

    </head>
    <body class="body-password">

        {# Theme icons #}

        {% include "snipplets/svg/icons.tpl" %}

        {# Back to admin bar #}

        {{back_to_admin}}

        {# Page content #}

        <header class="head-main">
            <div class="container">
                <div class="row justify-content-md-center">
                    <div class="col-md-8 text-center">
                        <div class="my-3">
                            {{ component('logos/logo', {logo_img_classes: 'transition-soft', logo_text_classes: 'h3 m-0'}) }}
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="flex-grow-1 h-100 d-flex align-items-center">
            <div class="container py-4">
                <div class="row justify-content-center">
                    <div class="col-md-4">
                        <h2 class="mb-4 text-center">{{ message }}</h2>
                        {% embed "snipplets/forms/form.tpl" with{form_id: 'password-form', submit_text: 'Desbloquear' | translate, submit_custom_class: 'btn-block btn-big', form_custom_class: 'w-100' } %}
                            {% block form_body %}

                                {% embed "snipplets/forms/form-input.tpl" with{input_for: 'password', type_password: true, input_name: 'password', input_label_text: 'Contraseña de acceso' | translate, input_placeholder: 'ej.: tucontraseña' | translate } %}
                                    {% block input_form_alert %}
                                        {% if invalid_password == true %}
                                            <div class="alert alert-danger mt-3">{{ 'La contraseña es incorrecta.' | translate }}</div>
                                        {% endif %}
                                    {% endblock input_form_alert %}
                                {% endembed %}

                            {% endblock %}
                        {% endembed %}
                    </div>
                </div>
            </div>
        </div>


        {# Footer #}

        {% snipplet "footer/footer.tpl" %}

        {# Javascript needed to footer logos lazyload #}

        {{ 'js/external-no-dependencies.js.tpl' | static_url | script_tag }}

        {# Google survey JS for Tienda Nube Survey #}

        {% include "static/js/google-survey.js.tpl" %}

    </body>
</html>
