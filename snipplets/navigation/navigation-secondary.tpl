<ul class="list">
	{% for item in menus[settings.top_menu] %}
		<li class="secondary-menu-item">
			<a class="secondary-menu-link" href="{{ item.url }}" {% if item.url | is_external %}target="_blank"{% endif %}>{{ item.name }}</a>
		</li>
	{% endfor %}
</ul>
