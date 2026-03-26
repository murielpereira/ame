<ul class="list-unstyled{% if header %} font-small{% endif %}">
    {% for language in languages %}
        <li class="{% if header %}{% if not loop.last %}mb-2 {% endif %}py-1{% else %}mb-4{% endif %}{% if language.active %} font-weight-bold{% endif %}">
            <a href="{{ language.url }}" class="d-inline-flex align-items-center">
                <img class="lazyload mr-2" src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ language.country | flag_url }}" alt="{{ language.name }}" />
                {{ language.country_name }}
            </a>
        </li>
    {% endfor %}
</ul>
