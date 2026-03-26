{% for sn in ['instagram', 'facebook', 'youtube', 'tiktok', 'twitter', 'pinterest'] %}
    {% set sn_url = attribute(store,sn) %}
    {% if sn_url %}
        <a class="{% if header %}{% if not loop.last %}mr-2{% endif %}{% else %}social-icon{% endif %}" href="{{ sn_url }}" target="_blank" aria-label="{{ sn }} {{ store.name }}">
            {% if sn == "facebook" %}
                {% set social_network = sn ~ '-f' %}
            {% else %}
                {% set social_network = sn %}
            {% endif %}
            <svg class="icon-inline {% if not header %}icon-lg{% endif %}"><use xlink:href="#{{ social_network }}"/></svg>
        </a>
    {% endif %}
{% endfor %}
