{% set banner_services_icon_classes = 'icon-inline h2 align-item-middle svg-icon-text' %}

<div class="swiper-slide col-auto w-md-auto mw-md-25 p-0">
	<div class="row no-gutters">
		<div class="col-auto">
			{% set help_icon_name = help_item_1 ? 'truck' : help_item_2 ? 'credit-card' : help_item_3 ? 'promotions' : 'returns' %}
			<svg class="{{ banner_services_icon_classes }}"><use xlink:href="#{{ help_icon_name }}"/></svg>
		</div>
		<div class="col pl-3">
			<div class="align-item-middle">
				<h3 class="h6 font-weight-bold mb-1">
					{% if help_item_1 %}
						{{ 'Medios de envío' | translate }}
					{% elseif help_item_2 %}
						{{ 'Medios de pago' | translate }}
					{% elseif help_item_3 %}
						{{ 'Promociones' | translate }}
					{% elseif help_item_4 %}
						{{ 'Cambios y devoluciones' | translate }}
					{% endif %}
				</h3>
			</div>
			
		</div>
	</div>
</div>