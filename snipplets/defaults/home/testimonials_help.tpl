<section class="section-home section-testimonials-home position-relative overflow-none mt-3" data-store="home-testimonials">
	<h2 class="h3 mb-4 text-center">{{ 'Testimonios' | translate }}</h2>
	<div class="row">
		<div class="col-12 p-0 px-md-3">
			<div class="js-swiper-testimonials-demo swiper-testimonials swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide p-0 text-center">
						<div class="position-relative mb-3">
							<svg class="icon-inline icon-3x svg-icon-text opacity-50"><use xlink:href="#user"/></svg>
						</div>
						<h3 class="h6 mb-2">{{ 'Testimonio' | translate }}</h3>
						<p class="font-small mb-2">{{ 'Descripción del testimonio' | translate }}</p>
					</div>
					<div class="swiper-slide p-0 text-center">
						<div class="position-relative mb-3">
							<svg class="icon-inline icon-3x svg-icon-text opacity-50"><use xlink:href="#user"/></svg>
						</div>
						<h3 class="h6 mb-2">{{ 'Testimonio' | translate }}</h3>
						<p class="font-small mb-2">{{ 'Descripción del testimonio' | translate }}</p>
					</div>
					<div class="swiper-slide p-0 text-center">
						<div class="position-relative mb-3">
							<svg class="icon-inline icon-3x svg-icon-text opacity-50"><use xlink:href="#user"/></svg>
						</div>
						<h3 class="h6 mb-2">{{ 'Testimonio' | translate }}</h3>
						<p class="font-small mb-2">{{ 'Descripción del testimonio' | translate }}</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="placeholder-overlay transition-soft">
		<div class="placeholder-info p-2">
			<svg class="icon-inline icon-2x"><use xlink:href="#edit"/></svg>
			<div class="placeholder-description font-small-xs my-2">
				{{ "Podés mostrar testimonios de tus clientes desde" | translate }} </br><strong>"{{ "Testimonios" | translate }}"</strong>
			</div>
			{% if not params.preview %}
				<a href="{{ admin_link }}#instatheme=pagina-de-inicio" class="btn-primary btn btn-small placeholder-button">{{ "Editar" | translate }}</a>
			{% endif %}
		</div>
	</div>
</section>