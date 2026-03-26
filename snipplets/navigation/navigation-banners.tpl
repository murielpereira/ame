{% if desktop %}
	{% set img_setting_name = 'menu_banner_desktop.jpg' %}
	{% set img_link = settings.menu_banner_desktop_url %}
{% else %}
	{% set img_setting_name = 'menu_banner_mobile.jpg' %}
	{% set img_link = settings.menu_banner_mobile_url %}
{% endif %}

{% if img_setting_name | has_custom_image %}
	{% if img_link %}
		<a href="{{ img_link }}">
	{% endif %}
		{% if desktop %}
			<div class="d-flex justify-content-end align-items-start">
		{% endif %}
				<img src="{{ 'images/empty-placeholder.png' | static_url }}" data-srcset='{{ img_setting_name | static_url | settings_image_url('large') }} 480w, {{ img_setting_name | static_url | settings_image_url('huge') }} 640w, {{ img_setting_name | static_url | settings_image_url('original') }} 1024w' class='lazyload navigation-banner'/>
		{% if desktop %}
			</div>
		{% endif %}
	{% if img_link %}
		</a>
	{% endif %}
{% endif %}
