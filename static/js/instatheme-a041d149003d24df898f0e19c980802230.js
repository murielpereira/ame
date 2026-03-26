window.tiendaNubeInstaTheme = (function(jQueryNuvem) {
	return {
		waitFor: function() {
			return [];
		},
		placeholders: function() {
			return [
				{
					placeholder: '.js-home-slider-placeholder',
					content: '.js-home-slider-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
				{
					placeholder: '.js-category-banner-placeholder',
					content: '.js-category-banner-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
				{
					placeholder: '.js-promotional-banner-placeholder',
					content: '.js-promotional-banner-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
				{
					placeholder: '.js-news-banner-placeholder',
					content: '.js-news-banner-top',
					contentReady: function() {
						return $(this).find('img').length > 0;
					},
				},
			];
		},
		handlers: function(instaElements) {
			const handlers = {
				logo: new instaElements.Logo({
					$storeName: jQueryNuvem('#no-logo'),
					$logo: jQueryNuvem('#logo')
				}),
				// ----- Section order -----
				home_order_position: new instaElements.Sections({
					container: '.js-home-sections-container',
					data_store: {
						'slider': 'home-slider',
						'main_categories': 'home-categories-featured',
						'products': 'home-products-featured',
						'welcome': 'home-welcome-message',
						'institutional': 'home-institutional-message',
						'informatives': 'banner-services',
						'categories': 'home-banner-categories',
						'promotional': 'home-banner-promotional',
						'news_banners': 'home-banner-news',
						'new': 'home-products-new',
						'video': 'home-video',
						'sale': 'home-products-sale',
						'promotion': 'home-products-promotion',
						'best_seller': 'home-products-best-seller',
						'instafeed': 'home-instagram-feed',
						'main_product': 'home-product-main',
						'brands': 'home-brands',
						'testimonials': 'home-testimonials',
					}
				}),
			};

			// ----------------------------------- Highlighted Products -----------------------------------

			// Same logic applies to all 5 types of highlighted products

			['featured', 'new', 'sale', 'promotion', 'best_seller'].forEach(setting => {
				
				let settingSelector = setting;
				if (setting === 'best_seller') {
					settingSelector = 'best-seller';
				}
				const $productContainer = $(`.js-products-${settingSelector}-container`);
				const $productContainerCol = $(`.js-products-${settingSelector}-col`);
				const $productGrid = $(`.js-products-${settingSelector}-grid`);

				const productSwiper = 
					setting == 'featured' ? 'productsFeaturedSwiper' : 
					setting == 'new' ? 'productsNewSwiper' : 
					setting == 'sale' ? 'productsSaleSwiper' :
					setting == 'promotion' ? 'productsPromotionSwiper' :
					setting == 'best_seller' ? 'productsBestSellerSwiper' :
					null;

				const $productItem = $productGrid.find(`.js-item-product`);

				// Updates title text
				handlers[`${setting}_products_title`] = new instaElements.Text({
					element: `.js-products-${settingSelector}-title`,
					show: function(){
						$(this).show();
					},
					hide: function(){
						$(this).hide();
					},
				})

				// Updates quantity products desktop
				handlers[`${setting}_products_desktop`] = new instaElements.Lambda(function(desktopProductQuantity){
					if (window.innerWidth > 768) {
						const productFormat = $productGrid.attr('data-desktop-format');
						$productItem.removeClass('col-md-2 col-md-2-4 col-md-3');
						$productGrid.attr('data-desktop-columns', desktopProductQuantity);
						if (desktopProductQuantity == 6) {
							$productItem.addClass('col-md-2');
						} else if (desktopProductQuantity == 5) {
							$productItem.addClass('col-md-2-4');
						} else if (desktopProductQuantity == 4) {
							$productItem.addClass('col-md-3');
						}
						if (productFormat == 'slider') {
							window[productSwiper].params.slidesPerView = desktopProductQuantity;
							window[productSwiper].update();
						}
					}
				});

				// Updates quantity products mobile
				handlers[`${setting}_products_mobile`] = new instaElements.Lambda(function(mobileProductQuantity){
					if (window.innerWidth < 768) {
						$productItem.removeClass('col-6 col-12');
						const productFormat = $productGrid.attr('data-mobile-format');
						const mobileProductSliderQuantity = mobileProductQuantity == '2' ? '2.25' : '1.15';
						$productGrid.attr('data-mobile-columns', mobileProductQuantity);
						$productGrid.attr('data-mobile-slider-columns', mobileProductSliderQuantity);
						if (mobileProductQuantity == 1) {
							$productItem.addClass('col-12');
						} else if (mobileProductQuantity == 2) {
							$productItem.addClass('col-6');
						}
						if (productFormat == 'slider') {
							window[productSwiper].params.slidesPerView = mobileProductSliderQuantity;
							window[productSwiper].update();
						}
					}
				});

				// Initialize swiper function
				function initSwiperElements() {
					const desktopProductQuantity = $productGrid.attr('data-desktop-columns');
					const mobileProductQuantity = $productGrid.attr('data-mobile-slider-columns');

					// Reset swiper before modifying DOM
					resetSwiperElements();

					// Wrap everything inside a swiper container

					$productGrid.addClass('swiper-wrapper swiper-products-slider flex-nowrap ml-md-0').removeClass("flex-wrap flex-md-wrap");

					$productGrid.wrapAll(`<div class="js-swiper-${settingSelector} swiper-container"></div>`);

					// Wrap each product into a slide
					$productItem.addClass("js-item-slide swiper-slide");

					const $swiperContainer = $(`.js-swiper-${settingSelector}`);

					$productContainerCol.addClass("pr-0 pr-md-3");

					if (window.innerWidth > 768) {
						// Add previous and next controls
						$swiperContainer.after(`
							<div class="js-swiper-${settingSelector}-prev swiper-button-prev swiper-button-outside d-none d-md-block svg-icon-text">
								<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
							</div>
							<div class="js-swiper-${settingSelector}-next swiper-button-next swiper-button-outside d-none d-md-block svg-icon-text">
								<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
							</div>
						`);
					}

					// Initialize swiper
					createSwiper(`.js-swiper-${settingSelector}`, {
						lazy: true,
						watchOverflow: true,
						centerInsufficientSlides: true,
						threshold: 5,
						watchSlideProgress: true,
						watchSlidesVisibility: true,
						slideVisibleClass: 'js-swiper-slide-visible',
						spaceBetween: 15,
						loop: $productItem.length > 4,
						navigation: {
							nextEl: `.js-swiper-${settingSelector}-next`,
							prevEl: `.js-swiper-${settingSelector}-prev`
						},
						slidesPerView: mobileProductQuantity,
						breakpoints: {
							768: {
								slidesPerView: desktopProductQuantity,
							}
						},
					},
					function(swiperInstance) {
						window[productSwiper] = swiperInstance;
					});

				}

				// Reset swiper function
				function resetSwiperElements() {

					const $swiperContainer = $(`.js-swiper-${settingSelector}`);
					
					if($swiperContainer.length){

						const desktopProductQuantity = $productGrid.attr('data-desktop-columns');
						const mobileProductQuantity = $productGrid.attr('data-mobile-columns');

						// Remove duplicate slides and slider controls
						$productContainer.find(`.js-swiper-${settingSelector}-prev`).remove();
						$productContainer.find(`.js-swiper-${settingSelector}-next`).remove();
						$productGrid.find('.swiper-slide-duplicate').remove();
						$productContainerCol.removeClass("pr-0 pr-md-3");

						// Undo all slider wrappers and restore original classes
						$productGrid.unwrap();
						$productGrid.removeClass("swiper-wrapper swiper-mobile-only swiper-desktop-only flex-nowrap flex-md-nowrap swiper-products-slider ml-md-0").addClass("flex-wrap").removeAttr('style');
						$productItem.removeClass('js-item-slide js-swiper-slide-visible swiper-slide-active swiper-slide').removeAttr('style');

						if (desktopProductQuantity == 6) {
							$productItem.addClass('col-md-2');
						} else if (desktopProductQuantity == 5) {
							$productItem.addClass('col-md-2-4');
						} else if (desktopProductQuantity == 4) {
							$productItem.addClass('col-md-3');
						}

						if (mobileProductQuantity == 1) {
							$productItem.addClass('col-12');
						} else if (mobileProductQuantity == 2) {
							$productItem.addClass('col-6');
						}
					}
				}

				// Toggle grid and slider mobile view
				handlers[`${setting}_products_format_mobile`] = new instaElements.Lambda(function(format){
					const toSlider = format == "slider";

					const mobileFormat = $productGrid.attr('data-mobile-format');
					const desktopFormat = $productGrid.attr('data-desktop-format');

					const desktopColumns = $productGrid.attr('data-desktop-columns');
					const mobileColumns = $productGrid.attr('data-slider-columns');
					
					if ($productGrid.attr('data-mobile-format') == format) {
						// Nothing to do
						return;
					}

					// From grid to slider
					if (toSlider) {
						$productGrid.attr('data-mobile-format', 'slider');

						// Convert grid to slider if it's not yet
						if (window.innerWidth < 768) {
							initSwiperElements();
						}

					// From slider to grid
					} else {
						$productGrid.attr('data-mobile-format', 'grid');
						if (window.innerWidth < 768) {
							resetSwiperElements();
							$productGrid.removeClass("swiper-products-slider ml-md-0");
						}
					}

					// Persist new format in data attribute
					$productGrid.attr('data-mobile-format', format);
				});

				// Toggle grid and slider desktop view
				handlers[`${setting}_products_format_desktop`] = new instaElements.Lambda(function(format){

					const toSlider = format == "slider";

					if ($productGrid.attr('data-desktop-format') == format) {
						// Nothing to do
						return;
					}

					// From grid to slider
					if (toSlider) {

						$productGrid.attr('data-desktop-format', 'slider');

						// Convert grid to slider if it's not yet
						if (window.innerWidth > 768) {
							initSwiperElements();
						}

					// From slider to grid
					} else {
						$productGrid.attr('data-desktop-format', 'grid');

						if (window.innerWidth > 768) {
							resetSwiperElements();
						}
					}

					// Persist new format in data attribute
					$productGrid.attr('data-desktop-format', format);
				});

				// Updates section colors
				handlers[`${setting}_product_colors`] = new instaElements.Lambda(function(sectionColor){
					const $container = $(`.js-section-products-${settingSelector}`);
					if (sectionColor) {
						$container.addClass(`section-${settingSelector}-products-home-colors section-home-color`);
					} else {
						$container.removeClass(`section-${settingSelector}-products-home-colors section-home-color`);
					}
				});
			});

			// ----------------------------------- Slider -----------------------------------

			// Build the html for a slide given the data from the settings editor
			function buildHomeSlideDom(aSlide, alignClasses, imageClasses) {
				return '<div class="swiper-slide slide-container swiper-' + aSlide.color + '">' +
							(aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
								'<div class="slider-slide">' +
									'<img src="' + aSlide.src + '" class="js-slider-image slider-image ' + imageClasses + '"/>' +
									'<div class="js-swiper-text swiper-text ' + alignClasses + ' swiper-text-' + aSlide.color + '">' +
										(aSlide.description ? '<p class="mb-3">' + aSlide.description + '</p>' : '' ) +
										(aSlide.title ? '<div class="h1-huge mb-3">' + aSlide.title + '</div>' : '' ) +
										(aSlide.button && aSlide.link ? '<div class="btn btn-default btn-small d-inline-block">' + aSlide.button + '</div>' : '' ) +
									'</div>' +
								'</div>' +
							(aSlide.link ? '</a>' : '' ) +
						'</div>'
			}

			// Update slider align
			handlers.slider_align = new instaElements.Lambda(function(sliderAlign){
				const $swiperText = $('.js-home-slider-section').find('.js-swiper-text');
				const $homeSlider = $('.js-home-slider, .js-home-slider-mobile');

				if (sliderAlign == 'left') {
					$homeSlider.attr('data-align', 'left');
					$swiperText.removeClass('swiper-text-centered');
				} else {
					$homeSlider.attr('data-align', 'center');
					$swiperText.addClass('swiper-text-centered');
				}
			});

			// Update slider animation
			handlers.slider_animation = new instaElements.Lambda(function(sliderAnimation){
				const $swiperText = $('.js-home-slider-section').find('.js-slider-image');
				const $homeSlider = $('.js-home-slider, .js-home-slider-mobile');

				if (sliderAnimation) {
					$homeSlider.attr('data-animation', 'true');
					$swiperText.addClass('slider-image-animation');
				} else {
					$homeSlider.attr('data-animation', 'false');
					$swiperText.removeClass('slider-image-animation');
				}
			});

			// Update main slider
			handlers.slider = new instaElements.Lambda(function(slides){
				if (!window.homeSwiper) {
					return;
				}

				// Update align classes
				const sliderAlign = $('.js-home-slider').attr('data-align');
				const alignClasses = sliderAlign == 'center' ? 'swiper-text-centered' : '';

				// Update animation classes
				const sliderAnimation = $('.js-home-slider').attr('data-animation');
				const imageClasses = sliderAnimation == 'true' ? 'slider-image-animation' : '';

				window.homeSwiper.removeAllSlides();
				slides.forEach(function(aSlide){
					window.homeSwiper.appendSlide(buildHomeSlideDom(aSlide, alignClasses, imageClasses));
				});
				window.homeSwiper.update();
			});

			// Update mobile slider
			handlers.slider_mobile = new instaElements.Lambda(function(slides){
				// This slider is not included in the html if `toggle_slider_mobile` is not set.
				// The second condition could be removed if live preview for this checkbox is implemented but changing the viewport size forces a refresh, so it's not really necessary.
				if (!window.homeMobileSwiper || !window.homeMobileSwiper.slides) {
					return;
				}

				// Update align classes
				const sliderAlign = $('.js-home-slider-mobile').attr('data-align');
				const alignClasses = sliderAlign == 'center' ? 'swiper-text-centered' : '';

				// Update animation classes
				const sliderAnimation = $('.js-home-slider-mobile').attr('data-animation');
				const imageClasses = sliderAnimation == 'true' ? 'slider-image-animation' : '';

				window.homeMobileSwiper.removeAllSlides();
				slides.forEach(function(aSlide){
					window.homeMobileSwiper.appendSlide(buildHomeSlideDom(aSlide, alignClasses, imageClasses));
				});
				window.homeMobileSwiper.update();
			});

			// Update slider full
			handlers.slider_full = new instaElements.Lambda(function(sliderFull){
				const $mainSection = $('.js-main-slider-section');
				const $section = $('.js-home-slider-section');
				const $container = $('.js-home-slider-container');

				if (sliderFull) {
					$mainSection.removeClass('section-home');
					$container.removeClass('container').addClass('container-fluid p-0');
					if ($container.length == 0) {
						$section.removeClass('container');
					}

					// Updates slider width to avoids swipes inconsistency
					window.homeSwiper.params.observer = true;
					window.homeSwiper.update();

				} else {
					$mainSection.addClass('section-home');
					$container.removeClass('container-fluid p-0').addClass('container');
					if ($container.length == 0) {
						$section.addClass('container');
					}

					// Updates slider width to avoids swipes inconsistency
					window.homeSwiper.params.observer = true;
					window.homeSwiper.update();
				}

			});

			// ----------------------------------- Main Banners -----------------------------------

			// Build the html for a slide given the data from the settings editor
			function buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses) {
				return '<div class="js-banner col-grid ' + bannerClasses + ' ' + columnClasses + '">' +
						'<div class="js-textbanner textbanner ' + textBannerClasses + '">' +
							(aSlide.link ? '<a href="' + aSlide.link + '">' : '' ) +
								'<div class="js-textbanner-image-container textbanner-image overflow-none ' + imageContainerClasses + '">' +
									'<img src="' + aSlide.src + '" class="js-textbanner-image textbanner-image-effect ' + imageClasses + '">' +
								'</div>' +
								(aSlide.title || aSlide.description || aSlide.button ? '<div class="js-textbanner-text textbanner-text ' + textClasses + '">' : '') +
									(aSlide.title ? '<div class="h2 my-2">' + aSlide.title + '</div>' : '' ) +
									(aSlide.description ? '<div class="textbanner-paragraph font-small font-md-body">' + aSlide.description + '</div>' : '' ) +
									(aSlide.button && aSlide.link ? '<div class="btn btn-primary btn-small mt-1 mt-md-2">' + aSlide.button + '</div>' : '' ) +
								(aSlide.title || aSlide.description || aSlide.button ? '</div>' : '') +
							(aSlide.link ? '</a>' : '' ) +
						'</div>' +
					'</div>'
			}

			['banner', 'banner_promotional', 'banner_news'].forEach(setting => {

				const bannerName = setting.replace('_', '-');
				const bannerPluralName = 
					setting == 'banner' ? 'banners' : 
					setting == 'banner_promotional' ? 'banners-promotional' : 
					setting == 'banner_news' ? 'banners-news' :
					null;
				const $bannerMainContainer = $(`.js-home-${bannerName}`);
				const $bannerMainItem = $bannerMainContainer.find('.js-banner');
				const bannerSwiper = 
					setting == 'banner' ? 'homeBannerSwiper' : 
					setting == 'banner_promotional' ? 'homeBannerPromotionalSwiper' : 
					setting == 'banner_news' ? 'homeBannerNewsSwiper' :
					null;
				const desktopFormat = $bannerMainContainer.attr('data-desktop-format');
				const mobileFormat = $bannerMainContainer.attr('data-mobile-format');

				const desktopColumns = $bannerMainContainer.attr('data-desktop-columns');

				// Update section title
				handlers[`${setting}_title`] = new instaElements.Text({
					element: `.js-${bannerPluralName}-title`,
					show: function(){
						$(this).show();
					},
					hide: function(){
						$(this).hide();
					},
				})

				// Update banners content
				handlers[`${setting}`] = new instaElements.Lambda(function(slides){

					// Update text classes
					const textPosition = $bannerMainContainer.attr('data-text');
					const textClasses = textPosition == 'above' ? 'over-image' : '';
					const backgroundClasses = textPosition == 'outside' ? 'background-main' : '';

					// Update margin classes
					const bannerMargin = $bannerMainContainer.attr('data-margin');
					const marginClasses = bannerMargin == 'false' ? 'm-0' : '';

					// Update align classes
					const bannerAlign = $bannerMainContainer.attr('data-align');
					const alignClasses = bannerAlign == 'center' ? 'text-center' : '';

					// Update textbanner classes
					const textBannerClasses = marginClasses + ' ' + backgroundClasses + ' ' + alignClasses;

					// Update image classes
					const imageSize = $bannerMainContainer.attr('data-image');
					const imageClasses = imageSize == 'same' ? 'textbanner-image-background' : 'img-fluid d-block w-100';
					const imageContainerClasses = imageSize == 'original' ? 'p-0' : '';

					// Update column classes
					const desktopColumnsClasses = $bannerMainContainer.attr('data-grid-classes');
					const columnClasses = desktopColumnsClasses;

					// Insta slider function
					function instaSlider() {
						// Update banner classes
						const bannerClasses = 'swiper-slide';

						if (!window[bannerSwiper]) {
							return;
						}

						window[bannerSwiper].removeAllSlides();
						slides.forEach(function(aSlide){
							window[bannerSwiper].appendSlide(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses));
						});
						window[bannerSwiper].update();
					}

					// Insta grid function
					function instaGrid() {
						// Update banner classes
						const bannerClasses = '';

						$bannerMainContainer.find('.js-banner').remove();
						slides.forEach(function(aSlide){
							$bannerMainContainer.find('.js-banner-row').append(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses));
						});
					}

					if (desktopFormat == 'slider' || mobileFormat == 'slider') {

						if (desktopFormat == 'slider' && mobileFormat == 'grid') {
							if (window.innerWidth > 768) {
								instaSlider();
							} else {
								instaGrid();
							}
						} else if (mobileFormat == 'slider' && desktopFormat == 'grid') {
							if (window.innerWidth < 768) {
								instaSlider();
							} else {
								instaGrid();
							}
						} else {
							instaSlider();
						}
					} else {
						instaGrid();
					}
				});

				// Update banner text align
				handlers[`${setting}_align`] = new instaElements.Lambda(function(bannerAlign){
					const $bannerText = $bannerMainContainer.find('.js-textbanner');

					if (bannerAlign == 'center') {
						$bannerMainContainer.attr('data-align', 'center');
						$bannerText.addClass('text-center');
					} else {
						$bannerMainContainer.attr('data-align', 'left');
						$bannerText.removeClass('text-center');
					}
				});

				// Update banner text position
				handlers[`${setting}_text_outside`] = new instaElements.Lambda(function(hasOutsideText){
					const $bannerItem = $bannerMainContainer.find('.js-textbanner');
					const $bannerText = $bannerMainContainer.find('.js-textbanner-text');
					const $bannerLight = $bannerItem.hasClass('text-light');

					if (hasOutsideText) {
						$bannerMainContainer.attr('data-text', 'outside');
						$bannerText.removeClass('over-image').addClass('background-main');
						if ($bannerLight) {
							$bannerText.removeClass('text-light');
						}
					} else {
						$bannerMainContainer.attr('data-text', 'above');
						$bannerText.removeClass('background-main').addClass('over-image');
						if ($bannerLight) {
							$bannerText.addClass('text-light');
						}
					}
				});

				// Update banner size
				handlers[`${setting}_same_size`] = new instaElements.Lambda(function(bannerSize){
					const $bannerImageContainer = $bannerMainContainer.find('.js-textbanner-image-container');
					const $bannerImage = $bannerMainContainer.find('.js-textbanner-image');

					if (bannerSize) {
						$bannerMainContainer.attr('data-image', 'same');
						$bannerImageContainer.removeClass('p-0');
						$bannerImage.removeClass('img-fluid d-block w-100').addClass('textbanner-image-background');
					} else {
						$bannerMainContainer.attr('data-image', 'original');
						$bannerImageContainer.addClass('p-0');
						$bannerImage.removeClass('textbanner-image-background').addClass('img-fluid d-block w-100');
					}
				});

				// Update banner margins
				handlers[`${setting}_without_margins`] = new instaElements.Lambda(function(bannerMargin){
					const desktopFormat = $bannerMainContainer.attr('data-desktop-format');
					const mobileFormat = $bannerMainContainer.attr('data-mobile-format');
					const $bannerSection = $bannerMainContainer.closest('.js-section-banner-home');
					const $bannerContainer = $bannerMainContainer.find('.js-banner-container');
					const $bannerRow = $bannerContainer.find('.js-banner-row:not(.js-banner-wrapper)');
					const $bannerWrapper = $bannerContainer.find('.js-banner-wrapper');
					const $bannerMainTitle = $(`.js-${bannerPluralName}-title`);
					const $bannerItemContainer = $bannerMainContainer.find('.js-banner');
					const $bannerItem = $bannerItemContainer.find('.js-textbanner');
					const $bannerItemSlide = $bannerMainContainer.find('.js-banner.swiper-slide');
					const $bannerArrows = $(`.js-swiper-${bannerPluralName}-prev, .js-swiper-${bannerPluralName}-next`);

					if (bannerMargin) {
						$bannerMainContainer.attr('data-margin', 'false');
						$bannerSection.addClass('section-home-color p-0');
						$bannerContainer.removeClass('container position-relative px-md-3').addClass('container-fluid p-0 overflow-none');
						$bannerRow.removeClass('px-2').addClass('no-gutters');
						$bannerWrapper.removeClass('row-grid').addClass('no-gutters');
						$bannerMainTitle.addClass('container');
						$bannerItemContainer.addClass('m-0');
						$bannerItem.addClass('m-0');
						$bannerItemSlide.addClass('p-0');
						$bannerArrows.removeClass('swiper-button-outside').addClass('swiper-button-opacity');
						if ((desktopFormat == 'slider' && window.innerWidth > 768) || (mobileFormat == 'slider' && window.innerWidth < 768)) {
							window[bannerSwiper].params.spaceBetween = 0;
							window[bannerSwiper].update();
						}
					} else {
						$bannerMainContainer.attr('data-margin', 'true');
						$bannerSection.removeClass('section-home-color p-0');
						$bannerContainer.removeClass('container-fluid p-0 overflow-none').addClass('container position-relative');
						$bannerRow.removeClass('no-gutters').addClass('px-2');
						$bannerWrapper.removeClass('no-gutters').addClass('row-grid');
						$bannerMainTitle.removeClass('container');
						$bannerItemContainer.removeClass('m-0');
						$bannerItem.removeClass('m-0');
						$bannerItemSlide.removeClass('p-0');
						$bannerArrows.removeClass('swiper-button-opacity').addClass('swiper-button-outside');
						if ((desktopFormat == 'slider' && window.innerWidth > 768) || (mobileFormat == 'slider' && window.innerWidth < 768)) {
							window[bannerSwiper].params.spaceBetween = 15;
							window[bannerSwiper].update();
						}
					}

					// Updates slider width to avoids swipes inconsistency
					if ((desktopFormat == 'slider' && window.innerWidth > 768) || (mobileFormat == 'slider' && window.innerWidth < 768)) {
						window[bannerSwiper].params.observer = true;
						window[bannerSwiper].update();
					}
				});

				// Update quantity desktop banners
				handlers[`${setting}_columns_desktop`] = new instaElements.Lambda(function(bannerQuantity){
					const $bannerItem = $bannerMainContainer.find('.js-banner');
					const desktopFormat = $bannerMainContainer.attr('data-desktop-format');

					$bannerItem.removeClass('col-md-3 col-md-4 col-md-6 col-md-12');
					if (bannerQuantity == 4) {
						$bannerMainContainer.attr('data-desktop-columns', bannerQuantity);
						$bannerMainContainer.attr('data-grid-classes', 'col-md-3');

						$bannerItem.addClass('col-md-3');

						if (desktopFormat == 'slider') {
							if (window.innerWidth > 768) {
								window[bannerSwiper].params.slidesPerView = 4;
								window[bannerSwiper].update();
							}
						}
					} else if (bannerQuantity == 3) {
						$bannerMainContainer.attr('data-desktop-columns', bannerQuantity);
						$bannerMainContainer.attr('data-grid-classes', 'col-md-4');

						$bannerItem.addClass('col-md-4');

						if (desktopFormat == 'slider') {
							if (window.innerWidth > 768) {
								window[bannerSwiper].params.slidesPerView = 3;
								window[bannerSwiper].update();
							}
						}
					} else if (bannerQuantity == 2) {
						$bannerMainContainer.attr('data-desktop-columns', bannerQuantity);
						$bannerMainContainer.attr('data-grid-classes', 'col-md-6');

						$bannerItem.addClass('col-md-6');

						if (desktopFormat == 'slider') {
							if (window.innerWidth > 768) {
								window[bannerSwiper].params.slidesPerView = 2;
								window[bannerSwiper].update();
							}
						}
					} else if (bannerQuantity == 1) {
						$bannerMainContainer.attr('data-desktop-columns', bannerQuantity);
						$bannerMainContainer.attr('data-grid-classes', 'col-md-12');

						$bannerItem.addClass('col-md-12');

						if (desktopFormat == 'slider') {
							if (window.innerWidth > 768) {
								window[bannerSwiper].params.slidesPerView = 1;
								window[bannerSwiper].update();
							}
						}
					}
				});

				// Initialize swiper function
				function initSwiper() {

					const bannerMargin = $bannerMainContainer.attr('data-margin');

					createSwiper(`.js-swiper-${bannerPluralName}`, {
						watchOverflow: true,
						threshold: 5,
						watchSlideProgress: true,
						watchSlidesVisibility: true,
						slideVisibleClass: 'js-swiper-slide-visible',
						spaceBetween: bannerMargin == 'false' ? 0 : 15,
						navigation: {
							nextEl: `.js-swiper-${bannerPluralName}-next`,
							prevEl: `.js-swiper-${bannerPluralName}-prev`
						},
						slidesPerView: 1.15,
						breakpoints: {
							768: {
								slidesPerView: $bannerMainContainer.attr('data-desktop-columns'),
							}
						}
					},
					function(swiperInstance) {
						window[bannerSwiper] = swiperInstance;
					});

				}

				// Initialize swiper elements function
				function initSwiperElements() {
					const $bannerRow = $bannerMainContainer.find('.js-banner-row');
					const $bannerContainer = $bannerRow.closest('.container, .container-fluid');
					const $bannerItem = $bannerMainContainer.find('.js-banner');

					// Update margin classes
					const bannerMargin = $bannerMainContainer.attr('data-margin');

					const swiperDesktopColumns = $bannerMainContainer.attr('data-desktop-columns');
					const swiperArrowClasses = bannerMargin == 'false' ? 'swiper-button-opacity' : 'swiper-button-outside';

					// Row to swiper wrapper
					$bannerRow.addClass('swiper-wrapper');

					// Wrap everything inside a swiper container
					$bannerRow.wrapAll(`<div class="js-swiper-${bannerPluralName} swiper-container"></div>`);

					// Replace each banner into a slide
					$bannerItem.addClass('swiper-slide');

					// Add previous and next controls
					$bannerContainer.append(`
						<div class="js-swiper-${bannerPluralName}-prev swiper-button-prev svg-icon-text d-none d-md-block ${swiperArrowClasses}">
							<svg class="icon-inline icon-lg icon-flip-horizontal"><use xlink:href="#chevron"/></svg>
						</div>
						<div class="js-swiper-${bannerPluralName}-next swiper-button-next svg-icon-text d-none d-md-block ${swiperArrowClasses}">
							<svg class="icon-inline icon-lg"><use xlink:href="#chevron"/></svg>
						</div>
					`);

					// Initialize swiper
					initSwiper();

					// Update banners build
					handlers[`${setting}`] = new instaElements.Lambda(function(slides){
						// Update banner classes
						const bannerClasses = 'swiper-slide';
						// Update text classes
						const textPosition = $bannerMainContainer.attr('data-text');
						const textClasses = textPosition == 'above' ? 'over-image' : '';
						const backgroundClasses = textPosition == 'outside' ? 'background-main' : '';

						// Update margin classes
						const bannerMargin = $bannerMainContainer.attr('data-margin');
						const marginClasses = bannerMargin == 'false' ? 'm-0' : '';

						// Update align classes
						const bannerAlign = $bannerMainContainer.attr('data-align');
						const alignClasses = bannerAlign == 'center' ? 'text-center' : '';

						// Update textbanner classes
						const textBannerClasses = marginClasses + ' ' + backgroundClasses + ' ' + alignClasses;

						// Update image classes
						const imageSize = $bannerMainContainer.attr('data-image');
						const imageClasses = imageSize == 'same' ? 'textbanner-image-background' : 'img-fluid d-block w-100';
						const imageContainerClasses = imageSize == 'original' ? 'p-0' : '';

						// Update column classes
						const desktopColumnsClasses = $bannerMainContainer.attr('data-grid-classes');
						const columnClasses = desktopColumnsClasses;

						$bannerMainContainer.find('.js-banner').remove();
						slides.forEach(function(aSlide){
							$bannerMainContainer.find('.js-banner-row').append(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses));
						});
						initSwiper();
					});

				}

				// Reset swiper function
				function resetSwiperElements() {
					const $bannerRow = $bannerMainContainer.find('.js-banner-row');
					const $bannerItem = $bannerMainContainer.find('.js-banner');
					const desktopColumnsClasses = $bannerMainContainer.attr('data-grid-classes');

					// Remove duplicate slides and slider controls
					$bannerMainContainer.find('.swiper-slide-duplicate').remove();
					$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-prev`).remove();
					$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-next`).remove();

					// Swiper wrapper to row
					$bannerRow.removeClass('swiper-wrapper').removeAttr('style');

					// Undo all slider wrappers and restore original classes
					$bannerRow.unwrap();
					$bannerItem
						.removeClass('js-swiper-slide-visible swiper-slide-active swiper-slide-next swiper-slide-prev swiper-slide p-0')
						.addClass(desktopColumnsClasses)
						.removeAttr('style');

					// Update banners build
					handlers[`${setting}`] = new instaElements.Lambda(function(slides){
						// Update banner classes
						const bannerClasses = '';
						// Update text classes
						const textPosition = $bannerMainContainer.attr('data-text');
						const textClasses = textPosition == 'above' ? 'over-image' : '';
						const backgroundClasses = textPosition == 'outside' ? 'background-main' : '';

						// Update margin classes
						const bannerMargin = $bannerMainContainer.attr('data-margin');
						const marginClasses = bannerMargin == 'false' ? 'm-0' : '';

						// Update align classes
						const bannerAlign = $bannerMainContainer.attr('data-align');
						const alignClasses = bannerAlign == 'center' ? 'text-center' : '';

						// Update textbanner classes
						const textBannerClasses = marginClasses + ' ' + backgroundClasses + ' ' + alignClasses;

						// Update image classes
						const imageSize = $bannerMainContainer.attr('data-image');
						const imageClasses = imageSize == 'same' ? 'textbanner-image-background' : 'img-fluid d-block w-100';
						const imageContainerClasses = imageSize == 'original' ? 'p-0' : '';

						// Update column classes
						const desktopColumnsClasses = $bannerMainContainer.attr('data-grid-classes');
						const columnClasses = desktopColumnsClasses;

						$bannerMainContainer.find('.js-banner').remove();
						slides.forEach(function(aSlide){
							$bannerMainContainer.find('.js-banner-row').append(buildHomeBannerDom(aSlide, bannerClasses, textBannerClasses, columnClasses, textClasses, imageContainerClasses, imageClasses));
						});
					});

				}

				// Remove grid classes on desktop and mobile slider
				if (desktopFormat == 'slider' && mobileFormat == 'slider') {
					$bannerMainItem.removeClass('col-md-3 col-md-4 col-md-6 col-md-12');
				}

				// Hide swiper arrows on desktop grid
				if (desktopFormat == 'grid') {
					$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-prev`).removeClass('d-md-block');
					$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-next`).removeClass('d-md-block');
				}

				// Toggle grid and slider mobile view
				handlers[`${setting}_format_mobile`] = new instaElements.Lambda(function(bannerFormat){

					const toSlider = bannerFormat == "slider";

					const $bannerRow = $bannerMainContainer.find('.js-banner-row');
					const $bannerItem = $bannerMainContainer.find('.js-banner');

					const desktopFormat = $bannerMainContainer.attr('data-desktop-format');
					const mobileFormat = $bannerMainContainer.attr('data-mobile-format');

					const desktopColumns = $bannerMainContainer.attr('data-desktop-columns');

					if ($bannerMainContainer.attr('data-mobile-format') == bannerFormat) {
						// Nothing to do
						return;
					}

					// From grid to slider
					if (toSlider) {
						$bannerMainContainer.attr('data-mobile-format', 'slider');

						// Convert grid to slider if it's not yet
						if ($bannerMainContainer.find('.swiper-slide').length < 1) {
							initSwiperElements();
						}

						if (desktopFormat == 'grid') {
							$bannerRow.removeClass('px-2').addClass('swiper-mobile-only flex-nowrap flex-md-wrap row row-grid');
							if (window.innerWidth > 768) {
								$bannerRow.addClass('transform-none');
								$bannerItem.addClass('m-0 w-100');
								$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-prev`).removeClass('d-md-block');
								$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-next`).removeClass('d-md-block');
							} else {
								$bannerRow.removeClass('transform-none');
								$bannerItem.removeClass('m-0 w-100');
							}
						} else {
							$bannerRow.removeClass('swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0 swiper-mobile-only flex-md-wrap transform-none').addClass('swiper-products-slider flex-nowrap');
							if (window.innerWidth < 768) {
								$bannerItem.removeClass('m-0 w-100');
								initSwiper();
							}
						}

					// From slider to grid
					} else {
						$bannerMainContainer.attr('data-mobile-format', 'grid');

						if (desktopFormat == 'slider') {
							// Mantain desktop slider
							$bannerRow.removeClass('swiper-products-slider flex-nowrap').addClass('swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0');
							if (window.innerWidth < 768) {
								$bannerRow.addClass('transform-none');
								$bannerItem.removeAttr('style');
								$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-prev`).remove();
								$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-next`).remove();
								$bannerRow.find('.swiper-slide-duplicate').remove();
							} else {
								$bannerRow.removeClass('transform-none');
							}
						} else {

							// Reset swiper settings
							resetSwiperElements();

							// Restore grid settings
							$bannerRow.removeClass('swiper-wrapper swiper-mobile-only flex-nowrap flex-md-wrap transform-none').removeAttr('style');
							if (desktopFormat == 'grid' && mobileFormat == 'grid') {
								$bannerRow.removeClass('swiper-wrapper swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0 transform-none');
							}
						}

					}

					// Persist new format in data attribute
					$bannerMainContainer.attr('data-mobile-format', bannerFormat);
				});

				// Toggle grid and slider desktop view
				handlers[`${setting}_format_desktop`] = new instaElements.Lambda(function(bannerFormat){

					const toSlider = bannerFormat == "slider";

					const $bannerRow = $bannerMainContainer.find('.js-banner-row');
					const $bannerItem = $bannerMainContainer.find('.js-banner');

					const desktopFormat = $bannerMainContainer.attr('data-desktop-format');
					const mobileFormat = $bannerMainContainer.attr('data-mobile-format');

					const desktopColumns = $bannerMainContainer.attr('data-desktop-columns');

					if ($bannerMainContainer.attr('data-desktop-format') == bannerFormat) {
						// Nothing to do
						return;
					}

					// From grid to slider
					if (toSlider) {
						$bannerMainContainer.attr('data-desktop-format', 'slider');

						// Convert grid to slider if it's not yet
						if ($bannerMainContainer.find('.swiper-slide').length < 1) {
							initSwiperElements();
						}

						if (mobileFormat == 'grid') {
							$bannerRow.addClass('swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0');
							if (window.innerWidth < 768) {
								$bannerRow.addClass('transform-none');
								$bannerItem.addClass('m-0 w-100');
							} else {
								$bannerRow.removeClass('transform-none');
								$bannerItem.removeClass('m-0 w-100');
							}
						} else {
							$bannerRow.removeClass('swiper-mobile-only flex-md-wrap transform-none').addClass('swiper-products-slider');
							$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-prev`).addClass('d-md-block');
							$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-next`).addClass('d-md-block');
							if (window.innerWidth > 768) {
								$bannerItem.removeClass('m-0 w-100 w-auto');
								initSwiper();
							}
						}

					// From slider to grid
					} else {
						$bannerMainContainer.attr('data-desktop-format', 'grid');

						if (mobileFormat == 'slider') {
							// Mantain mobile slider
							$bannerRow.removeClass('swiper-products-slider').addClass('swiper-mobile-only flex-nowrap flex-md-wrap');
							if (window.innerWidth > 768) {
								$bannerRow.addClass('transform-none');
								$bannerItem.removeAttr('style');
								$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-prev`).removeClass('d-md-block');
								$bannerMainContainer.find(`.js-swiper-${bannerPluralName}-next`).removeClass('d-md-block');
								$bannerRow.find('.swiper-slide-duplicate').remove();
							} else {
								$bannerRow.removeClass('transform-none');
							}
						} else {

							// Reset swiper settings
							resetSwiperElements();

							// Restore grid settings
							$bannerRow.removeClass('swiper-wrapper swiper-desktop-only flex-wrap flex-md-nowrap ml-md-0 transform-none').removeAttr('style');
							if (desktopFormat == 'grid' && mobileFormat == 'grid') {
								$bannerRow.removeClass('swiper-wrapper swiper-mobile-only flex-nowrap flex-md-wrap transform-none');
							}
						}

					}

					// Persist new format in data attribute
					$bannerMainContainer.attr('data-desktop-format', bannerFormat);
				});

			});

			return handlers;
		}
	};
})(jQueryNuvem);