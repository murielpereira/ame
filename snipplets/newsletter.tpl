{% set newsletter_contact_error = contact.type == 'newsletter' and not contact.success %}

{% if settings.news_show %}
    <div class="newsletter-footer">
        <div class="js-newsletter newsletter container py-4 overflow-none">
            <div class="row align-items-center text-center text-md-left my-3 my-md-2">
                {% if settings.news_title %}
                    <div class="col-md mb-3 mb-md-0">
                        <div class="h1-md h2">{{ settings.news_title }}</div>
                    </div>
                {% endif %}
                {% if settings.news_text %}
                    <div class="col-md mb-3 mb-md-0">
                        <div class="font-small">{{ settings.news_text }}</div>
                    </div>
                {% endif %}
                <form class="col-md-6" method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');" data-store="newsletter-form">
                    <div class="newsletter-form input-append row no-gutters align-items-center">
                        <div class="col-md mb-3 mb-md-0">
                            {% embed "snipplets/forms/form-input.tpl" with{input_for: 'email', type_email: true, input_name: 'email', input_id: 'email', input_placeholder: 'Ingresá tu email...' | translate, input_group_custom_class: "mb-0", input_custom_class: '', input_aria_label: 'Email' | translate } %}
                            {% endembed %}
                        </div>
                        <div class="col-md-auto">
                            <div class="winnie-pooh" style="display: none;">
                                <label for="winnie-pooh-newsletter">{{ "No completar este campo" | translate }}</label>
                                <input id="winnie-pooh-newsletter" type="text" name="winnie-pooh"/>
                            </div>
                            <input type="hidden" name="name" value="{{ "Sin nombre" | translate }}" />
                            <input type="hidden" name="message" value="{{ "Pedido de inscripción a newsletter" | translate }}" />
                            <input type="hidden" name="type" value="newsletter" />
                            <input type="submit" name="contact" class="btn btn-link px-4" value="{{ "Enviar" | translate }}" />
                        </div>
                    </div>
                </form>
            </div>

            {% if contact and contact.type == 'newsletter' %}
                <div class="row justify-content-end">
                    <div class="col-md-6">
                        {% if contact.success %}
                            <div class="alert alert-success mt-2">{{ "¡Gracias por suscribirte! A partir de ahora vas a recibir nuestras novedades en tu email" | translate }}</div>
                        {% else %}
                            <div class="alert alert-danger mt-2">{{ "Necesitamos tu email para enviarte nuestras novedades." | translate }}</div>
                        {% endif %}
                    </div>
                </div>
            {% endif %}
        </div>
    </div>
{% endif %}