{% set search_page_filters = template == 'search' and search_filter %}
{% set category_page = template == 'category' %}
{% set show_filters = products or has_filters_available %}
{% if show_filters and (category_page or search_page_filters) %}
	<section class="js-category-controls category-controls visible-when-content-ready {% if not settings.filters_desktop_modal %}d-md-none{% endif %}">
		<div class="container category-controls-container">
			<div class="category-controls-row row">
				{% if products %}
					<div class="col col-md-auto category-control-item">
						<a href="#" class="js-modal-open d-block font-small font-md-body px-md-0 py-md-2" data-toggle="#sort-by">
							<div class="d-flex justify-content-center align-items-center">
								<svg class="icon-inline icon-lg mr-2"><use xlink:href="#sort"/></svg>
								{{ 'Ordenar' | t }}
							</div>
						</a>
						{% embed "snipplets/modal.tpl" with{modal_id: 'sort-by', modal_class: 'bottom modal-centered modal-bottom-sheet modal-right-md', modal_position: 'bottom', modal_position_desktop: right, modal_width: 'docked-md', modal_transition: 'slide', modal_header_title: true} %}
							{% block modal_head %}
								{{'Ordenar por' | translate }}
							{% endblock %}
							{% block modal_body %}
								{% include 'snipplets/grid/sort-by.tpl' with { list: "true"} %}
								<div class="js-sorting-overlay filters-overlay" style="display: none;">
									<div class="filters-updating-message">
										<span class="h5 mr-2">{{ 'Ordenando productos' | translate }}</span>
										<span>
											<svg class="icon-inline h5 icon-spin svg-icon-text"><use xlink:href="#spinner-third"/></svg>
										</span>
									</div>
								</div>
							{% endblock %}
						{% endembed %}
					</div>
				{% endif %}
				{% if has_filters_available %}
					<div class="visible-when-content-ready col col-md-auto pl-md-2 category-control-item">
						<a href="#" class="js-modal-open d-block font-small font-md-body px-md-0 py-md-2" data-toggle="#nav-filters" data-component="filter-button">
							<div class="d-flex justify-content-center align-items-center">
								<svg class="icon-inline icon-lg mr-2"><use xlink:href="#filter"/></svg>
								{{ 'Filtrar' | t }}
								{% if has_applied_filters %}
									(<span class="js-filters-total-badge"></span>)
								{% endif %}
							</div>
						</a>
						{% embed "snipplets/modal.tpl" with{modal_id: 'nav-filters', modal_class: 'filters modal-docked-small', modal_body_class: 'h-100 p-0', modal_position: 'right', modal_position_desktop: right, modal_transition: 'slide', modal_header_title: true, modal_width: 'docked-md' } %}
							{% block modal_head %}
								{{'Filtrar ' | translate }}
							{% endblock %}
							{% block modal_body %}
								{% if has_filters_available %}
									{{ component(
										'filters/remove-filters',{
											container_classes: {
												filters_container: "px-3 my-2",
											},
											filter_classes: {
												applied_filters_label: "font-body font-weight-bold mb-2",
												remove: "chip",
												remove_icon: "js-remove-filter-chip chip-remove-icon",
												remove_all: "btn-link d-inline-block mt-1 mt-md-0 font-small",
											},
											remove_filter_svg_id: 'times',
										})
									}}

									{{ component(
										'filters/filters',{
											accordion: true,
											parent_category_link: false,
											applied_filters_badge: true,
											container_classes: {
												filters_container: "visible-when-content-ready",
											},
											accordion_classes: {
												title_container: "row no-gutters align-items-center",
												title_col: "col my-1 pr-3 d-flex align-items-center",
												title: "h6 font-body font-weight-bold mb-0",
												actions_col: "col-auto my-1",
												title_icon: "icon-inline svg-icon-text font-big mr-1"
											},
											filter_classes: {
												list: "list-unstyled my-3",
												list_item: "mb-2",
												list_link: "font-small",
												badge: "h6 font-small ml-1",
												show_more_link: "d-inline-block btn-link font-small mt-1",
												checkbox_last: "m-0",
												price_group: 'price-filter-container filter-accordion',
												price_title: 'h6 font-weight-bold mb-4',
												price_submit: 'btn btn-default d-inline-block',
												applying_feedback_message: 'h5 mr-2',
												applying_feedback_icon: 'icon-inline h5 icon-spin svg-icon-text'
											},
											accordion_show_svg_id: 'plus',
											accordion_hide_svg_id: 'minus',
											applying_feedback_svg_id: 'spinner-third'
										})
									}}

								{% endif %}
							{% endblock %}
						{% endembed %}
					</div>
				{% endif %}
			</div>
		</div>
	</section>
	<section class="js-category-controls-prev category-controls-sticky-detector"></section>
{% endif %}