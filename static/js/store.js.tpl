{#/*============================================================================
    #Specific store JS functions: product variants, cart, shipping, etc
==============================================================================*/#}

{#/*============================================================================

	Table of Contents

	#Lazy load
	#Notifications and tooltips
	#Modals
	#Cards
	#Accordions
	#Transitions
	#Header and nav
		// Header
		// Nav
	#Sliders
		// Home slider
		// Products slider
		// Main categories
		// Brands slider
		// Product related
		// Banner services slider
	#Social
		// Youtube video
	#Product grid
		// Secondary image on mouseover
		// Fixed category controls
		// Filters
		// Sort by
		// Infinite scroll
		// Quickshop
	#Product detail functions
		// Installments
		// Change Variant
		// Submit to contact form
		// Product labels on variant change
		// Color and size variants change
		// Custom mobile variants change
		// Submit to contact
		// Product slider
		// Pinterest sharing
		// Add to cart
		// Product quantity
	#Cart
		// Toggle cart 
		// Add to cart
		// Cart quantitiy changes
		// Empty cart alert
	#Shipping calculator
		// Select and save shipping function
		// Calculate shipping function
		// Calculate shipping by submit
		// Shipping and branch click
		// Select shipping first option on results
		// Toggle more shipping options
		// Calculate shipping on page load
		// Shipping provinces
		// Change store country
	#Forms
	#Footer
	#Empty placeholders

==============================================================================*/#}

{#/*============================================================================
  #Filtro de ruído de erros injetados por webviews / apps de terceiros
  Os erros abaixo NÃO vêm do nosso código — são gerados pelo webview do
  Instagram/iOS Safari e por scripts injetados (autofill, message handlers,
  ResizeObserver loop). Não impactam o site, mas inflam o painel do Clarity
  e mascaram erros reais. Por isso suprimimos só esses padrões específicos.
==============================================================================*/ #}
(function() {
    var noisePatterns = [
        /resizeobserver loop/i,
        /webkit\.messagehandlers/i,
        /_autofillcallbackhandler/i,
        /private-token/i
    ];

    function isNoise(message) {
        if (!message) return false;
        var text = typeof message === 'string' ? message : (message.message || '');
        for (var i = 0; i < noisePatterns.length; i++) {
            if (noisePatterns[i].test(text)) return true;
        }
        return false;
    }

    window.addEventListener('error', function(e) {
        if (isNoise(e.message)) {
            e.stopImmediatePropagation();
            e.preventDefault();
        }
    }, true);

    window.addEventListener('unhandledrejection', function(e) {
        var reason = e.reason && (e.reason.message || e.reason);
        if (isNoise(reason)) {
            e.stopImmediatePropagation();
            e.preventDefault();
        }
    });
})();

// Move to our_content
window.urls = {
    "shippingUrl": "{{ store.shipping_calculator_url | escape('js') }}"
}

{#/*============================================================================
  #Lazy load
==============================================================================*/ #}

document.addEventListener('lazybeforeunveil', function(e){
    if ((e.target.parentElement) && (e.target.nextElementSibling)) {
        var parent = e.target.parentElement;
        var sibling = e.target.nextElementSibling;
        if (sibling.classList.contains('js-lazy-loading-preloader')) {
            sibling.style.display = 'none';
            parent.style.display = 'block';
        }
    }
});


window.lazySizesConfig = window.lazySizesConfig || {};
lazySizesConfig.hFac = 0.4;


DOMContentLoaded.addEventOrExecute(() => {

	{#/*============================================================================
	  #Notifications and tooltips
	==============================================================================*/ #}

    {# /* // Close notification and tooltip */ #}

    (($) => {
        const inputContainers = document.querySelectorAll('.lb-input-container');
        inputContainers.forEach(container => {
            const input = container.querySelector('input, textarea');
            const limiter = container.querySelector('.lb-imput-helper-limiter');

            // Guard against containers that have a limiter but no input/textarea
            // (would otherwise throw "addEventListener of undefined").
            if (limiter && input) {
                input.addEventListener('keyup', (e) => {
                    limiter.innerHTML = input.getAttribute('maxlength') - e.target.value.length;
                });
            }
        });
    })(jQueryNuvem);

    jQueryNuvem(".js-notification-close, .js-tooltip-close").on( "click", function(e) {
        e.preventDefault();
        jQueryNuvem(e.currentTarget).closest(".js-notification, .js-tooltip").hide();
    });

    {# /* // Open tooltip */ #}

    jQueryNuvem(document).on("click", ".js-tooltip-open", function(e) {
        e.preventDefault();
        jQueryNuvem(this).next(".js-tooltip").show();
    });

    {# Notifications variables #}

    
    var $notification_status_page = jQueryNuvem(".js-notification-status-page");
    var $fixed_bottom_button = jQueryNuvem(".js-btn-fixed-bottom");
    var head_height = jQueryNuvem(".js-head-main").height();
    
	{# /* // Follow order status notification */ #}
    
    if ($notification_status_page.length > 0){
        if (LS.shouldShowOrderStatusNotification($notification_status_page.data('url'))){

            $notification_status_page.css("top" , head_height + 15 + "px");
            $notification_status_page.show();
        };
        jQueryNuvem(".js-notification-status-page-close").on( "click", function(e) {
            e.preventDefault();
            LS.dontShowOrderStatusNotificationAgain($notification_status_page.data('url'));
        });
    }

    {# /* // Cart notification: Dismiss notification */ #}

    jQueryNuvem(".js-cart-notification-close").on("click", function(){
        jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
        setTimeout(function(){
            jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
            jQueryNuvem(".js-alert-added-to-cart").hide();
        },2000);
    });

    {% if not settings.head_fix_desktop %}

        {# /* // Add to cart notification on non fixed header */ #}
        if (window.innerWidth > 768) {
            var adBarHeight = jQueryNuvem(".js-topbar").outerHeight();
            var logoBarHeight = jQueryNuvem(".js-nav-logo-bar").outerHeight();
            var fixedNotificationPosition = adBarHeight + logoBarHeight + 20; 
            var $addedToCartNotification = jQueryNuvem(".js-alert-added-to-cart");

            $addedToCartNotification.css("top", fixedNotificationPosition.toString() + 'px').css("marginTop", "-1px");

            !function () {
                var isNotificationFixed = false;
                var isNotificationScrollTicking = false;
                // Performance optimization: Throttle scroll event to prevent layout thrashing
                window.addEventListener("scroll", function (e) {
                    if (!isNotificationScrollTicking) {
                        window.requestAnimationFrame(function() {
                            if (window.pageYOffset == 0) {
                                if (isNotificationFixed) {
                                    $addedToCartNotification.css("top" , fixedNotificationPosition.toString() + 'px');
                                    isNotificationFixed = false;
                                }
                            } else {
                                if (!isNotificationFixed) {
                                    $addedToCartNotification.css("top" , "30px");
                                    isNotificationFixed = true;
                                }
                            }
                            isNotificationScrollTicking = false;
                        });
                        isNotificationScrollTicking = true;
                    }
                }, { passive: true });
            }();
        }

    {% endif %}

    {% if not params.preview %}

        {# /* // Cookie banner notification */ #}

        
        const footerLegal = jQueryNuvem(".js-footer-legal");

        restoreNotifications = function(){

            // Whatsapp button position
            $fixed_bottom_button.css("marginBottom", "0");

            {# Restore notifications when Cookie Banner is closed #}

            footerLegal.removeAttr("style");

        };

        if (!window.cookieNotificationService.isAcknowledged()) {
            jQueryNuvem(".js-notification-cookie-banner").show();

            const cookieBannerHeight = jQueryNuvem(".js-notification-cookie-banner").outerHeight();

            {# Offset to show legal footer #}
            
            footerLegal.css("paddingBottom", cookieBannerHeight + 40 + "px");

            if (window.innerWidth < 768) {
                
                {# Whatsapp button position #}

                $fixed_bottom_button.css("marginBottom", cookieBannerHeight + 20 + "px");
            }

        }

        jQueryNuvem(".js-acknowledge-cookies").on( "click", function(e) {
            window.cookieNotificationService.acknowledge();

            footerLegal.removeAttr("style");
            restoreNotifications();
        });

    {% endif %}

    {#/*============================================================================
      #Modals
    ==============================================================================*/ #}

    {% if settings.quick_shop %}

        restoreQuickshopForm = function(){

            {# Restore form to item when quickshop closes #}

            {# Clean quickshop modal #}

            jQueryNuvem("#quickshop-modal .js-item-product").removeClass("js-swiper-slide-visible js-item-slide");
            jQueryNuvem("#quickshop-modal .js-quickshop-container").attr( { 'data-variants' : '' , 'data-quickshop-id': '' } );
            jQueryNuvem("#quickshop-modal .js-item-product").attr('data-product-id', '');

            {# Wait for modal to become invisible before removing form #}
            
            setTimeout(function(){
                var $quickshop_form = jQueryNuvem("#quickshop-form").find('.js-product-form');
                var $item_form_container = jQueryNuvem(".js-quickshop-opened").find(".js-item-variants");
                
                $quickshop_form.detach().appendTo($item_form_container);
                jQueryNuvem(".js-quickshop-opened").removeClass("js-quickshop-opened");
                jQueryNuvem("#quickshop-modal .js-quickshop-img").attr('srcset', '');
                jQueryNuvem("#quickshop-form").removeAttr("style");
            },350);

        };

    {% endif %}

    {# Reset al open searches when closing a modal #}

    resetSearchBox = function(){

        {# Reset al open searches when closing a modal #}
        
        jQueryNuvem(".js-search-input").val("");
        jQueryNuvem(".js-search-form-suggestions").hide();

        const empty_search = jQueryNuvem(".js-empty-search");
        const empty_submit = jQueryNuvem(".js-search-input-submit");

        empty_search.fadeOut(100);
        empty_submit.fadeIn(100);

    };

    {# Full screen mobile modals back events #}

    if (window.innerWidth < 768) {

        {# Clean url hash function #}

        cleanURLHash = function(){
            const uri = window.location.toString();
            const clean_uri = uri.substring(0, uri.indexOf("#"));
            window.history.replaceState({}, document.title, clean_uri);
        };

        {# Go back 1 step on browser history #}

        goBackBrowser = function(){
            cleanURLHash();
            history.back();
        };

        {# Clean url hash on page load: All modals should be closed on load #}

        if(window.location.href.indexOf("modal-fullscreen") > -1) {
            cleanURLHash();
        }

        {# Open full screen modal and url hash #}

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-open", function(e) {
            e.preventDefault();
            var modal_url_hash = jQueryNuvem(this).data("modalUrl");
            window.location.hash = modal_url_hash;
        });

        {# Close full screen modal: Remove url hash #}

        jQueryNuvem(document).on("click", ".js-fullscreen-modal-close", function(e) {
            e.preventDefault();
            goBackBrowser();
        });

        {# Hide panels or modals on browser backbutton #}

        window.onhashchange = function() {
            if(window.location.href.indexOf("modal-fullscreen") <= -1) {

                {# Close opened modal #}

                if(jQueryNuvem(".js-fullscreen-modal").hasClass("modal-show")){

                    {# Remove body lock only if a single modal is visible on screen #}

                    if(jQueryNuvem(".js-modal.modal-show").length == 1){
                        jQueryNuvem("body").removeClass("overflow-none");
                    }
                    var $opened_modal = jQueryNuvem(".js-fullscreen-modal.modal-show");
                    var $opened_modal_overlay = $opened_modal.prev();

                    $opened_modal.removeClass("modal-show");
                    setTimeout(() => $opened_modal.hide(), 500);
                    $opened_modal_overlay.fadeOut(500);

                    {# Reset al open searches when closing a modal #}
        
                    resetSearchBox();

                    {% if settings.quick_shop %}
                        restoreQuickshopForm();
                    {% endif %}

                }
            }
        }

    }

    jQueryNuvem(document).on("click", ".js-modal-open", function(e) {
        e.preventDefault(); 
        var modal_id = jQueryNuvem(this).data('toggle');
        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="' + modal_id + '"]');

        if (jQueryNuvem(modal_id).hasClass("modal-show")) {
            {# If modal is already opened, close it #}
            if(jQueryNuvem(".js-modal.modal-show").length == 1){
                jQueryNuvem("body").removeClass("overflow-none");
            }
            let modal = jQueryNuvem(modal_id).removeClass("modal-show");
            setTimeout(() => modal.hide(), 500);
        } else {

            {# Lock body scroll if there is no modal visible on screen #}
            
            if(!jQueryNuvem(".js-modal.modal-show").length){
                jQueryNuvem("body").addClass("overflow-none move-right");
            }

            jQueryNuvem(modal_id).detach().appendTo("body");
            jQueryNuvem(modal_id).show().addClass("modal-show");
            
            {# Show overlay for all modals or tab modals only in desktop #}
            if (((jQueryNuvem(modal_id).hasClass("js-modal-overlay-md")) && (window.innerWidth > 768)) || (!jQueryNuvem(modal_id).hasClass("js-modal-overlay-md"))) {
                $overlay_id.fadeIn(400);
                $overlay_id.detach().insertBefore(modal_id);
            }
        }             
    });

    jQueryNuvem(document).on("click", ".js-modal-close", function(e) {
        e.preventDefault();

        {# Remove body lock only if a single modal is visible on screen #}

        if(jQueryNuvem(".js-modal.modal-show").length == 1){
            jQueryNuvem("body").removeClass("overflow-none");
        }
        var $modal = jQueryNuvem(this).closest(".js-modal");
        var modal_id = $modal.attr('id');
        var $overlay_id = jQueryNuvem('.js-modal-overlay[data-modal-id="#' + modal_id + '"]');
        $modal.removeClass("modal-show");
        setTimeout(() => $modal.hide(), 500);
        $overlay_id.fadeOut(500);
        
        {# Close full screen modal: Remove url hash #}

        if ((window.innerWidth < 768) && (jQueryNuvem(this).hasClass(".js-fullscreen-modal-close"))) {
            goBackBrowser();
        }

        {# Reset al open searches when closing a modal #}

        resetSearchBox();

        {% if settings.quick_shop %}
            restoreQuickshopForm();
        {% endif %}

    });

    jQueryNuvem(document).on("click", ".js-modal-overlay", function(e) {
        e.preventDefault();

        {# Remove body lock only if a single modal is visible on screen #}

        if(jQueryNuvem(".js-modal.modal-show").length == 1){
            jQueryNuvem("body").removeClass("overflow-none");
        }

        var modal_id = jQueryNuvem(this).data('modalId');
        let modal = jQueryNuvem(modal_id).removeClass("modal-show");
        setTimeout(() => modal.hide(), 500);
        jQueryNuvem(this).fadeOut(500);

        {# Reset al open searches when closing a modal #}
        
        resetSearchBox();

        {% if settings.quick_shop %}
            restoreQuickshopForm();
        {% endif %}

    });

    {% if template == 'home' and settings.home_promotional_popup %}

        {# /* // Home popup and newsletter popup */ #}

        jQueryNuvem('#news-popup-form').on("submit", function () {
            jQueryNuvem(".js-news-spinner").show();
            jQueryNuvem(".js-news-popup-submit").prop("disabled", true);
        });

        LS.newsletter('#news-popup-form-container', '#home-modal', '{{ store.contact_url | escape('js') }}', function (response) {
            jQueryNuvem(".js-news-spinner").hide();
            jQueryNuvem(".js-news-popup-submit").show();
            var selector_to_use = response.success ? '.js-news-popup-success' : '.js-news-popup-failed';
            let newPopupAlert = jQueryNuvem(this).find(selector_to_use).fadeIn(100);
            setTimeout(() => newPopupAlert.fadeOut(500), 4000);
            if (jQueryNuvem(".js-news-popup-success").css("display") == "block") {
                setTimeout(function () {
                    jQueryNuvem('[data-modal-id="#home-modal"]').fadeOut(500);
                    let homeModal = jQueryNuvem("#home-modal").removeClass("modal-show");
                    setTimeout(() => homeModal.hide(), 500);
                }, 2500);
            }
            jQueryNuvem(".js-news-popup-submit").prop("disabled", false);
        });

        var callback_show = function(){
            {% if store.whatsapp %}
                jQueryNuvem('.js-btn-fixed-bottom').fadeOut(500);
            {% endif %}
            jQueryNuvem("#home-modal").detach().appendTo("body").show().addClass("modal-show");
        }
        var callback_hide = function(){
            let homeModal = jQueryNuvem("#home-modal").removeClass("modal-show");
            setTimeout(() => homeModal.hide(), 500);
        }

        {% if store.whatsapp %}
            jQueryNuvem("#home-modal .js-modal-close").on("click", function (e) {
                e.preventDefault();
                jQueryNuvem('.js-btn-fixed-bottom').fadeIn(500);
            });
        {% endif %}

        LS.homePopup({
            selector: "#home-modal",
            mobile_max_pixels: 0,
            timeout: 10000
        }, callback_hide, callback_show);

    {% endif %}

    {#/*============================================================================
      #Cards
    ==============================================================================*/ #}
    jQueryNuvem(document).on("click", ".js-card-collapse-toggle", function(e) {
        e.preventDefault();
        var parent = jQueryNuvem(this).closest(".js-card-collapse");
        parent.find(".js-card-collapse-icon").toggle();
        parent.toggleClass('active');
    });

    {#/*============================================================================
      #Transitions
    ==============================================================================*/ #}

    const inViewport = (entries, observer) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-inViewport");
          // Performance: Unobserve once the transition class is added
          observer.unobserve(entry.target);
        }
      });
    };

    // Attach observer to every [data-transition] element:
    const ELs_inViewport = document.querySelectorAll('[data-transition]');
    // Performance: Instantiate a single IntersectionObserver outside the loop
    const transitionObserver = new IntersectionObserver(inViewport);
    ELs_inViewport.forEach(EL => {
      transitionObserver.observe(EL);
    });

    applyMarqueeAnimation = function(marqueeSelector, textSelector){

        {# Reference speed values #}

        var defaultDelay = 5;
        var defaultWidth = 300;

        {# New speed values based on dynamic content #}
        var animatedWidth = jQueryNuvem(textSelector).first(el => el.offsetWidth);
        var newDelay = defaultDelay*(animatedWidth/defaultWidth)*1.5;

        if((window.innerWidth > 768) && (newDelay < 40)){

            {# If content is too short, set a minimum speed #}
            var newDelay = newDelay + 20;
        }

        jQueryNuvem(marqueeSelector).css("animation", "marquee " + newDelay + "s linear infinite");
    };

    {% if settings.welcome_animate %}

        {# /* // Animated welcome message */ #}

        applyMarqueeAnimation(".js-welcome-animated" , ".js-welcome-text-container");
    {% endif %}

	{#/*============================================================================
      #Header and nav
    ==============================================================================*/ #}

    {# /* // Adbar slider */ #}

    {% set adbarMessage01 = settings.ad_bar_01_text %}
    {% set adbarMessage02 = settings.ad_bar_02_text %}
    {% set adbarMessage03 = settings.ad_bar_03_text %}
    {% set adbarMultipleMessages = (adbarMessage01 and adbarMessage02) or (adbarMessage01 and adbarMessage03) or (adbarMessage02 and adbarMessage03) %}
    {% set adbarMessages = adbarMessage01 or adbarMessage02 or adbarMessage03 %}
    {% set hasAdbar = settings.ad_bar and (adbarMessages or 'adbar_img_mobile.jpg' | has_custom_image or 'adbar_img_desktop.jpg' | has_custom_image) %}

    {% if settings.ad_bar %}

        {% if settings.ad_bar_animate %}

            {# /* // Animated adbar */ #}

            applyMarqueeAnimation(".js-adbar-animated" , ".js-adbar-text-container");

        {% elseif adbarMultipleMessages %}

            createSwiper('.js-swiper-adbar', {
                loop: true,
                slidesPerView: 1,
                navigation: {
                    nextEl: '.js-swiper-adbar-next',
                    prevEl: '.js-swiper-adbar-prev',
                },
            });

        {% endif %}

    {% endif %}

    {# /* // Nav */ #}

    {# Nav subitems hamburger #}

    jQueryNuvem(".js-toggle-menu-panel").click(function (e) {
        e.preventDefault();
        jQueryNuvem(this).next(".js-menu-panel").show().addClass("nav-list-panel-show");
    });

    jQueryNuvem(".js-toggle-menu-back").click(function (e) {
        e.preventDefault();
        var $panel_to_change = jQueryNuvem(this).closest(".js-menu-panel");
        $panel_to_change.removeClass("nav-list-panel-show");
         setTimeout(function(){
            $panel_to_change.hide();
        },600);
    });

    closeHamburgerSubpanels = function() {
        jQueryNuvem("#nav-hamburger").addClass("modal-transition-fast");
        jQueryNuvem(".js-menu-panel").removeClass("nav-list-panel-show");
        
         setTimeout(function(){
            jQueryNuvem(".js-menu-panel").hide();
            jQueryNuvem("#nav-hamburger").removeClass("modal-transition-fast");
        },1000);
    };

    jQueryNuvem(".js-toggle-menu-close, .js-modal-overlay[data-modal-id='#nav-hamburger'").click(function () {
        closeHamburgerSubpanels();
    });

    {# Nav subitems desktop #}

    var win_height = window.innerHeight;
    const logoContainer = jQueryNuvem('.js-logo-container');

    jQueryNuvem(".js-desktop-dropdown").css('maxHeight', (win_height - head_height - 50).toString() + 'px');

    jQueryNuvem(".js-item-subitems-desktop").on("mouseenter", function (e) {
        jQueryNuvem(e.currentTarget).addClass("active");
    }).on("mouseleave", function(e) {
        jQueryNuvem(e.currentTarget).removeClass("active");
    });

    jQueryNuvem(".js-nav-main-item").on("mouseenter", function (e) {
        jQueryNuvem('.js-nav-desktop-list').children(".selected").removeClass("selected");
        jQueryNuvem(e.currentTarget).addClass("selected");
    }).on("mouseleave", function(e) {
        const self = jQueryNuvem(this);
        setTimeout(function(){
            self.removeClass("selected");
        },500);
    });

    jQueryNuvem(".js-nav-desktop-list-arrow").on("mouseenter", function (e) {
        jQueryNuvem('.js-desktop-nav-item').removeClass("selected");
    });

     {# Nav desktop scroller #}

    {% set logo_desktop_left = settings.logo_position_desktop == 'left' and not settings.search_big_desktop %}

    const menuContainer = jQueryNuvem('.js-nav-desktop-list').first(el => el.offsetWidth);
    const logoColWidth = logoContainer.first(el => el.offsetWidth);
    let utilityColWidth = 0;
    
    jQueryNuvem('.js-utility-col').each(function(el) {
        utilityColWidth +=  jQueryNuvem(el).first(el => el.offsetWidth);
    });

    const totalColsWidth = logoColWidth + utilityColWidth;

    {% if logo_desktop_left %}
        const menuColWidth = menuContainer - totalColsWidth - 30;
    {% endif %}

    let menuItems = 0;

    jQueryNuvem('.js-nav-desktop-list > .js-desktop-nav-item').each(function(el) {
        menuItems +=  jQueryNuvem(el).first(el => el.offsetWidth);
    });

    var $navDesktopList = jQueryNuvem(".js-nav-desktop-list");
    var $navArrowLeft = jQueryNuvem(".js-nav-desktop-list-arrow-left");
    var $navArrowRight = jQueryNuvem(".js-nav-desktop-list-arrow-right");
    var isNavArrowLeftDisabled = null;
    var isNavArrowRightDisabled = null;

    if ($navDesktopList.length > 0) {
        $navDesktopList[0].addEventListener("scroll", function() {
            var position = $navDesktopList[0].scrollLeft;
            var shouldDisableLeft = (position === 0);

            if(shouldDisableLeft !== isNavArrowLeftDisabled) {
                if(shouldDisableLeft) {
                    $navArrowLeft.addClass('disable');
                } else {
                    $navArrowLeft.removeClass('disable');
                }
                isNavArrowLeftDisabled = shouldDisableLeft;
            }

            var shouldDisableRight = (Math.ceil(position) >= (menuItems - menuContainer));
            if(shouldDisableRight !== isNavArrowRightDisabled) {
                if(shouldDisableRight) {
                    $navArrowRight.addClass('disable');
                } else {
                    $navArrowRight.removeClass('disable');
                }
                isNavArrowRightDisabled = shouldDisableRight;
            }
        }, { passive: true });
    }

    {% if logo_desktop_left %}

        {# Recalculate items width including first and last element different paddings #}

        menuItems = menuItems;
        
    {% endif %}
    
    if (menuContainer < menuItems) {
        jQueryNuvem('.js-nav-desktop-list').addClass('nav-desktop-with-scroll');
        jQueryNuvem('.js-nav-desktop-list-arrow').show();
        {% if logo_desktop_left %}
            jQueryNuvem(".js-desktop-nav-col").css("width" , menuColWidth.toString() + 'px');
        {% endif %}
    }

    setTimeout(function(){
        jQueryNuvem(".js-desktop-nav-col, .js-utility-col").css("visibility", "visible").css("height", "auto");
    },200);

    {# Show nav row once columns layout are ready #}

    jQueryNuvem(".js-menu-and-banners-row").css("visibility" , "visible").css("height" , "auto").css("overflow" , "initial");

    jQueryNuvem('.js-nav-desktop-list-arrow-right').on("click", function() {
        var posL = jQueryNuvem('.js-nav-desktop-list').prop("scrollLeft") + 400;
        jQueryNuvem('.js-nav-desktop-list').each((el) => el.scroll({ left: posL, behavior: 'smooth' }));
    });
    jQueryNuvem('.js-nav-desktop-list-arrow-left').on("click", function() {
        var posR = jQueryNuvem('.js-nav-desktop-list').prop("scrollLeft") - 400;
        jQueryNuvem('.js-nav-desktop-list').each((el) => el.scroll({ left: posR, behavior: 'smooth' }));
    });

    {# Avoid megamenu dropdown flickering when mouse leave #}

    jQueryNuvem(".js-desktop-dropdown").on("mouseleave", function (e) {
        const self = jQueryNuvem(this);
        self.css("pointer-events" , "none");
        setTimeout(function(){
            self.css("pointer-events" , "initial");
        },1000);
    });

    {# Expandable search #}

    {% if not settings.search_big_desktop %}
        jQueryNuvem(".js-search-button").on("click", function (e) {
            var searchBox = jQueryNuvem(".js-search-utility").find(".js-search-form");
            searchBox.addClass("expanded");
        });
    {% endif%}

    {# Focus search #}

    const search_input = jQueryNuvem(".js-search-input");

    jQueryNuvem(".js-search-button").on("click", function (e) {
        setTimeout(function(){
            search_input.val('').each(el => el.focus());
        },10);
    });

    {# /* // Header */ #}

        var $category_controls = jQueryNuvem(".js-category-controls");

        {# Fixed nav #}

        {# /* // Nav offset */ #}

        function applyOffset(selector){

            // Get nav height on load
            if (window.innerWidth > 768) {
                setTimeout(function(){
                    var head_height = jQueryNuvem(".js-head-main").outerHeight();
                    jQueryNuvem(selector).css("paddingTop", head_height.toString() - 1 + 'px');
                },210);
            }else{

                {# On mobile there is no top padding due to position sticky CSS #}
                var head_height = 0;
            }

            // Apply offset nav height on load
            
            window.addEventListener("resize", function() {

                // Get nav height on resize
                var head_height = jQueryNuvem(".js-head-main").height();

                // Apply offset on resize
                if (window.innerWidth > 768) {
                    jQueryNuvem(selector).css("paddingTop", head_height.toString() + 'px');
                }else{

                    {# On mobile there is no top padding due to position sticky CSS #}
                    jQueryNuvem(selector).css("paddingTop", "0px");
                }
            });
        }

    {% set has_only_mobile_with_fixed_nav =  not settings.head_fix_desktop %}

    {% if has_only_mobile_with_fixed_nav %}
        if (window.innerWidth < 768) {
    {% endif %}
        applyOffset(".js-head-offset");

        {# Slim header on scroll #}

        {% set adbarImagesOnly = 'adbar_img_desktop.jpg' | has_custom_image or 'adbar_img_mobile.jpg' | has_custom_image %}
        {% set adbarImageMobileOnly = 'adbar_img_mobile.jpg' | has_custom_image and not 'adbar_img_desktop.jpg' | has_custom_image %}
        {% set adbarImageDesktopOnly = 'adbar_img_desktop.jpg' | has_custom_image and not 'adbar_img_mobile.jpg' | has_custom_image %}
        {% set adbarWithoutMessages = settings.ad_bar and not adbarMessages and adbarImagesOnly %}

        // Performance optimization: Cache DOM queries outside scroll listener
        var $topbar = jQueryNuvem(".js-topbar");
        var topbarHeight = $topbar.outerHeight();

        var headerIsCompressed = false;
        var $headerMain = jQueryNuvem(".js-head-main");
        if ($headerMain.length > 0) {
            var isHeaderScrollTicking = false;
            // Performance optimization: Throttle scroll event to prevent layout thrashing
            window.addEventListener("scroll", function() {
                if (!isHeaderScrollTicking) {
                    window.requestAnimationFrame(function() {
                        var scrolledPosition = window.pageYOffset;

                        var header = $headerMain;
                        var navbarHeight = $headerMain[0].offsetHeight;

                    {# Recalculate topbar height in case image has not loaded yet and result is 0 #}

                    {% if adbarWithoutMessages %}
                        {% if adbarImageMobileOnly %}
                            if (window.innerWidth < 768) {
                        {% elseif adbarImageDesktopOnly %}
                            if (window.innerWidth > 768) {
                        {% endif %}
                                if (topbarHeight == 0) {
                                    topbarHeight = $topbar.outerHeight();
                                }
                        {% if adbarImageMobileOnly or adbarImageDesktopOnly %}
                            }
                        {% endif %}
                    {% endif %}

                    if (scrolledPosition > navbarHeight) {
                        if (!headerIsCompressed) {
                            header.addClass('compress').css('top', -topbarHeight + 'px' );
                            {% if template == 'category' %}
                                if (window.innerWidth < 768) {
                                    setTimeout(function(){
                                        offsetCategories();
                                    },300);
                                }
                            {% endif %}
                            headerIsCompressed = true;
                        }
                    } else {
                        if (headerIsCompressed !== false) {
                            header.removeClass('compress').css("top", "0px");
                            {% if template == 'category' %}
                                if (window.innerWidth < 768) {
                                    setTimeout(function(){
                                        offsetCategories();
                                    },300);
                                }
                            {% endif %}
                            headerIsCompressed = false;
                        }
                    }
                        isHeaderScrollTicking = false;
                    });
                    isHeaderScrollTicking = true;
                }
            }, { passive: true });
        }
        
    {% if has_only_mobile_with_fixed_nav %}
        }
    {% endif %} 


    {# /* // Lang select */ #}


    changeLang = function(element) {
        var selected_country_url = element.find("option").filter((el) => el.selected).attr("data-country-url");
        location.href = selected_country_url;
    };

    jQueryNuvem('.js-lang-select').on("change", function (e) {
        lang_select_option = jQueryNuvem(this);

        changeLang(lang_select_option);
    });

	{#/*============================================================================
	  #Sliders
	==============================================================================*/ #}
    {% set theme_editor = params.preview %}
    {% set columns_desktop = settings.grid_columns_desktop %}
    {% set columns_mobile = settings.grid_columns_mobile %}
    var slidesPerViewDesktopVal = {% if columns_desktop == 5 %}5{% else %}4{% endif %};
    var slidesPerViewMobileVal = {% if columns_mobile == 1 %}1.15{% else %}2.25{% endif %};
    var itemSwiperSpaceBetween = 15;

    {# Hide arrow controls when swiper is not swipable #}

    hideSwiperControls = function(elemPrev, elemNext) {
        if((jQueryNuvem(elemPrev).hasClass("swiper-button-disabled") && jQueryNuvem(elemNext).hasClass("swiper-button-disabled"))){
            jQueryNuvem(elemPrev).remove();
            jQueryNuvem(elemNext).remove();
        }
    };

    {% set has_best_seller_products_slider = sections.best_seller.products and (settings.best_seller_products_format_mobile == 'slider' or settings.best_seller_products_format_desktop == 'slider') %}
    {% if has_best_seller_products_slider or theme_editor %}

        var lazyVal = true;
        var watchOverflowVal = true;
        var centerInsufficientSlidesVal = true;

        {% set best_seller_desktop_slider = settings.best_seller_products_format_desktop == 'slider' %}
        {% set best_seller_only_mobile_slider = settings.best_seller_products_format_mobile == 'slider' and settings.best_seller_products_format_desktop != 'slider' %}
        {% set best_seller_only_desktop_slider = settings.best_seller_products_format_desktop == 'slider' and settings.best_seller_products_format_mobile != 'slider' %}
        {% set best_seller_columns_desktop = settings.best_seller_products_desktop %}
        {% set best_seller_columns_mobile = settings.best_seller_products_mobile %}
        var slidesPerViewBestSellerDesktopVal = {% if best_seller_columns_desktop == 4 %}4{% elseif best_seller_columns_desktop == 5 %}5{% else %}6{% endif %};
        var slidesPerViewBestSellerMobileVal = {% if best_seller_columns_mobile == 1 %}1.15{% else %}2.25{% endif %};

        {% if best_seller_only_mobile_slider %}
            if (window.innerWidth < 768) {
        {% elseif best_seller_only_desktop_slider %}
            if (window.innerWidth > 768) {
        {% endif %}
            createSwiper('.js-swiper-best-seller', {
                lazy: lazyVal,
                watchOverflow: watchOverflowVal,
                centerInsufficientSlides: centerInsufficientSlidesVal,
                threshold: 5,
                watchSlideProgress: true,
                watchSlidesVisibility: true,
                slideVisibleClass: 'js-swiper-slide-visible',
                spaceBetween: itemSwiperSpaceBetween,
            {% if sections.best_seller.products | length > 4 %}
                loop: true,
            {% endif %}
                navigation: {
                    nextEl: '.js-swiper-best-seller-next',
                    prevEl: '.js-swiper-best-seller-prev',
                },
                on: {
                    afterInit: function () {
                        hideSwiperControls(".js-swiper-best-seller-prev", ".js-swiper-best-seller-next");
                    },
                },
                slidesPerView: slidesPerViewBestSellerMobileVal,
            {% if best_seller_desktop_slider %}
                breakpoints: {
                    768: {
                        slidesPerView: slidesPerViewBestSellerDesktopVal,
                    }
                }
            {% endif %}
            },
            function(swiperInstance) {
                window.productsBestSellerSwiper = swiperInstance;
            });
        {% if best_seller_only_mobile_slider or best_seller_only_desktop_slider %}
            }
        {% endif %}

    {% endif %}


	{% if template == 'home' %}

            // aqui vamos fazer esquema de lazy, quand o elemento estiver chegando a ficar visivel na tela então damos display block e trocamos data-src para src.
            
            setTimeout(function() {
                // Função para carregar imagens primeiro
                function loadImages(element) {
                    const imgs = element.querySelectorAll("img");
                    imgs.forEach(function(img) {
                        if (img.getAttribute("data-src") && !img.src) {
                            img.src = img.getAttribute("data-src");
                        }
                    });
                }

                // Função para carregar vídeos em qualidade progressiva
                function loadVideos(element) {
                    const videos = element.querySelectorAll("video");
                    videos.forEach(function(video) {
                        if (video.getAttribute("data-src") && !video.src) {
                            // Primeiro carrega qualidade baixa se disponível
                            const lowQualitySrc = video.getAttribute("data-src-low");
                            if (lowQualitySrc) {
                                video.src = lowQualitySrc;
                                // Depois de um tempo, carrega qualidade alta
                                setTimeout(() => {
                                    const highQualitySrc = video.getAttribute("data-src");
                                    if (highQualitySrc) {
                                        video.src = highQualitySrc;
                                    }
                                }, 2000); // 2 segundos depois
                            } else {
                                // Se não tem qualidade baixa, carrega direto
                                video.src = video.getAttribute("data-src");
                            }
                        }
                    });
                }

                // Intersection Observer for better performance lazy loading
                if ('IntersectionObserver' in window) {
                    const lazyObserver = new IntersectionObserver((entries, observer) => {
                        entries.forEach(entry => {
                            if (entry.isIntersecting) {
                                const element = entry.target;
                                element.style.display = "block";

                                // Carrega imagens primeiro
                                loadImages(element);

                                // Carrega vídeos depois de um pequeno delay
                                setTimeout(() => {
                                    loadVideos(element);
                                }, 300);

                                element.classList.add("js-section-video-products-lazy-loaded");
                                observer.unobserve(element);
                            }
                        });
                    }, { rootMargin: "200px" });

                    document.querySelectorAll(".js-section-video-products-lazy:not(.js-section-video-products-lazy-loaded)").forEach(function(element) {
                        lazyObserver.observe(element);
                    });
                } else {
                    // Fallback para navegadores antigos sem suporte a IntersectionObserver
                    document.querySelectorAll(".js-section-video-products-lazy:not(.js-section-video-products-lazy-loaded)").forEach(function(element) {
                        element.style.display = "block";
                        loadImages(element);
                        setTimeout(() => loadVideos(element), 300);
                        element.classList.add("js-section-video-products-lazy-loaded");
                    });
                }
            }, 100); // Reduzido de 1000ms para 100ms

		{# /* // Home slider */ #}

        var width = window.innerWidth;
        if (width > 767) {
            var slider_autoplay = {delay: 6000,};
        } else {
            var slider_autoplay = false;
        }

        var preloadImagesValue = false;
        var lazyValue = true;
        var loopValue = true;
        var paginationClickableValue = true;

        function arrowsColor() {
            if(jQueryNuvem(".js-home-slider").find('.swiper-slide-active').hasClass("swiper-light")){
                jQueryNuvem(".js-home-slider").addClass("swiper-arrows-light");
            } else {
                jQueryNuvem(".js-home-slider").removeClass("swiper-arrows-light");
            }
        }

        createSwiper(
            '.js-home-slider', {
                preloadImages: preloadImagesValue,
                lazy: lazyValue,
                {% if settings.slider | length > 1 %}
                    loop: loopValue,
                {% endif %}
                autoplay: slider_autoplay,
                pagination: {
                    el: '.js-swiper-home-pagination',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next',
                    prevEl: '.js-swiper-home-prev',
                },
                on: {
                  init: arrowsColor,
                  slideChangeTransitionEnd: arrowsColor,
                },
            },
            function(swiperInstance) {
                window.homeSwiper = swiperInstance;
            }
        );

        function arrowsMobileColor() {
            if(jQueryNuvem(".js-home-slider-mobile").find('.swiper-slide-active').hasClass("swiper-light")){
                jQueryNuvem(".js-home-slider-mobile").addClass("swiper-arrows-light");
            } else {
                jQueryNuvem(".js-home-slider-mobile").removeClass("swiper-arrows-light");
            }
        }

        createSwiper(
            '.js-home-slider-mobile', {
                preloadImages: preloadImagesValue,
                lazy: lazyValue,
                {% if settings.slider_mobile | length > 1 %}
                    loop: loopValue,
                {% endif %}
                autoplay: slider_autoplay,
                pagination: {
                    el: '.js-swiper-home-pagination-mobile',
                    clickable: paginationClickableValue,
                },
                navigation: {
                    nextEl: '.js-swiper-home-next-mobile',
                    prevEl: '.js-swiper-home-prev-mobile',
                },
                on: {
                  init: arrowsMobileColor,
                  slideChangeTransitionEnd: arrowsMobileColor,
                },
            },
            function(swiperInstance) {
                window.homeMobileSwiper = swiperInstance;
            }
        );

        {% if settings.slider | length == 1 %}
            jQueryNuvem('.js-swiper-home .swiper-wrapper').addClass( "disabled" );
            jQueryNuvem('.js-swiper-home-pagination, .js-swiper-home-prev, .js-swiper-home-next').remove();
        {% endif %}

        {% if settings.slider_mobile | length == 1 %}
            jQueryNuvem('.js-swiper-home-pagination-mobile, .js-swiper-home-prev-mobile, .js-swiper-home-next-mobile').remove();
        {% endif %}

        {# /* // Products slider */ #}

        {% set has_featured_products_slider = sections.primary.products and (settings.featured_products_format_mobile == 'slider' or settings.featured_products_format_desktop == 'slider') %}
        {% set has_new_products_slider = sections.new.products and (settings.new_products_format_mobile == 'slider' or settings.new_products_format_desktop == 'slider') %}
        {% set has_sale_products_slider = sections.sale.products and (settings.sale_products_format_mobile == 'slider' or settings.sale_products_format_desktop == 'slider') %}
        {% set has_promotion_products_slider = sections.promotion.products and (settings.promotion_products_format_mobile == 'slider' or settings.promotion_products_format_desktop == 'slider') %}
        

        {% if (has_featured_products_slider or has_new_products_slider or has_sale_products_slider or has_promotion_products_slider or has_best_seller_products_slider) or theme_editor %}

            var lazyVal = true;
            var watchOverflowVal = true;
            var centerInsufficientSlidesVal = true;

            {% if has_featured_products_slider or theme_editor %}

                {% set featured_desktop_slider = settings.featured_products_format_desktop == 'slider' %}
                {% set featured_only_mobile_slider = settings.featured_products_format_mobile == 'slider' and settings.featured_products_format_desktop != 'slider' %}
                {% set featured_only_desktop_slider = settings.featured_products_format_desktop == 'slider' and settings.featured_products_format_mobile != 'slider' %}
                {% set featured_columns_desktop = settings.featured_products_desktop %}
                {% set featured_columns_mobile = settings.featured_products_mobile %}
                var slidesPerViewFeaturedDesktopVal = {% if featured_columns_desktop == 4 %}4{% elseif featured_columns_desktop == 5 %}5{% else %}6{% endif %};
                var slidesPerViewFeaturedMobileVal = {% if featured_columns_mobile == 1 %}1.15{% else %}2.25{% endif %};

                {% if featured_only_mobile_slider %}
                    if (window.innerWidth < 768) {
                {% elseif featured_only_desktop_slider %}
                    if (window.innerWidth > 768) {
                {% endif %}
                    createSwiper('.js-swiper-featured', {
                        lazy: lazyVal,
                        watchOverflow: watchOverflowVal,
                        centerInsufficientSlides: centerInsufficientSlidesVal,
                        threshold: 5,
                        watchSlideProgress: true,
                        watchSlidesVisibility: true,
                        slideVisibleClass: 'js-swiper-slide-visible',
                        spaceBetween: itemSwiperSpaceBetween,
                    {% if sections.primary.products | length > 4 %}
                        loop: true,
                    {% endif %}
                        navigation: {
                            nextEl: '.js-swiper-featured-next',
                            prevEl: '.js-swiper-featured-prev',
                        },
                        on: {
                            afterInit: function () {
                                hideSwiperControls(".js-swiper-featured-prev", ".js-swiper-featured-next");
                            },
                        },
                        slidesPerView: slidesPerViewFeaturedMobileVal,
                    {% if featured_desktop_slider %}
                        breakpoints: {
                            768: {
                                slidesPerView: slidesPerViewFeaturedDesktopVal,
                            }
                        }
                    {% endif %}
                    },
                    function(swiperInstance) {
                        window.productsFeaturedSwiper = swiperInstance;
                    });
                {% if featured_only_mobile_slider or featured_only_desktop_slider %}
                    }
                {% endif %}

            {% endif %}

            {% if has_new_products_slider or theme_editor %}

                {% set new_desktop_slider = settings.new_products_format_desktop == 'slider' %}
                {% set new_only_mobile_slider = settings.new_products_format_mobile == 'slider' and settings.new_products_format_desktop != 'slider' %}
                {% set new_only_desktop_slider = settings.new_products_format_desktop == 'slider' and settings.new_products_format_mobile != 'slider' %}
                {% set new_columns_desktop = settings.new_products_desktop %}
                {% set new_columns_mobile = settings.new_products_mobile %}
                var slidesPerViewNewDesktopVal = {% if new_columns_desktop == 4 %}4{% elseif new_columns_desktop == 5 %}5{% else %}6{% endif %};
                var slidesPerViewNewMobileVal = {% if new_columns_mobile == 1 %}1.15{% else %}2.25{% endif %};

                {% if new_only_mobile_slider %}
                    if (window.innerWidth < 768) {
                {% elseif new_only_desktop_slider %}
                    if (window.innerWidth > 768) {
                {% endif %}
                    createSwiper('.js-swiper-new', {
                        lazy: lazyVal,
                        watchOverflow: watchOverflowVal,
                        centerInsufficientSlides: centerInsufficientSlidesVal,
                        threshold: 5,
                        watchSlideProgress: true,
                        watchSlidesVisibility: true,
                        slideVisibleClass: 'js-swiper-slide-visible',
                        spaceBetween: itemSwiperSpaceBetween,
                    {% if sections.new.products | length > 4 %}
                        loop: true,
                    {% endif %}
                        navigation: {
                            nextEl: '.js-swiper-new-next',
                            prevEl: '.js-swiper-new-prev',
                        },
                        on: {
                            afterInit: function () {
                                hideSwiperControls(".js-swiper-new-prev", ".js-swiper-new-next");
                            },
                        },
                        slidesPerView: slidesPerViewNewMobileVal,
                    {% if new_desktop_slider %}
                        breakpoints: {
                            768: {
                                slidesPerView: slidesPerViewNewDesktopVal,
                            }
                        }
                    {% endif %}
                    },
                    function(swiperInstance) {
                        window.productsNewSwiper = swiperInstance;
                    });
                {% if new_only_mobile_slider or new_only_desktop_slider %}
                    }
                {% endif %}

            {% endif %}

            {% if has_sale_products_slider or theme_editor %}

                {% set sale_desktop_slider = settings.sale_products_format_desktop == 'slider' %}
                {% set sale_only_mobile_slider = settings.sale_products_format_mobile == 'slider' and settings.sale_products_format_desktop != 'slider' %}
                {% set sale_only_desktop_slider = settings.sale_products_format_desktop == 'slider' and settings.sale_products_format_mobile != 'slider' %}
                {% set sale_columns_desktop = settings.sale_products_desktop %}
                {% set sale_columns_mobile = settings.sale_products_mobile %}
                var slidesPerViewSaleDesktopVal = {% if sale_columns_desktop == 4 %}4{% elseif sale_columns_desktop == 5 %}5{% else %}6{% endif %};
                var slidesPerViewSaleMobileVal = {% if sale_columns_mobile == 1 %}1.15{% else %}2.25{% endif %};

                {% if sale_only_mobile_slider %}
                    if (window.innerWidth < 768) {
                {% elseif sale_only_desktop_slider %}
                    if (window.innerWidth > 768) {
                {% endif %}
                    createSwiper('.js-swiper-sale', {
                        lazy: lazyVal,
                        watchOverflow: watchOverflowVal,
                        centerInsufficientSlides: centerInsufficientSlidesVal,
                        threshold: 5,
                        watchSlideProgress: true,
                        watchSlidesVisibility: true,
                        slideVisibleClass: 'js-swiper-slide-visible',
                        spaceBetween: itemSwiperSpaceBetween,
                    {% if sections.sale.products | length > 4 %}
                        loop: true,
                    {% endif %}
                        navigation: {
                            nextEl: '.js-swiper-sale-next',
                            prevEl: '.js-swiper-sale-prev',
                        },
                        on: {
                            afterInit: function () {
                                hideSwiperControls(".js-swiper-sale-prev", ".js-swiper-sale-next");
                            },
                        },
                        slidesPerView: slidesPerViewSaleMobileVal,
                    {% if sale_desktop_slider %}
                        breakpoints: {
                            768: {
                                slidesPerView: slidesPerViewSaleDesktopVal,
                            }
                        }
                    {% endif %}
                    },
                    function(swiperInstance) {
                        window.productsSaleSwiper = swiperInstance;
                    });
                {% if sale_only_mobile_slider or sale_only_desktop_slider %}
                    }
                {% endif %}

            {% endif %}

            {% if has_promotion_products_slider or theme_editor %}

                {% set promotion_desktop_slider = settings.promotion_products_format_desktop == 'slider' %}
                {% set promotion_only_mobile_slider = settings.promotion_products_format_mobile == 'slider' and settings.promotion_products_format_desktop != 'slider' %}
                {% set promotion_only_desktop_slider = settings.promotion_products_format_desktop == 'slider' and settings.promotion_products_format_mobile != 'slider' %}
                {% set promotion_columns_desktop = settings.promotion_products_desktop %}
                {% set promotion_columns_mobile = settings.promotion_products_mobile %}
                var slidesPerViewPromotionDesktopVal = {% if promotion_columns_desktop == 4 %}4{% elseif promotion_columns_desktop == 5 %}5{% else %}6{% endif %};
                var slidesPerViewPromotionMobileVal = {% if promotion_columns_mobile == 1 %}1.15{% else %}2.25{% endif %};

                {% if promotion_only_mobile_slider %}
                    if (window.innerWidth < 768) {
                {% elseif promotion_only_desktop_slider %}
                    if (window.innerWidth > 768) {
                {% endif %}
                    createSwiper('.js-swiper-promotion', {
                        lazy: lazyVal,
                        watchOverflow: watchOverflowVal,
                        centerInsufficientSlides: centerInsufficientSlidesVal,
                        threshold: 5,
                        watchSlideProgress: true,
                        watchSlidesVisibility: true,
                        slideVisibleClass: 'js-swiper-slide-visible',
                        spaceBetween: itemSwiperSpaceBetween,
                    {% if sections.promotion.products | length > 4 %}
                        loop: true,
                    {% endif %}
                        navigation: {
                            nextEl: '.js-swiper-promotion-next',
                            prevEl: '.js-swiper-promotion-prev',
                        },
                        on: {
                            afterInit: function () {
                                hideSwiperControls(".js-swiper-promotion-prev", ".js-swiper-promotion-next");
                            },
                        },
                        slidesPerView: slidesPerViewPromotionMobileVal,
                    {% if promotion_desktop_slider %}
                        breakpoints: {
                            768: {
                                slidesPerView: slidesPerViewPromotionDesktopVal,
                            }
                        }
                    {% endif %}
                    },
                    function(swiperInstance) {
                        window.productsPromotionSwiper = swiperInstance;
                    });
                {% if promotion_only_mobile_slider or promotion_only_desktop_slider %}
                    }
                {% endif %}

            {% endif %}

        {% endif %}

        {# /* // Home demo products slider */ #}

        window.swiperLoader('.js-swiper-featured-demo', {
            lazy: true,
            loop: true,
            watchOverflow: true,
            spaceBetween: itemSwiperSpaceBetween,
            slidesPerView: slidesPerViewMobileVal,
            navigation: {
                nextEl: '.js-swiper-featured-demo-next',
                prevEl: '.js-swiper-featured-demo-prev',
            },
            pagination: {
                el: '.js-swiper-featured-demo-pagination',
                type: 'fraction',
            },
            breakpoints: {
                768: {
                    slidesPerView: slidesPerViewDesktopVal,
                }
            }
        });

        {# /* // Brands slider */ #}

        {% if settings.brands and settings.brands is not empty %}

            createSwiper('.js-swiper-brands', {
                lazy: true,
                watchOverflow: true,
                centerInsufficientSlides: true,
                threshold: 5,
                slidesPerView: 3,
                navigation: {
                    nextEl: '.js-swiper-brands-next',
                    prevEl: '.js-swiper-brands-prev',
                },
                on: {
                    afterInit: function () {
                        hideSwiperControls(".js-swiper-brands-prev", ".js-swiper-brands-next");
                    },
                    {% if settings.brands | length > 3 and settings.brands | length < 6  %}
                        beforeInit: function () {
                            if (window.innerWidth > 768) {
                                jQueryNuvem(".js-swiper-brands-wrapper").addClass("justify-content-center");
                            }
                        },
                    {% endif %}
                },
                breakpoints: {
                    768: {
                        slidesPerView: 10,
                    }
                }
            });

        {% endif %}

        {# Swiper used for demo component #}

        createSwiper('.js-swiper-brands-demo', {
            lazy: true,
            watchOverflow: true,
            centerInsufficientSlides: true,
            threshold: 5,
            slidesPerView: 3,
            navigation: {
                nextEl: '.js-swiper-brands-next-demo',
                prevEl: '.js-swiper-brands-prev-demo',
            },
            breakpoints: {
                768: {
                    slidesPerView: 10,
                }
            }
        });

        {# /* // Testimonials slider */ #}

        {% set has_testimonial_01 = settings.testimonial_01_description or settings.testimonial_01_name or "testimonial_01.jpg" | has_custom_image %}
        {% set has_testimonial_02 = settings.testimonial_02_description or settings.testimonial_02_name or "testimonial_02.jpg" | has_custom_image %}
        {% set has_testimonial_03 = settings.testimonial_03_description or settings.testimonial_03_name or "testimonial_03.jpg" | has_custom_image %}
        {% set has_testimonial_04 = settings.testimonial_04_description or settings.testimonial_04_name or "testimonial_04.jpg" | has_custom_image %}
        {% set has_testimonials = (has_testimonial_01 and has_testimonial_02) or (has_testimonial_01 and has_testimonial_03) or (has_testimonial_01 and has_testimonial_04) or (has_testimonial_02 and has_testimonial_03) or (has_testimonial_02 and has_testimonial_04) or (has_testimonial_03 and has_testimonial_04)  %}

        {% if has_testimonial_01 or has_testimonial_02 or has_testimonial_03 or has_testimonial_04 %}

            createSwiper('.js-swiper-testimonials', {
                lazy: true,
                {% if has_testimonials %}
                    slidesPerView: 1.15,
                {% endif %}
                centerInsufficientSlides: true,
                watchOverflow: true,
                threshold: 5,
                spaceBetween: itemSwiperSpaceBetween,
                breakpoints: {
                    768: {
                        slidesPerView: 4,
                    }
                }
            });

        {% endif %}

        {# Swiper used for demo component #}

        createSwiper('.js-swiper-testimonials-demo', {
            lazy: true,
            slidesPerView: 1.15,
            centerInsufficientSlides: true,
            watchOverflow: true,
            threshold: 5,
            spaceBetween: itemSwiperSpaceBetween,
             breakpoints: {
                768: {
                    slidesPerView: 4,
                }
            }
        });

        {# /* // Banner services slider */ #}

        {% set has_banner_services_01 = settings.banner_services_01_title or settings.banner_services_01_description %}
        {% set has_banner_services_02 = settings.banner_services_02_title or settings.banner_services_02_description %}
        {% set has_banner_services_03 = settings.banner_services_03_title or settings.banner_services_03_description %}
        {% set has_banner_services_04 = settings.banner_services_04_title or settings.banner_services_04_description %}
        {% set has_banner_services = settings.banner_services and (has_banner_services_01 or has_banner_services_02 or has_banner_services_03 or has_banner_services_04) %}
        {% set has_multiple_banners_services = (has_banner_services_01 and has_banner_services_02) or (has_banner_services_01 and has_banner_services_03) or (has_banner_services_01 and has_banner_services_04) or (has_banner_services_02 and has_banner_services_03) or (has_banner_services_02 and has_banner_services_04) or (has_banner_services_03 and has_banner_services_04) %}

        {% if has_banner_services %}

            createSwiper('.js-informative-banners', {
                {% if has_multiple_banners_services %}
                    loop: true,
                    slidesPerView: 1.25,
                {% endif %}
                centerInsufficientSlides: true,
                watchOverflow: true,
                threshold: 5,
                spaceBetween: 25,
                breakpoints: {
                    768: {
                        slidesPerView: 'auto',
                        loop: false,
                    }
                }
            });
        {% endif %}

        {# Swiper used for demo component #}

        createSwiper('.js-informative-banners-demo', {
            loop: true,
            slidesPerView: 1.25,
            centerInsufficientSlides: true,
            watchOverflow: true,
            threshold: 5,
            spaceBetween: 25,
            breakpoints: {
                768: {
                    slidesPerView: 'auto',
                    loop: false,
                }
            }
        });

        {# /* // Banners slider */ #}

        {% if settings.banner_format_mobile == 'slider' or settings.banner_format_desktop == 'slider' and (settings.banner and settings.banner is not empty) %}

            {% set banner_desktop_slider = settings.banner_format_desktop == 'slider' %}
            {% set banner_only_mobile_slider = settings.banner_format_mobile == 'slider' and settings.banner_format_desktop != 'slider' %}
            {% set banner_only_desktop_slider = settings.banner_format_desktop == 'slider' and settings.banner_format_mobile != 'slider' %}
            {% set banner_columns_desktop = settings.banner_columns_desktop %}

            var bannersPerViewDesktopVal = {% if banner_columns_desktop == 4 %}4{% elseif banner_columns_desktop == 3 %}3{% elseif banner_columns_desktop == 2 %}2{% else %}1{% endif %};
            var bannersSpaceBetween = {% if settings.banner_without_margins %}0{% else %}itemSwiperSpaceBetween{% endif %};

            {% if banner_only_mobile_slider %}
                if (window.innerWidth < 768) {
            {% elseif banner_only_desktop_slider %}
                if (window.innerWidth > 768) {
            {% endif %}
                createSwiper('.js-swiper-banners', {
                    lazy: true,
                    watchOverflow: true,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    spaceBetween: bannersSpaceBetween,
                    navigation: {
                        nextEl: '.js-swiper-banners-next',
                        prevEl: '.js-swiper-banners-prev',
                    },
                    slidesPerView: 1.15,
                    on: {
                        afterInit: function () {
                            hideSwiperControls(".js-swiper-banners-prev", ".js-swiper-banners-next");
                        },
                    },
                {% if banner_desktop_slider %}
                    breakpoints: {
                        768: {
                            slidesPerView: bannersPerViewDesktopVal,
                        }
                    },
                {% endif %}
                },
                function(swiperInstance) {
                    window.homeBannerSwiper = swiperInstance;
                });
            {% if banner_only_mobile_slider or banner_only_desktop_slider %}
                }
            {% endif %}

        {% endif %}

        {% if settings.banner_promotional_format_mobile == 'slider' or settings.banner_promotional_format_desktop == 'slider' and (settings.banner_promotional and settings.banner_promotional is not empty) %}

            {% set banner_promotional_desktop_slider = settings.banner_promotional_format_desktop == 'slider' %}
            {% set banner_promotional_only_mobile_slider = settings.banner_promotional_format_mobile == 'slider' and settings.banner_promotional_format_desktop != 'slider' %}
            {% set banner_promotional_only_desktop_slider = settings.banner_promotional_format_desktop == 'slider' and settings.banner_promotional_format_mobile != 'slider' %}
            {% set banner_promotional_columns_desktop = settings.banner_promotional_columns_desktop %}

            var bannersPromotionalPerViewDesktopVal = {% if banner_promotional_columns_desktop == 4 %}4{% elseif banner_promotional_columns_desktop == 3 %}3{% elseif banner_promotional_columns_desktop == 2 %}2{% else %}1{% endif %};
            var bannersPromotionalSpaceBetween = {% if settings.banner_promotional_without_margins %}0{% else %}itemSwiperSpaceBetween{% endif %};

            {% if banner_promotional_only_mobile_slider %}
                if (window.innerWidth < 768) {
            {% elseif banner_promotional_only_desktop_slider %}
                if (window.innerWidth > 768) {
            {% endif %}
                createSwiper('.js-swiper-banners-promotional', {
                    lazy: true,
                    watchOverflow: true,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    spaceBetween: bannersPromotionalSpaceBetween,
                    navigation: {
                        nextEl: '.js-swiper-banners-promotional-next',
                        prevEl: '.js-swiper-banners-promotional-prev',
                    },
                    on: {
                        afterInit: function () {
                            hideSwiperControls(".js-swiper-banners-promotional-prev", ".js-swiper-banners-promotional-next");
                        },
                    },
                    slidesPerView: 1.15,
                {% if banner_promotional_desktop_slider %}
                    breakpoints: {
                        768: {
                            slidesPerView: bannersPromotionalPerViewDesktopVal,
                        }
                    },
                {% endif %}
                },
                function(swiperInstance) {
                    window.homeBannerPromotionalSwiper = swiperInstance;
                });
            {% if banner_promotional_only_mobile_slider or banner_promotional_only_desktop_slider %}
                }
            {% endif %}

        {% endif %}

        {% if settings.banner_news_format_mobile == 'slider' or settings.banner_news_format_desktop == 'slider' and (settings.banner_news and settings.banner_news is not empty) %}

            {% set banner_news_desktop_slider = settings.banner_news_format_desktop == 'slider' %}
            {% set banner_news_only_mobile_slider = settings.banner_news_format_mobile == 'slider' and settings.banner_news_format_desktop != 'slider' %}
            {% set banner_news_only_desktop_slider = settings.banner_news_format_desktop == 'slider' and settings.banner_news_format_mobile != 'slider' %}
            {% set banner_news_columns_desktop = settings.banner_news_columns_desktop %}

            var bannersNewsPerViewDesktopVal = {% if banner_news_columns_desktop == 4 %}4{% elseif banner_news_columns_desktop == 3 %}3{% elseif banner_news_columns_desktop == 2 %}2{% else %}1{% endif %};
            var bannersNewsSpaceBetween = {% if settings.banner_news_without_margins %}0{% else %}itemSwiperSpaceBetween{% endif %};

            {% if banner_news_only_mobile_slider %}
                if (window.innerWidth < 768) {
            {% elseif banner_news_only_desktop_slider %}
                if (window.innerWidth > 768) {
            {% endif %}
                createSwiper('.js-swiper-banners-news', {
                    lazy: true,
                    watchOverflow: true,
                    threshold: 5,
                    watchSlideProgress: true,
                    watchSlidesVisibility: true,
                    slideVisibleClass: 'js-swiper-slide-visible',
                    spaceBetween: bannersNewsSpaceBetween,
                    navigation: {
                        nextEl: '.js-swiper-banners-news-next',
                        prevEl: '.js-swiper-banners-news-prev',
                    },
                    on: {
                        afterInit: function () {
                            hideSwiperControls(".js-swiper-banners-news-prev", ".js-swiper-banners-news-next");
                        },
                    },
                    slidesPerView: 1.15,
                {% if banner_news_desktop_slider %}
                    breakpoints: {
                        768: {
                            slidesPerView: bannersNewsPerViewDesktopVal,
                        }
                    },
                {% endif %}
                },
                function(swiperInstance) {
                    window.homeBannerNewsSwiper = swiperInstance;
                });
            {% if banner_news_only_mobile_slider or banner_news_only_desktop_slider %}
                }
            {% endif %}

        {% endif %}

        {% if settings.show_instafeed and store.instagram and store.hasInstagramToken() %}
            createSwiper('.js-swiper-instafeed', {
                lazy: true,
                watchOverflow: true,
                spaceBetween: itemSwiperSpaceBetween,
                slidesPerView: 1.15,
                observer: true,
                breakpoints: {
                    768: {
                        slidesPerView: 3,
                    }
                }
            });
        {% endif %}

        {# /* // Main categories */ #}

        {% if settings.main_categories %}

            createSwiper('.js-swiper-categories', {
                lazy: true,
                {% if settings.slider_categories | length > 3 %}
                    loop: true,
                {% endif %}
                preloadImages : false,
                watchOverflow: true,
                watchSlidesVisibility : true,
                centerInsufficientSlides: true,
                slidesPerView: 2.2,
                centeredSlides: true,
                spaceBetween: 20,
                navigation: {
                    nextEl: '.js-swiper-categories-next',
                    prevEl: '.js-swiper-categories-prev',
                },
                on: {
                    afterInit: function () {
                        hideSwiperControls(".js-swiper-categories-prev", ".js-swiper-categories-next");
                    },
                },
                breakpoints: {
                    768: {
                        loop: false,
                        centeredSlides: false,
                        slidesPerView: 'auto',
                    }
                }
            });

        {% endif %}

        {# Swiper used for demo component #}

        createSwiper('.js-swiper-categories-demo', {
            lazy: true,
            loop: true,
            preloadImages : false,
            watchOverflow: true,
            watchSlidesVisibility : true,
            centerInsufficientSlides: true,
            slidesPerView: 2.2,
            centeredSlides: true,
            spaceBetween: 20,
            navigation: {
                nextEl: '.js-swiper-categories-next-demo',
                prevEl: '.js-swiper-categories-prev-demo',
            },
            
            breakpoints: {
                768: {
                    loop: false,
                    centeredSlides: false,
                    slidesPerView: 'auto',
                }
            }
        });

        {# /* // Product description toggle */ #}

        {% if sections.featured.products %}
            if (jQueryNuvem('.js-product-description').height() < jQueryNuvem('.js-product-description').prop("scrollHeight")){
                jQueryNuvem(".js-view-description").show();
            }

            jQueryNuvem(document).on("click", ".js-view-description", function(e) {
                e.preventDefault();
                jQueryNuvem(this).prev(".js-product-description").toggleClass("product-description-full");
                jQueryNuvem(".js-view-more, .js-view-less").toggle();
            });
        {% endif %}

	{% endif %}

    {% if template == 'product' %}

        {# /* // Product Related */ #}

        // Set loop for related products products sliders

        function calculateRelatedLoopVal(sectionSelector) {
            let productsAmount = jQueryNuvem(sectionSelector).attr("data-related-amount");
            let loopVal = false;
            const applyLoop = (window.innerWidth < 768 && productsAmount > slidesPerViewMobileVal) || (window.innerWidth > 768 && productsAmount > slidesPerViewDesktopVal);
            
            if (applyLoop) {
                loopVal = true;
            }
            
            return loopVal;
        }

        let alternativeLoopVal = calculateRelatedLoopVal(".js-related-products");
        let complementaryLoopVal = calculateRelatedLoopVal(".js-complementary-products");

        {# Alternative products #}

         createSwiper('.js-swiper-related', {
            lazy: true,
            loop: alternativeLoopVal,
            watchOverflow: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            spaceBetween: itemSwiperSpaceBetween,
            slideVisibleClass: 'js-swiper-slide-visible',
            slidesPerView: slidesPerViewMobileVal,
            navigation: {
                nextEl: '.js-swiper-related-next',
                prevEl: '.js-swiper-related-prev',
            },
            on: {
                afterInit: function () {
                    hideSwiperControls(".js-swiper-related-prev", ".js-swiper-related-next");
                },
            },
            breakpoints: {
                768: {
                    slidesPerView: slidesPerViewDesktopVal,
                }
            }
        });

        {# Complementary products #}

        createSwiper('.js-swiper-complementary', {
            lazy: true,
            loop: complementaryLoopVal,
            watchOverflow: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            spaceBetween: itemSwiperSpaceBetween,
            slideVisibleClass: 'js-swiper-slide-visible',
            slidesPerView: slidesPerViewMobileVal,
            navigation: {
                nextEl: '.js-swiper-complementary-next',
                prevEl: '.js-swiper-complementary-prev',
            },
            on: {
                afterInit: function () {
                    hideSwiperControls(".js-swiper-complementary-prev", ".js-swiper-complementary-next");
                },
            },
            breakpoints: {
                768: {
                    slidesPerView: slidesPerViewDesktopVal,
                }
            }
        });

    {% endif %}

	{#/*============================================================================
	  #Social
	==============================================================================*/ #}

    {% if template == 'home' and settings.video_embed %}
        {% set video_url = settings.video_embed %}
        {% if '/watch?v=' in settings.video_embed %}
            {% set video_format = '/watch?v=' %}
        {% elseif '/youtu.be/' in settings.video_embed %}
            {% set video_format = '/youtu.be/' %}
        {% elseif '/shorts/' in settings.video_embed %}
            {% set video_format = '/shorts/' %}
        {% endif %}
        {% set video_id = video_url|split(video_format)|last %}

        {# /* // Youtube video with autoplay */ #}

        function loadVideoFrame() {
            window.youtubeIframeService.executeOnReady(() => { 
                new YT.Player('player', {
                        width: '100%',
                        videoId: '{{video_id}}',
                        playerVars: { 'autoplay': 1, 'playsinline': 1, 'rel': 0, 'loop': 1, 'autopause': 0, 'controls': 0, 'showinfo': 0, 'modestbranding': 1, 'branding': 0, 'fs': 0, 'iv_load_policy': 3 },
                        events: {
                            'onReady': onPlayerReady,
                            'onStateChange':onPlayerStateChange
                        }
                    }
                );
            });
        };

        {% if settings.home_order_position_1 == 'video' and settings.video_type == 'autoplay' %}
            if (window.innerWidth < 768) {
                window.addEventListener("pointerdown", () => {
                    loadVideoFrame();
                }, { once: true });
            } else {
                loadVideoFrame();
            }
        {% else %}
            {% if settings.video_type == 'autoplay' %}
                jQueryNuvem('.js-home-video-container').on('lazyloaded', function(e){
                    loadVideoFrame();
                });
            {% else %}
                jQueryNuvem('.js-play-button').on("click", function(e){
                    e.preventDefault();
                    jQueryNuvem(this).hide();
                    jQueryNuvem(".js-home-video-image").hide();
                    loadVideoFrame();
                });
            {% endif %}
        {% endif %}
        

        function onPlayerReady(event) {
            {% if settings.video_type == 'autoplay' %}
                event.target.mute();
            {% endif %}
            event.target.playVideo();
        }

        function onPlayerStateChange(event) {
            {% if settings.home_order_position_1 == 'video' %}
                if (event.data == YT.PlayerState.PLAYING) {
                    jQueryNuvem(".js-home-video-image").addClass("fade-in");
                }
            {% endif %}
            if (event.data == YT.PlayerState.ENDED) {
                event.target.seekTo(0);
                event.target.playVideo();
            }
        }

    {% endif %}

    {% if template == 'product' and product.video_url %}
        {% set video_url = product.video_url %}
        {# /* // Youtube or Vimeo video for home or each product */ #}
        LS.loadVideo('{{ video_url }}');
    {% endif %}


	{#/*============================================================================
	  #Product grid
	==============================================================================*/ #}

    {# /* // Secondary image on mouseover */ #}
    
    {% if settings.product_hover %}
        if (window.innerWidth > 767) {
            jQueryNuvem(document).on("mouseover", ".js-item-with-secondary-image:not(.item-with-two-images)", function(e) {
                var secondary_image_to_show = jQueryNuvem(this).find(".js-item-image-secondary");
                secondary_image_to_show.show();
                secondary_image_to_show.on('lazyloaded', function(e){
                    jQueryNuvem(e.currentTarget).closest(".js-item-with-secondary-image").addClass("item-with-two-images");
                });
            });
        }
    {% endif %}

    var nav_height = jQueryNuvem(".js-head-main").innerHeight();

	{% if template == 'category' or (template == 'search' and search_filter )%}

        {# /* // Fixed category controls */ #}

            // Default no-op so callers (mobile scroll handler) never hit
            // "can't find variable: offsetCategories" if the page loaded at
            // desktop width and was later resized below 768px.
            var offsetCategories = function() {};

            if (window.innerWidth < 768) {

                $category_controls.css("top" , nav_height.toString() + 'px');

                {# Detect if category controls are sticky and add css #}

                var observer = new IntersectionObserver(function(entries) {
                    if(entries[0].intersectionRatio === 0)
                        $category_controls.addClass("is-sticky");
                    else if(entries[0].intersectionRatio === 1)
                        $category_controls.removeClass("is-sticky");
                    }, { threshold: [0,1]
                });
                // Guard against missing sentinel element — observer.observe(null) throws.
                var $categoryControlsPrev = document.querySelector(".js-category-controls-prev");
                if ($categoryControlsPrev) {
                    observer.observe($categoryControlsPrev);
                }

                var lastCategoriesOffsetValue = null;
                // Performance: Cache DOM queries outside the scroll listener
                var $sticky_category_controls = jQueryNuvem(".js-category-controls");
                var $head_main = jQueryNuvem(".js-head-main");

                offsetCategories = function() {
                    var categoriesOffset = $head_main.outerHeight();

                    if($head_main.hasClass("compress")){
                        var categoriesOffset = categoriesOffset - topbarHeight - 1;
                    }

                    if (lastCategoriesOffsetValue !== categoriesOffset) {
                        $sticky_category_controls.css('top', (categoriesOffset).toString() + 'px' );
                        lastCategoriesOffsetValue = categoriesOffset;
                    }
                };

                offsetCategories();

                // Performance: Throttle scroll event with requestAnimationFrame to prevent layout thrashing
                var isOffsetCategoriesTicking = false;
                document.addEventListener("scroll", function(){
                    if (!isOffsetCategoriesTicking) {
                        window.requestAnimationFrame(function() {
                            offsetCategories();
                            isOffsetCategoriesTicking = false;
                        });
                        isOffsetCategoriesTicking = true;
                    }
                }, { passive: true });

            }

        {# /* // Filters */ #}

        {% if has_applied_filters %}
            jQueryNuvem('.js-filter-container').each(function(el) {
                const filterActive = jQueryNuvem(el).find(".js-filter-checkbox [type=checkbox]:checked");
                filterActive.closest(".js-filter-container").find(".js-filters-badge").text(filterActive.length).show();
            });
            const applied_filters = jQueryNuvem("#nav-filters .js-remove-filter-chip").length;
            jQueryNuvem(".js-filters-total-badge").text(applied_filters);
        {% endif %}

		{# /* // Sort by */ #}

        function applySortBy(element, isFromSelect) {
            var params = LS.urlParams;

            if(isFromSelect){
                params['sort_by'] = jQueryNuvem(element).val();
            }else{
                params['sort_by'] = jQueryNuvem(element).attr('data-sort-value');
            }

            var sort_params_array = [];
            for (var key in params) {
                if (!['results_only', 'page'].includes(key)) {
                    sort_params_array.push(key + '=' + params[key]);
                }
            }
            var sort_params = sort_params_array.join('&');
            window.location = window.location.pathname + '?' + sort_params;
        }

        jQueryNuvem(document).on("click", ".js-apply-sort", function(e) {
            e.preventDefault();
            jQueryNuvem(".js-apply-sort").removeClass("selected");

            var thisElement = jQueryNuvem(this);

            thisElement.addClass("selected");
            applySortBy(thisElement, false);
            if (window.innerWidth < 768) {
                jQueryNuvem(".js-sorting-overlay, .js-filtering-spinner").show();
            }
        });

        jQueryNuvem('.js-sort-by').on("change", function (e) {

            var thisElement = jQueryNuvem(this);
            applySortBy(thisElement, true);

        });

	{% endif %}

    {% if settings.pagination == 'infinite' and (template == 'category' or template == 'search') %}

        !function() {

        	{# /* // Infinite scroll */ #}

            {% if pages.current == 1 and not pages.is_last %}

                {% if settings.grid_columns_desktop == '5' %}
                    const products_per_page_value = 15;
                {% else %}
                    const products_per_page_value = 12;
                {% endif %}
                
                LS.hybridScroll({
                    productGridSelector: '.js-product-table',
                    spinnerSelector: '#js-infinite-scroll-spinner',
                    loadMoreButtonSelector: '.js-load-more',
                    hideWhileScrollingSelector: ".js-hide-footer-while-scrolling",
                    productsBeforeLoadMoreButton: 199,
                    productsPerPage: products_per_page_value,
                    afterLoaded: function(){
                        jQueryNuvem('.js-item-product').addClass('is-inViewport');
                    },
                });
            {% endif %}
        }();

	{% endif %}

    {# /* // Variants without stock */ #}

    {% set is_button_variant = settings.bullet_variants or settings.image_color_variants %}

    {% if is_button_variant %}
        const noStockVariants = (container = null) => {

            {# Configuration for variant elements #}
            const config = {
                variantsGroup: ".js-product-variants-group",
                variantButton: ".js-insta-variant",
                noStockClass: "btn-variant-no-stock",
                dataOption: "data-option"
            };

            {# Product container wrapper #}
            const wrapper = container ? container : jQueryNuvem('#single-product');
            if (!wrapper || !wrapper.length) return;

            {# Fetch the variants data from the container #}
            let dataVariants = wrapper.data('variants');
            if (typeof dataVariants === 'string') {
                try { dataVariants = JSON.parse(dataVariants); } catch (e) { return; }
            }
            if (!Array.isArray(dataVariants) || !dataVariants.length) return;

            {# Iterate variation groups by DOM position (option0/1/2 map to position, not variation.id). #}
            const allGroups = wrapper.find(config.variantsGroup);
            const variantsLength = allGroups.length;
            if (!variantsLength) return;

            {# Get selected options from product variations #}
            const getOptions = (productVariationId, variantOption) => {
                const options = {};
                for (let i = 0; i < productVariationId; i++) {
                    options[`option${i}`] = String(allGroups.eq(i).find('select').val());
                }
                options[`option${productVariationId}`] = String(jQueryNuvem(variantOption).attr('data-option'));
                return options;
            };

            {# Filter available variants based on selected options #}
            const filterVariants = (options) => {
                return dataVariants.filter(variant => {
                    return Object.keys(options).every(optionKey => variant[optionKey] === options[optionKey]) && variant.available;
                });
            };

            {# Update stock status for variant buttons #}
            const updateStockStatus = (productVariationId) => {
                const variationGroup = allGroups.eq(productVariationId);
                variationGroup.find(`${config.variantButton}.${config.noStockClass}`).removeClass(config.noStockClass);

                variationGroup.find(config.variantButton).each((variantOption, item) => {
                    const options = getOptions(productVariationId, variantOption);
                    const itemsAvailable = filterVariants(options);
                    const optionId = options[`option${productVariationId}`].replace(/"/g, '\\"');
                    const button = variationGroup.find(`${config.variantButton}[${config.dataOption}="${optionId}"]`);

                    if (!itemsAvailable.length) {
                        button.addClass(config.noStockClass);
                    }
                });
            };

            {# Iterate through all variant and update stock status #}
            for (let productVariationId = variantsLength - 1; productVariationId >= 0; productVariationId--) {
                updateStockStatus(productVariationId);
            }
        };

        noStockVariants();

    {% endif %}

    {% if settings.quick_shop %}

        {# /* // Quickshop */ #}

        jQueryNuvem(document).on("click", ".js-quickshop-modal-open", function (e) {
            e.preventDefault();
            var $this = jQueryNuvem(this);
            if($this.hasClass("js-quickshop-slide")){
                jQueryNuvem("#quickshop-modal .js-item-product").addClass("js-swiper-slide-visible js-item-slide");
            }

            {% if is_button_variant %}
                {# Updates variants without stock #}
                let container = jQueryNuvem(this).closest('.js-quickshop-container');
                if (!container.length) return;
                noStockVariants(container);
            {% endif %}

            LS.fillQuickshop($this);

            if (window.innerWidth < 768) {
                {# Image dimensions #}

                var product_image_dimension = jQueryNuvem(this).closest('.js-item-product').find('.js-item-image-padding').attr("style");
                jQueryNuvem("#quickshop-modal .js-quickshop-image-padding").attr("style", product_image_dimension);

                {# Add bottom space to ensure CTA visibility when not bottom sheet #}

                var quickshop_height = jQueryNuvem("#quickshop-modal").height();
                var quickshop_header_height = jQueryNuvem("#quickshop-modal .js-quickshop-header").height();

                if(window.innerHeight < (quickshop_height + 1)){
                    jQueryNuvem("#quickshop-form").css("marginBottom" , quickshop_header_height + "px");
                }
            }
        });

    {% endif %}

    {% if settings.bullet_variants or settings.product_color_variants or settings.image_color_variants %}
        changeVariantButton = function(selector, parentSelector) {
            selector.siblings().removeClass("selected");
            selector.addClass("selected");
            var option_id = selector.attr('data-option');
            var parent = selector.closest(parentSelector);
            var selected_option = parent.find('.js-variation-option option').filter(function (el) {
                return el.value == option_id;
            });
            selected_option.prop('selected', true).trigger('change');
            parent.find('.js-insta-variation-label').html(option_id);
        }

        {% if settings.bullet_variants or settings.image_color_variants %}
            {# /* // Color and size variations */ #}

            jQueryNuvem(document).on("click", ".js-insta-variant", function (e) {
                e.preventDefault();
                $this = jQueryNuvem(this);
                changeVariantButton($this, '.js-product-variants-group');
            });

        {% endif %}


        {% if settings.product_color_variants %}

            {# Product color variations #}
            if (window.innerWidth > 767) {
                jQueryNuvem(document).on("click", ".js-color-variant", function(e) {
                    e.preventDefault();
                    $this = jQueryNuvem(this);
                    changeVariantButton($this, '.js-item-product');
                });
            }
        {% endif %}

    {% endif %}

    {% if settings.quick_shop or settings.product_color_variants %}

        LS.registerOnChangeVariant(function(variant){
            {# Show product image on color change #}
            var current_image = jQueryNuvem('.js-item-product[data-product-id="'+variant.product_id+'"] .js-item-image');
            current_image.attr('srcset', variant.image_url);

            {% if settings.product_hover %}
                {# Remove secondary feature on image updated from changeVariant #}
                current_image.closest(".js-item-with-secondary-image").removeClass("item-with-two-images");
            {% endif %}
        });

    {% endif %}

    {#/*============================================================================
	  #Product detail functions
	==============================================================================*/ #}

	{# /* // Installments */ #}

	{# Installments without interest #}

	function get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests) {
	    if (parseInt(number_of_installment) > parseInt(max_installments_without_interests[0])) {
	        if (installment_data.without_interests) {
	            return [number_of_installment, installment_data.installment_value.toFixed(2)];
	        }
	    }
	    return max_installments_without_interests;
	}

	{# Installments with interest #}

	function get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests) {
	    if (parseInt(number_of_installment) > parseInt(max_installments_with_interests[0])) {
	        if (installment_data.without_interests == false) {
	            return [number_of_installment, installment_data.installment_value.toFixed(2)];
	        }
	    }
	    return max_installments_with_interests;
	}

	{# Updates installments on payment popup for native integrations #}

	function refreshInstallmentv2(price){
        jQueryNuvem(".js-modal-installment-price" ).each(function( el ) {
	        const installment = Number(jQueryNuvem(el).data('installment'));
	        jQueryNuvem(el).text(LS.currency.display_short + (price/installment).toLocaleString('de-DE', {maximumFractionDigits: 2, minimumFractionDigits: 2}));
	    });
	}

    {# Refresh price on payments popup with payment discount applied #}

    function refreshPaymentDiscount(price){
        jQueryNuvem(".js-price-with-discount" ).each(function( el ) {
            const payment_discount = jQueryNuvem(el).data('paymentDiscount');
            jQueryNuvem(el).text(LS.formatToCurrency(price - ((price * payment_discount) / 100)))
        });
    }

    {% set should_show_discount = product.maxPaymentDiscount.value > 0 %}
    {% if should_show_discount %}

        {# Shows/hides price with discount and strikethrough original price for every payment method #}

        function togglePaymentDiscounts(variant){
            jQueryNuvem(".js-payment-method-total").each(function( paymentMethodTotalElement ){
                const priceComparerElement = jQueryNuvem(paymentMethodTotalElement).find(".js-compare-price-display");
                const installmentsOnePaymentElement = jQueryNuvem(paymentMethodTotalElement).find('.js-installments-no-discount');
                const priceWithDiscountElement = jQueryNuvem(paymentMethodTotalElement).find('.js-price-with-discount');

                priceComparerElement.hide();
                installmentsOnePaymentElement.hide();
                priceWithDiscountElement.hide();

                const discount = priceWithDiscountElement.data('paymentDiscount');

                if (discount > 0 && showMaxPaymentDiscount(variant)){
                    priceComparerElement.show();
                    priceWithDiscountElement.show()
                } else {
                    installmentsOnePaymentElement.show();
                }
            })
        }

        {# Toggle discount and discount disclaimer both on product details and popup #}

        function updateDiscountDisclaimers(variant){
            updateProductDiscountDisclaimer(variant);
            updatePopupDiscountDisclaimers(variant);
        }

        {# Toggle discount and discount disclaimer in product details #}

        function updateProductDiscountDisclaimer(variant){
            jQueryNuvem(".js-product-discount-container, .js-product-discount-disclaimer").hide();

            if (showMaxPaymentDiscount(variant)){
                jQueryNuvem(".js-product-discount-container").show();
            }

            if (showMaxPaymentDiscountNotCombinableDisclaimer(variant)){
                jQueryNuvem(".js-product-discount-disclaimer").show();
            }
        }

        {# Shows/hides discount message for payment method and discount disclaimer in popup, for every payment method #}

        function updatePopupDiscountDisclaimers(variant){
            jQueryNuvem(".js-modal-tab-discount, .js-payment-method-discount").hide();

            {% if product.maxPaymentDiscount.value > 0 %}
                if (showMaxPaymentDiscount(variant)){
                    {% for key, method in product.payment_methods_config %}
                        {% if method.max_discount > 0 %}
                            {% if method.allows_discount_combination %}
                                jQueryNuvem("#method_{{ key | sanitize }} .js-modal-tab-discount").show();
                            {% elseif not product.free_shipping %}
                                if (!variantHasPromotionalPrice(variant)){
                                    jQueryNuvem("#method_{{ key | sanitize }} .js-modal-tab-discount").show();
                                }
                            {% endif %}
                        {% endif %}
                    {% endfor %}
                }
            {% endif %}

            jQueryNuvem(".js-info-payment-method-container").each(function(infoPaymentMethodElement){
                {# For each payment method this will show the payment method discount and discount explanation #}

                const infoPaymentMethod = jQueryNuvem(infoPaymentMethodElement)
                infoPaymentMethod.find(".js-discount-explanation").hide();
                infoPaymentMethod.find(".js-discount-disclaimer").hide();

                const priceWithDiscountElement = infoPaymentMethod.find('.js-price-with-discount');
                const discount = priceWithDiscountElement.data('paymentDiscount');

                if (discount > 0 && showMaxPaymentDiscount(variant)){
                    infoPaymentMethod.find(".js-discount-explanation").show();
                    infoPaymentMethod.find(".js-payment-method-discount").show();
                }

                if (discount > 0 && showMaxPaymentDiscountNotCombinableDisclaimer(variant)){
                    infoPaymentMethod.find(".js-discount-disclaimer").show();
                }
            })
        }

        function variantHasPromotionalPrice(variant) { return variant.compare_at_price_number > variant.price_number }

        function showMaxPaymentDiscount(variant) {
            {% if product.maxPaymentDiscount()["allowsDiscountCombination"] %}
                return true;
            {% elseif product.free_shipping %}
                return false
            {% else %}
                return !variantHasPromotionalPrice(variant);
            {% endif %}
        }

        function showMaxPaymentDiscountNotCombinableDisclaimer(variant) {
            {% if product.maxPaymentDiscount()["allowsDiscountCombination"] %}
                return false
            {% elseif product.free_shipping %}
                return false
            {% else %}
                return !variantHasPromotionalPrice(variant)
            {% endif %}
        }

    {% endif %}

	{# /* // Change variant */ #}

	{# Updates price, installments, labels and CTA on variant change #}

	function changeVariant(variant) {
        jQueryNuvem(".js-product-detail .js-shipping-calculator-response").hide();
        jQueryNuvem("#shipping-variant-id").val(variant.id);

	    var parent = jQueryNuvem("body");
	    if (variant.element) {
            parent = jQueryNuvem(variant.element);
            if(parent.hasClass("js-quickshop-container")){
                var quick_id = parent.attr("data-quickshop-id");
                var parent = jQueryNuvem('.js-quickshop-container[data-quickshop-id="'+quick_id+'"]');
            }
	    }

        {% if is_button_variant %}
            {# Updates variants without stock #}
            if(parent.hasClass("js-quickshop-container")){
                var itemContainer = parent.closest('.js-item-product');
                if(itemContainer.hasClass("js-item-slide")){
                    var parent = jQueryNuvem('.js-swiper-slide-visible .js-quickshop-container[data-quickshop-id="'+quick_id+'"]');
                }
                noStockVariants(parent);
            } else {
                noStockVariants();
            }
        {% endif %}

	    var sku = parent.find('.js-product-sku');
	    if(sku.length) {
	        sku.text(variant.sku).show();
	    }

	    {% if settings.product_stock %}
	        var stock = parent.find('.js-product-stock');
	        stock.text(variant.stock).show();
	    {% endif %}

        {# Updates installments on list item and inside payment popup for Payments Apps #}
        
	    var installment_helper = function($element, amount, price){
	        $element.find('.js-installment-amount').text(amount);
	        $element.find('.js-installment-price').attr("data-value", price);
	        $element.find('.js-installment-price').text(LS.currency.display_short + parseFloat(price).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        if(variant.price_short && Math.abs(variant.price_number - price * amount) < 1) {
	            $element.find('.js-installment-total-price').text((variant.price_short).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        } else {
	            $element.find('.js-installment-total-price').text(LS.currency.display_short + (price * amount).toLocaleString('de-DE', { minimumFractionDigits: 2 }));
	        }
	    };

	    if (variant.installments_data) {
	        var variant_installments = JSON.parse(variant.installments_data);
	        var max_installments_without_interests = [0,0];
	        var max_installments_with_interests = [0,0];

	        {# Hide all installments rows on payments modal #}
	        jQueryNuvem('.js-payment-provider-installments-row').hide();

	        for (let payment_method in variant_installments) {

	            {# Identifies the minimum installment value #}
	            var paymentMethodId = '#installment_' + payment_method.replace(" ", "_") + '_1';
	            var minimumInstallmentValue = jQueryNuvem(paymentMethodId).closest('.js-info-payment-method').attr("data-minimum-installment-value");

                let installments = variant_installments[payment_method];
	            for (let number_of_installment in installments) {
                    let installment_data = installments[number_of_installment];
	                max_installments_without_interests = get_max_installments_without_interests(number_of_installment, installment_data, max_installments_without_interests);
	                max_installments_with_interests = get_max_installments_with_interests(number_of_installment, installment_data, max_installments_with_interests);
	                var installment_container_selector = '#installment_' + payment_method.replace(" ", "_") + '_' + number_of_installment;

	                {# Shows installments rows on payments modal according to the minimum value #}
	                if(minimumInstallmentValue <= installment_data.installment_value) {
	                    jQueryNuvem(installment_container_selector).show();
	                }

	                if(!parent.hasClass("js-quickshop-container")){
	                    installment_helper(jQueryNuvem(installment_container_selector), number_of_installment, installment_data.installment_value.toFixed(2));
	                }
	            }
	        }
	        var $installments_container = jQueryNuvem(variant.element + ' .js-max-installments-container .js-max-installments');
	        var $installments_modal_link = jQueryNuvem(variant.element + ' #btn-installments');
	        var $payments_module = jQueryNuvem(variant.element + ' .js-product-payments-container');
	        var $installmens_card_icon = jQueryNuvem(variant.element + ' .js-installments-credit-card-icon');

	        {% if product.has_direct_payment_only %}
	        var installments_to_use = max_installments_without_interests[0] >= 1 ? max_installments_without_interests : max_installments_with_interests;

	        if(installments_to_use[0] <= 0 ) {
	        {%  else %}
	        var installments_to_use = max_installments_without_interests[0] > 1 ? max_installments_without_interests : max_installments_with_interests;

	        if(installments_to_use[0] <= 1 ) {
	        {% endif %}
	            $installments_container.hide();
	            $installments_modal_link.hide();
	            $payments_module.hide();
	            $installmens_card_icon.hide();
	        } else {
	            $installments_container.show();
	            $installments_modal_link.show();
	            $payments_module.show();
	            $installmens_card_icon.show();
	            installment_helper($installments_container, installments_to_use[0], installments_to_use[1]);
	        }
	    }

	    if(!parent.hasClass("js-quickshop-container")){
            jQueryNuvem('#installments-modal .js-installments-one-payment').text(variant.price_short).attr("data-value", variant.price_number);
		}

	    if (variant.price_short){
	        parent.find('.js-price-display').text(variant.price_short).show();
	        parent.find('.js-price-display').attr("content", variant.price_number).data('productPrice', variant.price_number_raw);

            parent.find('.js-payment-discount-price-product').text(variant.price_with_payment_discount_short);
            parent.find('.js-payment-discount-price-product-container').show();
	    } else {
	        parent.find('.js-price-display, .js-payment-discount-price-product-container').hide();
	    }

	    if ((variant.compare_at_price_short) && !(parent.find(".js-price-display").css("display") == "none")) {
	        parent.find('.js-compare-price-display').text(variant.compare_at_price_short).show();
	    } else {
	        parent.find('.js-compare-price-display').hide();
	    }

        var button = parent.find('.js-addtocart');
        const quickshopButtonWording = parent.find('.js-open-quickshop-wording');
        const quickshopButtonIcon = parent.find('.js-open-quickshop-icon');
        button.removeClass('cart').removeClass('contact').removeClass('nostock');
        var $product_shipping_calculator = parent.find("#product-shipping-container");

        {# Update CTA wording and status #}

	    {% if not store.is_catalog %}
            if (!variant.available){
                button.val('{{ "Sin stock" | translate }}');
                button.addClass('nostock');
                button.attr('disabled', 'disabled');
                quickshopButtonWording.text('{{ "Sin stock" | translate }}');
                quickshopButtonIcon.addClass("d-none").removeClass("d-md-inline");
                $product_shipping_calculator.hide();
            } else if (variant.contact) {
                button.val('{{ "Consultar precio" | translate }}');
                button.addClass('contact');
                button.removeAttr('disabled');
                quickshopButtonWording.text('{{ "Consultar precio" | translate }}');
                quickshopButtonIcon.addClass("d-none").removeClass("d-md-inline");
                $product_shipping_calculator.hide();
            } else {
                button.val('{{ "Agregar al carrito" | translate }}');
                button.addClass('cart');
                button.removeAttr('disabled');
                quickshopButtonWording.text('{{ "Comprar" | translate }}');
                quickshopButtonIcon.addClass("d-md-inline");
                $product_shipping_calculator.show();
            }

	    {% endif %}

        {% if template == 'product' %}
            const base_price = Number(jQueryNuvem("#price_display").attr("content"));
            refreshInstallmentv2(base_price);
            refreshPaymentDiscount(variant.price_number);
            {% if should_show_discount %}
                togglePaymentDiscounts(variant);
                updateDiscountDisclaimers(variant);
            {% endif %}
        {% endif %}

        {% if settings.last_product %}
            if(variant.stock == 1) {
                parent.find('.js-last-product').show();
            } else {
                parent.find('.js-last-product').hide();
            }
        {% endif %}


        {# Update shipping on variant change #}

        LS.updateShippingProduct();

        zipcode_on_changevariant = jQueryNuvem("#product-shipping-container .js-shipping-input").val();
        jQueryNuvem("#product-shipping-container .js-shipping-calculator-current-zip").text(zipcode_on_changevariant);

        {% if cart.free_shipping.min_price_free_shipping.min_price %}
            {# Updates free shipping bar #}

            LS.freeShippingProgress(true, parent);

        {% endif %}
	}

	{# /* // Trigger change variant */ #}

    jQueryNuvem(document).on("change", ".js-variation-option", function(e) {
        var $parent = jQueryNuvem(this).closest(".js-product-variants");
        var $variants_group = jQueryNuvem(this).closest(".js-product-variants-group");
        var $quickshop_parent_wrapper = jQueryNuvem(this).closest(".js-quickshop-container");

        {# If quickshop is used from modal, use quickshop-id from the item that opened it #}

        var quick_id = $quickshop_parent_wrapper.attr("data-quickshop-id");

        if($parent.hasClass("js-product-quickshop-variants")){

            var $quickshop_parent = jQueryNuvem(this).closest(".js-item-product");

            {# Target visible slider item if necessary #}
            
            if($quickshop_parent.hasClass("js-item-slide")){
                var $quickshop_variant_selector = '.js-swiper-slide-visible .js-quickshop-container[data-quickshop-id="'+quick_id+'"]';
            }else{
                var $quickshop_variant_selector = '.js-quickshop-container[data-quickshop-id="'+quick_id+'"]';
            }

            LS.changeVariant(changeVariant, $quickshop_variant_selector);

            {% if settings.product_color_variants or settings.bullet_variants or settings.image_color_variants %}
                {# Match selected color variant with selected quickshop variant #}

                var selected_option_id = jQueryNuvem(this).val();
                var $color_parent_to_update = jQueryNuvem('.js-quickshop-container[data-quickshop-id="'+quick_id+'"]');

                {# Update all color buttons on several places (quickshop, item, product detail) #}
                $color_parent_to_update.find('.js-color-variant[data-option="'+selected_option_id+'"]').addClass("selected").siblings().removeClass("selected");
                {# Update this specific variant button #}
                $variants_group.find('.js-insta-variant[data-option="'+selected_option_id+'"]').addClass("selected").siblings().removeClass("selected");
            {% endif %}

        } else {
            LS.changeVariant(changeVariant, '#single-product');
        }

        {# Offer and discount labels update #}

        var $this_product_container = jQueryNuvem(this).closest(".js-product-container");

        if($this_product_container.hasClass("js-quickshop-container")){
            var this_quickshop_id = $this_product_container.attr("data-quickshop-id");
            var $this_product_container = jQueryNuvem('.js-product-container[data-quickshop-id="'+this_quickshop_id+'"]');
        }
        var $this_compare_price = $this_product_container.find(".js-compare-price-display");
        var $this_price = $this_product_container.find(".js-price-display");
        var $installment_container = $this_product_container.find(".js-product-payments-container");
        var $installment_text = $this_product_container.find(".js-max-installments-container");
        var $this_add_to_cart = $this_product_container.find(".js-prod-submit-form");

        // Get the current product discount percentage value
        var current_percentage_value = $this_product_container.find(".js-offer-percentage");

        // Get the current product price and promotional price
        var compare_price_value = $this_compare_price.html();
        var price_value = $this_price.html();

        // Calculate new discount percentage based on difference between filtered old and new prices
        const percentageDifference = window.moneyDifferenceCalculator.percentageDifferenceFromString(compare_price_value, price_value);
        if(percentageDifference){
            $this_product_container.find(".js-offer-percentage").text(percentageDifference);
            $this_product_container.find(".js-offer-label").css("display" , "table");
        }

        if ($this_compare_price.css("display") == "none" || !percentageDifference) {
            $this_product_container.find(".js-offer-label").hide();
        }
        if ($this_add_to_cart.hasClass("nostock")) {
            $this_product_container.find(".js-stock-label").show();
            $this_product_container.find(".js-offer-label").hide();
        }
        else {
            $this_product_container.find(".js-stock-label").hide();
	    }
	    if ($this_price.css('display') == 'none'){
	        $installment_container.hide();
	        $installment_text.hide();
	    }else{
	        $installment_text.show();
	    }
	});

	{# /* // Submit to contact */ #}

	{# Submit to contact form when product has no price #}

    jQueryNuvem(".js-product-form").on("submit", function (e) {
	    var button = jQueryNuvem(e.currentTarget).find('[type="submit"]');
	    button.attr('disabled', 'disabled');
	    if ((button.hasClass('contact')) || (button.hasClass('catalog'))) {
	        e.preventDefault();
	        var product_id = jQueryNuvem(e.currentTarget).find("input[name='add_to_cart']").val();
	        window.location = "{{ store.contact_url | escape('js') }}?product=" + product_id;
	    } else if (button.hasClass('cart')) {
	        button.val('{{ "Agregando..." | translate }}');
	    }
	});

	{% if template == 'product' or (template == 'home' and sections.featured.products) %}

        var has_multiple_slides = false;

        {% if template == 'product' and (product.images_count > 1 or video_url) %}
            var has_multiple_slides = true;
        {% else %}
            var product_images_amount = jQueryNuvem(".js-swiper-product").attr("data-product-images-amount");
            if(product_images_amount > 1) {
                var has_multiple_slides = true;
            }
        {% endif %}

	    {# /* // Product slider */ #}

        {% if template == 'product' %}

            {% block product_fancybox %}
                Fancybox.bind('[data-fancybox="product-gallery"]', {
                    Toolbar: {
                        items: {
                            close: {
                                html: '<svg class="icon-inline icon-lg svg-icon-text"><use xlink:href="#times"/></svg>',
                            },
                            counter: {
                                class: 'pt-2 mt-1',
                                type: 'div',
                                html: '<span data-fancybox-index=""></span>&nbsp;/&nbsp;<span data-fancybox-count=""></span>',
                                position: 'center',
                            },
                        },
                    },
                    Carousel: {
                        Navigation: {
                            classNames: {
                                button: 'btn',
                                next: 'swiper-button-next',
                                prev: 'swiper-button-prev',
                            },
                            prevTpl: '<svg class="icon-inline icon-lg svg-icon-invert icon-flip-horizontal"><use xlink:href="#chevron"/></svg>',
                            nextTpl: '<svg class="icon-inline icon-lg svg-icon-invert"><use xlink:href="#chevron"/></svg>',
                        },
                    },
                    Thumbs: { autoStart: false },
                    on: {
                        shouldClose: (fancybox, slide) => {
                            {# Update position of the slider #}
                            productSwiper.slideTo( fancybox.getSlide().index, 0 );
                        },
                    },
                });
            {% endblock %}
        {% endif %}

        function productSliderNav(){

            var width = window.innerWidth;

            var productSwiper = null;

            createSwiper(
                '.js-swiper-product', {
                    lazy: true,
                    loop: false,
                    centeredSlides: false,
                    slidesPerView: 1.15,
                    threshold: 5,
                    centerInsufficientSlides: true,
                    watchOverflow: true,
                    pagination: {
                        el: '.js-swiper-product-pagination',
                    },
                    navigation: {
                        nextEl: '.js-swiper-product-next',
                        prevEl: '.js-swiper-product-prev',
                    },
                    breakpoints: {
                        768: {
                            slidesPerView: 1,
                        }
                    },
     
                    on: {
                        init: function () {
                            jQueryNuvem(".js-product-slider-placeholder").hide();
                            jQueryNuvem(".js-swiper-product").css("visibility", "visible").css("height", "auto");
                            {% if product.video_url and template == 'product' %}
                                if (window.innerWidth < 768) {
                                    productSwiperHeight = jQueryNuvem(".js-swiper-product").height();
                                    jQueryNuvem(".js-product-video-slide").height(productSwiperHeight);
                                }
                            {% endif %}
                        },
                        {% if product.video_url and template == 'product' %}
                            slideChangeTransitionEnd: function () {
                                if(jQueryNuvem(".js-product-video-slide").hasClass("swiper-slide-active")){
                                    jQueryNuvem(".js-labels-group").fadeOut(100);
                                }else{
                                    jQueryNuvem(".js-labels-group").fadeIn(100);
                                }
                                jQueryNuvem('.js-video').show();
                                jQueryNuvem('.js-video-iframe').hide().find("iframe").remove();
                            },
                        {% endif %}
                    },
                },
                function(swiperInstance) {
                    productSwiper = swiperInstance;
                }
            );

            {% if template == 'product' %}
                {{ block ('product_fancybox') }}
            {% endif %}

            if(has_multiple_slides){
                LS.registerOnChangeVariant(function(variant){
                    var liImage = jQueryNuvem('.js-swiper-product').find("[data-image='"+variant.image+"']");
                    var selectedPosition = liImage.data('imagePosition');
                    var slideToGo = parseInt(selectedPosition);
                    productSwiper.slideTo(slideToGo);
                    jQueryNuvem(".js-product-slide-img").removeClass("js-active-variant");
                    liImage.find(".js-product-slide-img").addClass("js-active-variant");
                });

                jQueryNuvem(".js-product-thumb").on("click", function(e){
                    e.preventDefault();
                    jQueryNuvem(".js-product-thumb").removeClass("selected");
                    jQueryNuvem(e.currentTarget).addClass("selected");
                    var thumbLoop = jQueryNuvem(e.currentTarget).data("thumbLoop");
                    var slideToGo = parseInt(thumbLoop);
                    productSwiper.slideTo(slideToGo);
                    if(jQueryNuvem(e.currentTarget).hasClass("js-product-thumb-modal")){
                        jQueryNuvem('.js-swiper-product').find("[data-image-position='"+slideToGo+"'] .js-product-slide-link").trigger('click');
                    }
                });
            }
        }

        var directionVal = 'vertical';

        {% if template == 'product' %}
            if (window.innerWidth < 767) {
                var directionVal = 'horizontal';
            }
        {% endif %}

        createSwiper('.js-swiper-product-thumbs', {
            lazy: true,
            watchOverflow: true,
            threshold: 5,
            direction: directionVal,
            navigation: {
                nextEl: '.js-swiper-product-thumbs-next',
                prevEl: '.js-swiper-product-thumbs-prev',
            },
            slidesPerView: 'auto',
            on: {
                afterInit: function () {
                    hideSwiperControls(".js-swiper-product-thumbs-prev", ".js-swiper-product-thumbs-next");
                },
            },
        });

        productSliderNav()

        {# /* // Pinterest sharing */ #}

        jQueryNuvem('.js-pinterest-share').on("click", function(e){
            e.preventDefault();
            jQueryNuvem(".pinterest-hidden a").get()[0].click();
        });

	{% endif %}

    {# Product quantity #}

    jQueryNuvem(document).on("click", ".js-quantity .js-quantity-up", function (e) {
        $quantity_input = jQueryNuvem(this).closest(".js-quantity").find(".js-quantity-input");
        $quantity_input.val( parseInt($quantity_input.val(), 10) + 1);
    });

    jQueryNuvem(document).on("click", ".js-quantity .js-quantity-down", function (e) {
        $quantity_input = jQueryNuvem(this).closest(".js-quantity").find(".js-quantity-input");
        quantity_input_val = $quantity_input.val();
        if (quantity_input_val>1) {
            $quantity_input.val( parseInt($quantity_input.val(), 10) - 1);
        }
    });


	{#/*============================================================================
	  #Cart
	==============================================================================*/ #}

    {% if cart.free_shipping.min_price_free_shipping.min_price %}

        {# Updates free progress on page load #}

        LS.freeShippingProgress(true);

    {% endif %}

    {# /* // Position of cart page summary */ #}

    var head_height = jQueryNuvem(".js-head-main").outerHeight();

    if (window.innerWidth > 768) {
        {% if settings.head_fix_desktop %}
            jQueryNuvem("#cart-sticky-summary").css("top" , (head_height + 10).toString() + 'px');
        {% else %}
            jQueryNuvem("#cart-sticky-summary").css("top" , "10px");
        {% endif %}
    }


    {# /* // Add to cart */ #}

    function getQuickShopImgSrc(element){
        const image = jQueryNuvem(element).closest('.js-quickshop-container').find('img');
        return String(image.attr('srcset')); 
    }

    jQueryNuvem(document).on("click", ".js-addtocart:not(.js-addtocart-placeholder)", function (e) {

        const dataStore = jQueryNuvem(this).data('store');

        if( dataStore == 'product-buy-button' && LS.template == 'product' ){
            e.preventDefault();
            const $customFields = document.querySelectorAll(`[data-store="product-form-${LS.product.id}"] .js-customization-input-validation`);

            let customFieldsValues = [];
            $customFields.forEach(function(field){
                if( jQueryNuvem(field).attr('required') && jQueryNuvem(field).val() == '' ){
                    customFieldsValues.push(false);
                    jQueryNuvem(field).closest('.lb-input-container').find('.lb-customization-input-validation-message').show();
                } else {
                    jQueryNuvem(field).closest('.lb-input-container').find('.lb-customization-input-validation-message').hide();
                    customFieldsValues.push(jQueryNuvem(field).val());
                }
            });

            if( customFieldsValues.includes(false) ){

                if( !jQueryNuvem('.customizations-container.active').length ){
                    jQueryNuvem('.js-cta-group-button').click();
                }
                // const validationMessage = jQueryNuvem(this).closest('.js-product-container').find('.lb-customization-input-validation-message[data-name="' + customFieldsValues.findIndex(value => value === false) + '"]').text();
                // alert('Por favor, preencha todos os campos obrigatórios.');
                return;
            }
        }

        {# Button variables for transitions on add to cart #}

        var $productContainer = jQueryNuvem(this).closest('.js-product-container');
        var $productVariants = $productContainer.find(".js-variation-option");
        var $productButton = $productContainer.find("input[type='submit'].js-addtocart");
        var productButtonWidth = $productButton.first(el => el.offsetWidth);
        var isQuickShop = $productContainer.hasClass('js-quickshop-container');
        if (isQuickShop) {
            var $productButtonContainer = $productButton.closest(".js-item-submit-container");
        }
        var $productButtonPlaceholder = $productContainer.find(".js-addtocart-placeholder");
        var $productButtonText = $productButtonPlaceholder.find(".js-addtocart-text");
        var $productButtonAdding = $productButtonPlaceholder.find(".js-addtocart-adding");
        var $productButtonSuccess = $productButtonPlaceholder.find(".js-addtocart-success");

        {# Added item information for notification #}

        if (!isQuickShop) {
            if(jQueryNuvem(".js-product-slide-img.js-active-variant").length) {
                var imageSrc = $productContainer.find('.js-product-slide-img.js-active-variant').data('srcset').split(' ')[0];
            } else {
                var imageSrc = $productContainer.find('.js-product-slide-img').data('srcset').split(' ')[0];
            }
            var quantity = $productContainer.find('.js-quantity-input').val();
            var name = $productContainer.find('.js-product-name').text();
            var price = $productContainer.find('.js-price-display').text();
            var addedToCartCopy = "{{ 'Agregar al carrito' | translate }}";
        } else {
            var imageSrc = getQuickShopImgSrc(this);
            var quantity = 1;
            var name = $productContainer.find('.js-item-name').text();
            var price = $productContainer.find('.js-price-display').text().trim();
            var addedToCartCopy = "{{ 'Comprar' | translate }}";
            if ($productContainer.hasClass("js-quickshop-has-variants")) {
                var addedToCartCopy = "{{ 'Agregar al carrito' | translate }}";
            }else{
                var addedToCartCopy = "{{ 'Comprar' | translate }}";
            }
        }

        if (!jQueryNuvem(this).hasClass('contact')) {

            {% if settings.ajax_cart %}
                e.preventDefault();
            {% endif %}

            {# Hide real button and show button placeholder during event #}

            $productButton.hide();
            if (isQuickShop) {
                $productButtonContainer.hide();
            }

            $productButtonPlaceholder.width(productButtonWidth).css('display' , 'block');
            $productButtonText.fadeOut();
            $productButtonAdding.addClass("active");

            {% if settings.ajax_cart %}

                var callback_add_to_cart = function(){

                    {# Fill notification info #}

                    jQueryNuvem('.js-cart-notification-item-img').attr('srcset', imageSrc);
                    jQueryNuvem('.js-cart-notification-item-name').text(name);
                    jQueryNuvem('.js-cart-notification-item-quantity').text(quantity);
                    jQueryNuvem('.js-cart-notification-item-price').text(price);

                    if($productVariants.length){
                        var output = [];

                        $productVariants.each( function(el){
                            var variants = jQueryNuvem(el);
                            output.push(variants.val());
                        });
                        jQueryNuvem(".js-cart-notification-item-variant-container").show();
                        jQueryNuvem(".js-cart-notification-item-variant").text(output.join(', '))
                    }else{
                        jQueryNuvem(".js-cart-notification-item-variant-container").hide();
                    }

                    {# Set products amount wording visibility #}

                    var cartItemsBadge = jQueryNuvem(".js-cart-widget-amount");
                    var cartItemsMoney = jQueryNuvem(".js-cart-widget-total");
                    var cartItemsAmount = cartItemsBadge.text();

                    cartItemsBadge.removeClass("d-none d-md-inline-block");
                    
                    if (window.innerWidth > 768) {
                        cartItemsMoney.removeClass("d-none d-md-inline-block");
                    }

                    if(cartItemsAmount > 1){
                        jQueryNuvem(".js-cart-counts-plural").show();
                        jQueryNuvem(".js-cart-counts-singular").hide();
                    }else{
                        jQueryNuvem(".js-cart-counts-singular").show();
                        jQueryNuvem(".js-cart-counts-plural").hide();
                    }

                    {# Show button placeholder with transitions #}

                    $productButtonAdding.removeClass("active");
                    $productButtonSuccess.addClass("active");
                    setTimeout(function(){
                        $productButtonSuccess.removeClass("active");
                        $productButtonText.fadeIn();
                    },2000);
                    setTimeout(function(){
                        $productButtonPlaceholder.removeAttr("style").hide();
                        $productButton.show();
                        if (isQuickShop) {
                            $productButtonContainer.show();
                        }
                    },3000);

                    $productContainer.find(".js-added-to-cart-product-message").slideDown();

                    if (isQuickShop) {
                        jQueryNuvem("#quickshop-modal").removeClass('modal-show');
                        jQueryNuvem(".js-modal-overlay[data-modal-id='#quickshop-modal']").hide();
                        jQueryNuvem("body").removeClass("overflow-none");
                        restoreQuickshopForm();
                        if (window.innerWidth < 768) {
                            cleanURLHash();
                        }
                    }

                    {# Show notification and hide it only after second added to cart #}

                    setTimeout(function(){
                        jQueryNuvem(".js-alert-added-to-cart").show().addClass("notification-visible").removeClass("notification-hidden");
                    },500);

                    if (!cookieService.get('first_product_added_successfully')) {
                        cookieService.set('first_product_added_successfully', 1, 7 );
                    } else{
                        setTimeout(function(){
                            jQueryNuvem(".js-alert-added-to-cart").removeClass("notification-visible").addClass("notification-hidden");
                            setTimeout(function(){
                                jQueryNuvem('.js-cart-notification-item-img').attr('src', '');
                                jQueryNuvem(".js-alert-added-to-cart").hide();
                            },2000);
                        },8000);
                    }


                    {# Update shipping input zipcode on add to cart #}

                    {# Use zipcode from input if user is in product page, or use zipcode cookie if is not #}

                    if (jQueryNuvem("#product-shipping-container .js-shipping-input").val()) {
                        zipcode_on_addtocart = jQueryNuvem("#product-shipping-container .js-shipping-input").val();
                        jQueryNuvem("#cart-shipping-container .js-shipping-input").val(zipcode_on_addtocart);
                        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_on_addtocart);
                    } else if (cookieService.get('calculator_zipcode')){
                        var zipcode_from_cookie = cookieService.get('calculator_zipcode');
                        jQueryNuvem('.js-shipping-input').val(zipcode_from_cookie);
                        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);
                    }


                    {# Update free shipping wording #}

                    jQueryNuvem(".js-fs-add-this-product").hide();
                    jQueryNuvem(".js-fs-add-one-more").show();

                }
                var callback_error = function(){
                    {# Restore real button visibility in case of error #}

                    $productButtonAdding.removeClass("active");
                    $productButtonText.fadeIn();
                    $productButtonPlaceholder.removeAttr("style").hide();
                    $productButton.show();
                    if (isQuickShop) {
                        $productButtonContainer.show();
                    }
                }
                $prod_form = jQueryNuvem(this).closest("form");
                LS.addToCartEnhanced(
                    $prod_form,
                    addedToCartCopy,
                    '{{ "Agregando..." | translate }}',
                    '{{ "No hay más stock de este producto." | translate }}',
                    {{ store.editable_ajax_cart_enabled ? 'true' : 'false' }},
                        callback_add_to_cart,
                        callback_error
                );
            {% endif %}
        }
    });


    {# /* // Cart quantitiy changes */ #}

    jQueryNuvem(document).on("keypress", ".js-cart-quantity-input", function (e) {
        if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
            return false;
        }
    });

    jQueryNuvem(document).on("focusout", ".js-cart-quantity-input", function (e) {
        var itemID = jQueryNuvem(this).attr("data-item-id");
        var itemVAL = jQueryNuvem(this).val();
        if (itemVAL == 0) {
            var r = confirm("{{ '¿Seguro que quieres borrar este artículo?' | translate }}");
            if (r == true) {
                LS.removeItem(itemID, true);
            } else {
                jQueryNuvem(this).val(1);
            }
        } else {
            LS.changeQuantity(itemID, itemVAL, true);
        }
    });

    {# /* // Empty cart alert */ #}

    jQueryNuvem(".js-trigger-empty-cart-alert").on("click", function (e) {
        e.preventDefault();
        let emptyCartAlert = jQueryNuvem(".js-mobile-nav-empty-cart-alert").fadeIn(100);
        setTimeout(() => emptyCartAlert.fadeOut(500), 1500);
    });

    {# /* // Update amount wording */ #}

    document.addEventListener( 'cart.released', () => {
        const cart_amount = jQueryNuvem(".js-cart-widget-amount").text();
        if(cart_amount == 1) {
            jQueryNuvem(".js-amount-one-item").show();
            jQueryNuvem(".js-amount-many-items").hide();
        }else{
            jQueryNuvem(".js-amount-one-item").hide();
            jQueryNuvem(".js-amount-many-items").show();
        }
    });

    {# /* // Go to checkout */ #}

    {# Clear cart notification cookie after consumers continues to checkout #}

    jQueryNuvem('form[action="{{ store.cart_url | escape('js') }}"]').on("submit", function() {
        cookieService.remove('first_product_added_successfully');
    });


	{#/*============================================================================
	  #Shipping calculator
	==============================================================================*/ #}

    {# /* // Update calculated cost wording */ #}

    {% if settings.shipping_calculator_cart_page %}
        if (jQueryNuvem('.js-selected-shipping-method').length) {
            var shipping_cost = jQueryNuvem('.js-selected-shipping-method').data("cost");
            var $shippingCost = jQueryNuvem("#shipping-cost");
            $shippingCost.text(shipping_cost);
            $shippingCost.removeClass('opacity-40');
        }
    {% endif %}

	{# /* // Select and save shipping function */ #}

    selectShippingOption = function(elem, save_option) {
        jQueryNuvem(".js-shipping-method, .js-branch-method").removeClass('js-selected-shipping-method');
        jQueryNuvem(elem).addClass('js-selected-shipping-method');

        {% if settings.shipping_calculator_cart_page %}

            var shipping_cost = jQueryNuvem(elem).data("cost");
            var shipping_price_clean = jQueryNuvem(elem).data("price");

            if(shipping_price_clean = 0.00){
                var shipping_cost = '{{ Gratis | translate }}'
            }

            // Updates shipping (ship and pickup) cost on cart
            var $shippingCost = jQueryNuvem("#shipping-cost");
            $shippingCost.text(shipping_cost);
            $shippingCost.removeClass('opacity-40');

        {% endif %}

        if (save_option) {
            LS.saveCalculatedShipping(true);
        }
        if (jQueryNuvem(elem).hasClass("js-shipping-method-hidden")) {
            {# Toggle other options visibility depending if they are pickup or delivery for cart and product at the same time #}
            if (jQueryNuvem(elem).hasClass("js-pickup-option")) {
                jQueryNuvem(".js-other-pickup-options, .js-show-other-pickup-options .js-shipping-see-less").show();
                jQueryNuvem(".js-show-other-pickup-options .js-shipping-see-more").hide();
            } else {
                jQueryNuvem(".js-other-shipping-options, .js-show-more-shipping-options .js-shipping-see-less").show();
                jQueryNuvem(".js-show-more-shipping-options .js-shipping-see-more").hide()
            }
        }
    };

    {# Apply zipcode saved by cookie if there is no zipcode saved on cart from backend #}

    if (cookieService.get('calculator_zipcode')) {

        {# If there is a cookie saved based on previous calcualtion, add it to the shipping input to triggert automatic calculation #}

        var zipcode_from_cookie = cookieService.get('calculator_zipcode');

        {% if settings.ajax_cart %}

            {# If ajax cart is active, target only product input to avoid extra calulation on empty cart #}

            jQueryNuvem('#product-shipping-container .js-shipping-input').val(zipcode_from_cookie);

        {% else %}

            {# If ajax cart is inactive, target the only input present on screen #}

            jQueryNuvem('.js-shipping-input').val(zipcode_from_cookie);

        {% endif %}

        jQueryNuvem(".js-shipping-calculator-current-zip").text(zipcode_from_cookie);

        {# Hide the shipping calculator and show spinner  #}

        jQueryNuvem(".js-shipping-calculator-head").addClass("with-zip").removeClass("with-form");
        jQueryNuvem(".js-shipping-calculator-with-zipcode").addClass("transition-up-active");
        jQueryNuvem(".js-shipping-calculator-spinner").show();
    } else {

        {# If there is no cookie saved, show calcualtor #}

        jQueryNuvem(".js-shipping-calculator-form").addClass("transition-up-active");
    }

    {# Remove shipping suboptions from DOM to avoid duplicated modals #}

    removeShippingSuboptions = function(){
        var shipping_suboptions_id = jQueryNuvem(".js-modal-shipping-suboptions").attr("id");
        jQueryNuvem("#" + shipping_suboptions_id).remove();
        jQueryNuvem('.js-modal-overlay[data-modal-id="#' + shipping_suboptions_id + '"').remove();
    };

    {# /* // Calculate shipping function */ #}


    jQueryNuvem(".js-calculate-shipping").on("click", function (e) {
	    e.preventDefault();

        {# Take the Zip code to all shipping calculators on screen #}
        let shipping_input_val = jQueryNuvem(e.currentTarget).closest(".js-shipping-calculator-form").find(".js-shipping-input").val();

        jQueryNuvem(".js-shipping-input").val(shipping_input_val);

        {# Calculate on page load for both calculators: Product and Cart #}

        if (jQueryNuvem(".js-cart-item").length) {
            LS.calculateShippingAjax(
            jQueryNuvem('#cart-shipping-container').find(".js-shipping-input").val(),
            '{{store.shipping_calculator_url | escape('js')}}',
            jQueryNuvem("#cart-shipping-container").closest(".js-shipping-calculator-container") );
        }

        jQueryNuvem(".js-shipping-calculator-current-zip").html(shipping_input_val);
        removeShippingSuboptions();
	});

	{# /* // Calculate shipping by submit */ #}

    jQueryNuvem(".js-shipping-input").on('keydown', function (e) {
	    var key = e.which ? e.which : e.keyCode;
	    var enterKey = 13;
	    if (key === enterKey) {
	        e.preventDefault();
            jQueryNuvem(e.currentTarget).closest(".js-shipping-calculator-form").find(".js-calculate-shipping").trigger('click');
	        if (window.innerWidth < 768) {
                jQueryNuvem(e.currentTarget).trigger('blur');
	        }
	    }
	});

    {# /* // Shipping and branch click */ #}

    jQueryNuvem(document).on("change", ".js-shipping-method, .js-branch-method", function (e) {
        selectShippingOption(this, true);
        jQueryNuvem(".js-shipping-method-unavailable").hide();
    });

    {# /* // Select shipping first option on results */ #}

    jQueryNuvem(document).on('shipping.options.checked', '.js-shipping-method', function (e) {
        let shippingPrice = jQueryNuvem(this).attr("data-price");
        LS.addToTotal(shippingPrice);

        let total = (LS.data.cart.total / 100) + parseFloat(shippingPrice);
        jQueryNuvem(".js-cart-widget-total").html(LS.formatToCurrency(total));

        selectShippingOption(this, false);
    });

    {# /* // Toggle more shipping options */ #}

    jQueryNuvem(document).on("click", ".js-toggle-more-shipping-options", function(e) {
	    e.preventDefault();

        {# Toggle other options depending if they are pickup or delivery for cart and product at the same time #}

        if(jQueryNuvem(this).hasClass("js-show-other-pickup-options")){
            jQueryNuvem(".js-other-pickup-options").slideToggle(600);
            jQueryNuvem(".js-show-other-pickup-options .js-shipping-see-less, .js-show-other-pickup-options .js-shipping-see-more").toggle();
        }else{
            jQueryNuvem(".js-other-shipping-options").slideToggle(600);
            jQueryNuvem(".js-show-more-shipping-options .js-shipping-see-less, .js-show-more-shipping-options .js-shipping-see-more").toggle();
        }
	});

    {# /* // Calculate shipping on page load */ #}

    {# Only shipping input has value, cart has saved shipping and there is no branch selected #}

    calculateCartShippingOnLoad = function() {
        {# Triggers function when a zipcode input is filled #}
        if (jQueryNuvem("#cart-shipping-container .js-shipping-input").val()) {
            // If user already had calculated shipping: recalculate shipping
            setTimeout(function() {
                LS.calculateShippingAjax(
                    jQueryNuvem('#cart-shipping-container').find(".js-shipping-input").val(),
                    '{{store.shipping_calculator_url | escape('js')}}',
                    jQueryNuvem("#cart-shipping-container").closest(".js-shipping-calculator-container") );
                removeShippingSuboptions();
                window.toggleAccordionPrivate("#cart-shipping-container .js-toggle-shipping");
            }, 100);
        }

        if (jQueryNuvem(".js-branch-method").hasClass('js-selected-shipping-method')) {
            {% if store.branches|length > 1 %}
                window.toggleAccordionPrivate("#cart-shipping-container .js-toggle-branches");
            {% endif %}
        }
    };

    {% if cart.has_shippable_products %}
        calculateCartShippingOnLoad();
    {% endif %}

    {# /* // Change CP */ #}

    jQueryNuvem(document).on("click", ".js-shipping-calculator-change-zipcode", function(e) {
        e.preventDefault();
        jQueryNuvem(".js-shipping-calculator-response").fadeOut(100);
        jQueryNuvem(".js-shipping-calculator-head").addClass("with-form").removeClass("with-zip");
        jQueryNuvem(".js-shipping-calculator-with-zipcode").removeClass("transition-up-active");
        jQueryNuvem(".js-shipping-calculator-form").addClass("transition-up-active");
    });

	{# /* // Shipping provinces */ #}

	{% if provinces_json %}
        jQueryNuvem('select[name="country"]').on("change", function (e) {
		    var provinces = {{ provinces_json | default('{}') | raw }};
		    LS.swapProvinces(provinces[jQueryNuvem(e.currentTarget).val()]);
		}).trigger('change');
	{% endif %}


    {# /* // Change store country: From invalid zipcode message */ #}

    jQueryNuvem(document).on("click", ".js-save-shipping-country", function(e) {

        e.preventDefault();

        {# Change shipping country #}

        lang_select_option = jQueryNuvem(this).closest(".js-modal-shipping-country");
        changeLang(lang_select_option);

        jQueryNuvem(this).text('{{ "Aplicando..." | translate }}').addClass("disabled");
    });

    {#/*============================================================================
      #Forms
    ==============================================================================*/ #}

    {# IOS form CSS to avoid autozoom on focus #}

    var isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
    if (isIOS) {
        var ios_input_fields = jQueryNuvem("input[type='text'], input[type='number'], input[type='password'], input[type='tel'], textarea, input[type='search'], input[type='hidden'], input[type='email']");
        ios_input_fields.addClass("form-control-ios");
        jQueryNuvem(".js-quantity").addClass("form-group-quantity-ios");
        jQueryNuvem(".js-cart-quantity-container").addClass("cart-quantity-container-ios");
        jQueryNuvem(".js-search-form").toggleClass("search-form-ios");
        jQueryNuvem(".js-price-filter-btn").addClass("price-btn-ios");
        jQueryNuvem(".js-price-filter-empty").addClass("input-clear-content-ios");
        
        // Prevent zoom on custom input fields
        jQueryNuvem(".lb-input-container input[type='text'], .lb-input-container textarea").on('focus', function() {
            var viewport = document.querySelector('meta[name=viewport]');
            if (viewport) {
                viewport.setAttribute('content', 'width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no');
            }
        }).on('blur', function() {
            var viewport = document.querySelector('meta[name=viewport]');
            if (viewport) {
                viewport.setAttribute('content', 'width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no');
            }
        });
    }

    {#/*============================================================================
      #Footer
    ==============================================================================*/ #}

    {% if store.afip %}

        {# Add alt attribute to external AFIP logo to improve SEO #}

        jQueryNuvem('img[src*="www.afip.gob.ar"]').attr('alt', '{{ "Logo de AFIP" | translate }}');

    {% endif %}


    {#/*============================================================================
      #Empty placeholders
    ==============================================================================*/ #}

    {% if template == 'home' %}

        {# /* // Home showcase videos */ #}

        // Função para inicializar a barra de progresso do vídeo
        function initVideoProgress(video) {
            if (video.dataset.progressInitialized) return;
        video.dataset.progressInitialized = 'true';
        const progressFill = video.parentElement.querySelector('.video-progress-fill');
            
            if (!progressFill) return;
            
            // Reset da barra de progresso
            progressFill.style.width = '0%';
            
            // Atualizar progresso durante a reprodução
            video.addEventListener('timeupdate', function() {
                if (video.duration > 0) {
                    const progress = (video.currentTime / video.duration) * 100;
                    progressFill.style.width = progress + '%';
                }
            });
            
            // Reset quando o vídeo termina (devido ao loop)
            video.addEventListener('ended', function() {
                progressFill.style.width = '0%';
            });
        }

        {# /* // Home showcase videos */ #}

        {# /* // Aqui ao clicar no play vamos pausar todos, abrir um modal com o video e dar play no video */ #}
        jQueryNuvem(".js-lb-showcase-video-play-button").on("click", function() {
            // Pausar todos os vídeos do slider principal
            var allVideos = document.querySelectorAll('.js-section-video-products .swiper-slide video');
            allVideos.forEach(function(video) {
                video.pause();
            });
            
            // Pegar o slide atual do slider principal
            // Pegar o índice do slide clicado usando data-index
            const currentSlide = jQueryNuvem(this).closest('.swiper-slide');
            const slideIndex = parseInt(currentSlide.attr('data-index')) - 1; // -1 porque data-index começa em 1

            // Abrir o modal primeiro
            jQueryNuvem('.lb-showcase-videos-modal').show();
            jQueryNuvem('body').addClass('modal-open');
            
            // Criar ou obter o Swiper do modal
            const modalSwiper = createModalSwiper();

            // Aguardar um pouco para o Swiper inicializar completamente
            setTimeout(function() {
                const finalModalSwiper = window.modalSwiperInstance || window.modalSwiper;

                if (finalModalSwiper) {
                    // Pausar todos os vídeos primeiro
                    const allVideos = document.querySelectorAll('.js-section-video-products-modal .swiper-slide video');
                    allVideos.forEach(function(video) {
                        video.pause();
                    });

                    // Forçar ir para o slide correto, mesmo se já estiver nele
                    if (finalModalSwiper.activeIndex !== slideIndex) {
                        finalModalSwiper.slideTo(slideIndex, 0, false);
                    } else {
                        // Se já está no slide correto, forçar uma atualização
                        finalModalSwiper.update();
                        finalModalSwiper.slideTo(slideIndex, 0, false);
                    }
                    
                    // Aguardar um pouco e dar play no vídeo
                    setTimeout(function() {
                        const modalVideo = document.querySelector('.js-section-video-products-modal .swiper-slide-active video');
                        if (modalVideo) {
                            // Verificar se o vídeo tem data-src, senão usar o src original
                            const videoSrc = modalVideo.getAttribute('data-src') || modalVideo.getAttribute('src');
                            if (videoSrc && videoSrc !== 'null') {
                                modalVideo.setAttribute('src', videoSrc);
                                modalVideo.play().catch(function() { /* play promise rejected — ignore */ });
                            }
                        }
                    }, 500);
                }
            }, 100);
        });

        createSwiper('.js-section-video-products', {
            lazy: false,
            watchOverflow: true,
            loop: false,
            autoplay: {
                delay: 5000,
                disableOnInteraction: true,
            },
            speed: 1000,
            navigation: {
                nextEl: '.js-section-video-products-next',
                prevEl: '.js-section-video-products-prev',
            },
            slidesPerView: 2.15,
            spaceBetween: 10,
            breakpoints: {
                768: {
                    slidesPerView: 3.5,
                    spaceBetween: 20,
                },
                1024: {
                    slidesPerView: 4,
                    spaceBetween: 30,
                },
            },
            on: {
                init: function () {
                    this.allVideos = Array.from(this.el.querySelectorAll('video'));
                    const self = this;
                    // Aguardar um pouco para garantir que o DOM esteja pronto
                    setTimeout(function() {
                        // No mobile, carregar os 2 vídeos visíveis inicialmente
                        if (window.innerWidth <= 767) {
                            const visibleSlides = document.querySelectorAll('.js-section-video-products .swiper-slide.swiper-slide-active, .js-section-video-products .swiper-slide.swiper-slide-next');
                            
                            visibleSlides.forEach(function(slide, index) {
                                const video = slide.querySelector('.lb-showcase-video-item-video-video-wrapper video');
                                if (video) {
                                    // Carregar o vídeo (sem dar play)
                                    video.load();
                                    
                                    // Apenas o primeiro vídeo (slide ativo) deve dar play
                                    if (index === 0) {
                                        video.play();
                                        // Inicializar barra de progresso apenas no vídeo ativo
                                        initVideoProgress(video);
                                    }
                                }
                            });
                        } else {
                            // No desktop, comportamento original
                            const itemActive = self.slides[self.activeIndex];
                            if (itemActive) {
                                const video = itemActive.querySelector('.lb-showcase-video-item-video-video-wrapper video');
                                if (video) {
                                    video.play();
                                    // Inicializar barra de progresso
                                    initVideoProgress(video);
                                }
                            }
                        }
                    }, 100);
                },
                slideChangeTransitionEnd: function () {
                    var allVideos = this.allVideos || [];
                    allVideos.forEach(function(video) {
                        video.pause();
                    });

                    const itemActive = this.slides[this.activeIndex];

                    if( itemActive ) {
                        const video = itemActive.querySelector('.lb-showcase-video-item-video-video-wrapper video');
                        if( video ) {
                            video.play();
                            // Inicializar barra de progresso
                            initVideoProgress(video);
                        }
                    }
                },
                slideChange: function () {
                    // aqui vamos pausar todos os videos primeiro
                    var allVideos = this.allVideos || [];
                    allVideos.forEach(function(video) {
                        video.pause();
                    });

                    // No mobile, pré-carregar o próximo vídeo se existir
                    if (window.innerWidth <= 767) {
                        const nextSlide = this.slides[this.activeIndex + 1];
                        if (nextSlide) {
                            const nextVideo = nextSlide.querySelector('.lb-showcase-video-item-video-video-wrapper video');
                            if (nextVideo && nextVideo.readyState < 2) { // Se não estiver carregado
                                nextVideo.load();
                            }
                        }
                    }

                    const itemActive = this.slides[this.activeIndex];

                    if( itemActive ) {
                        const video = itemActive.querySelector('.lb-showcase-video-item-video-video-wrapper video');
                        if( video ) {
                            video.play();
                            // Inicializar barra de progresso
                            initVideoProgress(video);
                        }
                    }
                },
            },
        });

        // Função para criar o Swiper do modal
        function createModalSwiper() {
            if (!window.modalSwiper) {
                window.modalSwiper = createSwiper('.js-section-video-products-modal', {
                    lazy: true,
                    watchOverflow: true,
                    loop: false,
                    slidesPerView: 1,
                    spaceBetween: 0,
                    navigation: {
                        nextEl: '.js-section-video-products-modal-next',
                        prevEl: '.js-section-video-products-modal-prev',
                    },
                    on: {
                        init: function() {
                            this.allVideos = Array.from(this.el.querySelectorAll('video'));
                            // Armazenar a referência da instância
                            window.modalSwiperInstance = this;
                        },
                        slideChange: function () {
                            const self = this;

                            // Pausar todos os vídeos do modal
                            var allModalVideos = this.allVideos || [];
                            allModalVideos.forEach(function(video) {
                                video.pause();
                            });
                            
                            // Dar play no vídeo do slide ativo
                            setTimeout(function() {
                                const activeSlide = self.slides[self.activeIndex];
                                const activeModalVideo = activeSlide ? activeSlide.querySelector('video') : null;
                                if (activeModalVideo) {
                                    // Verificar se o vídeo tem data-src, senão usar o src original
                                    const videoSrc = activeModalVideo.getAttribute('data-src') || activeModalVideo.getAttribute('src');
                                    if (videoSrc && videoSrc !== 'null') {
                                        activeModalVideo.setAttribute('src', videoSrc);
                                        activeModalVideo.play().catch(function() { /* play promise rejected — ignore */ });
                                    }
                                }
                            }, 300);
                        }
                    }
                });
            }
            return window.modalSwiperInstance || window.modalSwiper;
        }     

        // Fechar modal ao clicar no botão X
        jQueryNuvem('.lb-showcase-videos-modal-close').on('click keydown', function(e) {
            if (e.type === 'click' || e.key === 'Enter' || e.key === ' ') {
                if (e.key === ' ') e.preventDefault();
                closeVideoModal();
            }
        });
        
        // Fechar modal ao clicar fora ou com ESC
        jQueryNuvem('.lb-showcase-videos-modal').on('click', function(e) {
            if (e.target === this) {
                closeVideoModal();
            }
        });
        
        jQueryNuvem(document).on('keydown', function(e) {
            if (e.key === 'Escape' && jQueryNuvem('.lb-showcase-videos-modal').is(':visible')) {
                closeVideoModal();
            }
        });
        
        // Função para fechar o modal
        function closeVideoModal() {
            // Pausar todos os vídeos do modal
            var allModalVideos = document.querySelectorAll('.js-section-video-products-modal .swiper-slide video');
            allModalVideos.forEach(function(video) {
                video.pause();
            });
            
            // Fechar modal
            jQueryNuvem('.lb-showcase-videos-modal').hide();
            jQueryNuvem('body').removeClass('modal-open');
        }

        {# /* // Home slider */ #}

        var width = window.innerWidth;
        if (width > 767) {
            var slider_empty_autoplay = {delay: 6000,};
        } else {
            var slider_empty_autoplay = false;
        }

        window.homeEmptySlider = {
            getAutoRotation: function() {
                return slider_empty_autoplay;
            },
        };
        createSwiper('.js-home-empty-slider', {
            {% if not params.preview %}
            lazy: true,
            {% endif %}
            loop: true,
            autoplay: slider_empty_autoplay,
            pagination: {
                el: '.js-swiper-empty-home-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.js-swiper-empty-home-next',
                prevEl: '.js-swiper-empty-home-prev',
            },
            on: {
                init: function () {
                    jQueryNuvem(".js-home-empty-slider").css("visibility", "visible").css("height", "100%");
                },
            },
        });


    {% endif %}

    {% if template == '404' or template == 'home' %}

        {# /* // Product slider */ #}

        createSwiper('.js-swiper-product-demo', {
            lazy: true,
            slidesPerView: 'auto',
            watchOverflow: true,
            navigation: {
                nextEl: '.js-swiper-product-next-demo',
                prevEl: '.js-swiper-product-prev-demo',
            },
            pagination: {
                el: '.js-swiper-product-pagination-demo',
            },
            breakpoints: {
                768: {
                    slidesPerView: 'auto',
                }
            },
        });

        var directionVal = 'vertical';

        {% if template == 'product' %}
            if (window.innerWidth < 767) {
                var directionVal = 'horizontal';
            }
        {% endif %}

        createSwiper('.js-swiper-product-thumbs-demo', {
            lazy: true,
            watchOverflow: true,
            threshold: 5,
            direction: directionVal,
            navigation: {
                nextEl: '.js-swiper-product-thumbs-next-demo',
                prevEl: '.js-swiper-product-thumbs-prev-demo',
            },
            slidesPerView: 'auto',
        });

    {% endif %}
    
    {% if template == '404' %}
        
        {# /* // Product Related */ #}

        {# Swiper used for demo component #}

        createSwiper('.js-swiper-related-demo', {
            lazy: true,
            loop: true,
            watchOverflow: true,
            centerInsufficientSlides: true,
            threshold: 5,
            watchSlideProgress: true,
            watchSlidesVisibility: true,
            spaceBetween: itemSwiperSpaceBetween,
            slideVisibleClass: 'js-swiper-slide-visible',
            slidesPerView: slidesPerViewMobileVal,
            navigation: {
                nextEl: '.js-swiper-related-next-demo',
                prevEl: '.js-swiper-related-prev-demo',
            },
            breakpoints: {
                768: {
                    slidesPerView: slidesPerViewDesktopVal,
                }
            }
        });

        {# /* 404 handling to show the example product */ #}

        if (/\/product\/example\/?$/.test(window.location.pathname)) {
            document.title = "{{ 'Producto de ejemplo' | translate }}";
            jQueryNuvem("#page-error").hide();
            jQueryNuvem("#product-example").show();
        } else {
            jQueryNuvem("#product-example").hide();
        }

    {% endif %}

    {# /* // Product image sticky control */ #}
    
    {% if template == 'product' %}

        jQueryNuvem(".js-cta-group-button").on("click", function(e) {
            e.preventDefault();
            const $this = jQueryNuvem(this);
            const $customizationsContainer = jQueryNuvem(".customizations-container");
            if( $customizationsContainer.hasClass("active") ) {
                $customizationsContainer.removeClass("active");
                $customizationsContainer.hide();
            } else {
                $customizationsContainer.addClass("active");
                $customizationsContainer.show();
            }
            return false;
        });

        jQueryNuvem(".lb-customization-radio-label").on("click", function() {
            const $this = jQueryNuvem(this);
            const $parent = $this.closest(".lb-input-container");
            const $input = $parent.find(".js-customization-radio-input");
            const $label = $parent.find(".js-insta-variation-label");

            $parent.find(".lb-customization-radio-label").removeClass("selected");
            $this.addClass("selected");

            $input.val($this.data("value"));
            $label.text($this.data("value"));
        });

        // Product image sticky control - Mobile only
        // Replace scroll listener + getBoundingClientRect with IntersectionObserver for better performance
        let productImageStickyObserver = null;
        let productImageStickyScrollListener = null;

        function initProductImageSticky() {
            if (window.innerWidth >= 768) return;
            
            const priceElement = document.querySelector(`[data-store="product-price-${LS.product.id}"]`);
            const stickyElement = document.querySelector('.lb-product-image-container-sticky');
            
            if (!priceElement || !stickyElement) return;

            // Disconnect old observer if it exists
            if (productImageStickyObserver) {
                productImageStickyObserver.disconnect();
                productImageStickyObserver = null;
            }
            
            if ('IntersectionObserver' in window) {
                productImageStickyObserver = new IntersectionObserver((entries) => {
                    entries.forEach(entry => {
                        // If price element is intersecting (visible), don't show sticky
                        // If price element is not intersecting and is above viewport (boundingClientRect.top < 0), show sticky
                        if (entry.isIntersecting) {
                            stickyElement.classList.add('active');
                        } else {
                            if (entry.boundingClientRect.top < 0) {
                                stickyElement.classList.remove('active');
                            } else {
                                stickyElement.classList.add('active');
                            }
                        }
                    });
                }, {
                    // Start checking when it's fully out of view
                    threshold: 0
                });

                productImageStickyObserver.observe(priceElement);
            } else {
                // Fallback for older browsers
                function handleProductImageStickyFallback() {
                    if (window.innerWidth >= 768) return;
                    const priceRect = priceElement.getBoundingClientRect();
                    if (priceRect.bottom < 0) {
                        stickyElement.classList.remove('active');
                    } else {
                        stickyElement.classList.add('active');
                    }
                }

                handleProductImageStickyFallback();
                if (!productImageStickyScrollListener) {
                    let scrollTimeout;
                    productImageStickyScrollListener = function() {
                        if (scrollTimeout) return;
                        scrollTimeout = setTimeout(function() {
                            handleProductImageStickyFallback();
                            scrollTimeout = null;
                        }, 50);
                    };
                    window.addEventListener('scroll', productImageStickyScrollListener, { passive: true });
                }
            }
        }
        
        initProductImageSticky();
        
        // Handle resize re-initialization
        let resizeTimeout;
        window.addEventListener('resize', function() {
            if (resizeTimeout) return;
            resizeTimeout = setTimeout(function() {
                initProductImageSticky();
                resizeTimeout = null;
            }, 100);
        });
    {% endif %}

    // Função para inicializar a barra de progresso do vídeo
    function initVideoProgress(video) {
        if (video.dataset.progressInitialized) return;
        video.dataset.progressInitialized = 'true';
        const progressFill = video.parentElement.querySelector('.video-progress-fill');
        
        if (!progressFill) return;
        
        // Reset da barra de progresso
        progressFill.style.width = '0%';
        
        // Atualizar progresso durante a reprodução
        video.addEventListener('timeupdate', function() {
            if (video.duration > 0) {
                const progress = (video.currentTime / video.duration) * 100;
                progressFill.style.width = progress + '%';
            }
        });
        
        // Reset quando o vídeo termina (devido ao loop)
        video.addEventListener('ended', function() {
            progressFill.style.width = '0%';
        });
    }

    // Script para adicionar ?mpage=100 em páginas de categoria
    if (typeof LS.template !== 'undefined' && LS.template === 'category') {
        const urlParams = new URLSearchParams(window.location.search);
        
        // Verifica se o parâmetro mpage não existe
        if (!urlParams.has('mpage')) {
            // Adiciona o parâmetro mpage=100 à URL
            const newUrl = new URL(window.location);
            newUrl.searchParams.set('mpage', '100');
            
            // Redireciona para a nova URL
            window.location.href = newUrl.toString();
        }
    }

});