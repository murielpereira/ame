// Product image sticky control
function handleProductImageSticky() {
    const priceElement = document.querySelector('[data-store="product-price-278754942"]');
    const stickyElement = document.querySelector('.lb-product-image-container-sticky');
    
    if (!priceElement || !stickyElement) return;
    
    const priceRect = priceElement.getBoundingClientRect();
    
    // If price element passed completely off screen (scroll down)
    if (priceRect.bottom < 0) {
        stickyElement.classList.remove('lb-product-image-container-sticky');
    } else {
        // If price element came back to screen (scroll up)
        stickyElement.classList.add('lb-product-image-container-sticky');
    }
}

// Execute on initialization
handleProductImageSticky();

// Execute on scroll
window.addEventListener('scroll', handleProductImageSticky);

// Execute on window resize
window.addEventListener('resize', handleProductImageSticky); 