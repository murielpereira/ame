{% set megamenu = megamenu | default(false) %}
{% set hamburger = hamburger | default(false) %}
{% set subitem = subitem | default(false) %}

{% set has_featured_link = settings.featured_link_url is not empty %}
{% if has_featured_link %}
	{% set featured_link_url = settings.featured_link_url | split('://') | last | split('/') | slice(1) | join('/') | trim('/') %}
{% endif %}

{% for item in navigation %}
	
	{% if has_featured_link %}
		{% set link_url = item.url | split('://') | last | split('/') | slice(1) | join('/') | trim('/') %}
		{% set featured_link_classes = link_url == featured_link_url ? 'nav-list-link-featured font-weight-bold' %}
	{% endif %}

	{% if item.subitems %}
		<li class="{% if megamenu %}js-desktop-nav-item js-item-subitems-desktop nav-item-desktop {% if not subitem %}js-nav-main-item nav-dropdown nav-main-item {% endif %}{% endif %} nav-item item-with-subitems" data-component="menu.item">
			{% if megamenu %}
			<div class="nav-item-container">
			{% endif %}
				<a class="{% if hamburger %}js-toggle-menu-panel align-items-center{% endif %} nav-list-link position-relative {{ featured_link_classes }} {{ item.current ? 'selected' : '' }}" href="{% if megamenu and item.url %}{{ item.url }}{% else %}#{% endif %}">{{ item.name }}
					{% if hamburger %}
						<span class="nav-list-arrow ml-1">
							<svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#arrow"/></svg>
						</span>
					{% endif %}
				</a>
			{% if megamenu %}
			</div>
			{% endif %}
			{% if megamenu and not subitem %}
				<div class="js-desktop-dropdown nav-dropdown-content desktop-dropdown">
					<div class="container desktop-dropdown-container">
			{% endif %}
						<ul class="{% if megamenu %}{% if not subitem %}desktop-list-subitems{% endif %} {% else %}js-menu-panel nav-list-panel nav-list-panel-right {% endif %} list-subitems" {% if hamburger %}style="display:none;"{% endif %}>
							{% if hamburger %}
								<div class="modal-header">
									<div class="row no-gutters">
										<div class="col">
											<a class="js-toggle-menu-back" href="#">
												<div class="row no-gutters align-items-center">
													<div class="col-auto">
														<span class="modal-back pr-2 mr-1">
															<svg class="icon-inline icon-flip-horizontal svg-icon-text"><use xlink:href="#chevron"/></svg>
														</span>
													</div>
													<div class="col pl-0 my-3">
														{{ item.name }}
													</div>
												</div>
											</a>
										</div>
										<div class="col-auto">
											<a class="js-toggle-menu-close js-modal-close modal-close">
												<svg class="icon-inline  modal-close-icon"><use xlink:href="#times"/></svg>
											</a>
										</div>
									</div>
								</div>
								<div class="modal-body p-0">
									{% if item.isCategory %}
										<li class="nav-item py-1">
											<a class="nav-list-link position-relative font-small py-3 {{ item.current ? 'selected' : '' }}" href="{{ item.url }}">
												{% if item.isRootCategory %}
													{{ 'Ver todos los productos' | translate }}
												{% else %}
													{{ 'Ver todo en' | translate }} {{ item.name }}
												{% endif %}
											</a>
										</li>
									{% endif %}
							{% endif %}

							{% set hamburger_val = false %}
							{% if hamburger %}
								{% set hamburger_val = true %}
							{% endif %}
							{% include 'snipplets/navigation/navigation-nav-list.tpl' with { 'navigation' : item.subitems, 'subitem' : true, 'hamburger' : hamburger_val  } %}
							
							{% if hamburger %}
								</div>
							{% endif %}
						</ul>
			{% if megamenu and not subitem %}
					{% if megamenu %}
						{% include 'snipplets/navigation/navigation-banners.tpl' with { 'desktop' : true } %}
					{% endif %}
					</div>
				</div>
			{% endif %}
		</li>
	{% else %}
		<li class="js-desktop-nav-item {% if megamenu %}{% if not subitem %}js-nav-main-item nav-main-item{% endif %} nav-item-desktop{% endif %} nav-item" data-component="menu.item">
			<a class="nav-list-link {{ featured_link_classes }} {{ item.current ? 'selected' : '' }}" href="{% if item.url %}{{ item.url | setting_url }}{% else %}#{% endif %}">{{ item.name }}</a>
		</li>
	{% endif %}
{% endfor %}