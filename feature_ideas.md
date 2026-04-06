# Feature Ideas for TiendaNube Theme

Based on an analysis of the repository's structure, including `layouts/layout.tpl`, `config/settings.txt`, `snipplets/grid/quick-shop.tpl`, and `README-drag-to-left.md`, here are 3 feature ideas tailored to this specific codebase:

### 1. Gamified "Free Shipping" Progress Bar in the Ajax Cart
* **What:** A visual progress bar in the slide-out cart (`ajax_cart`) that dynamically updates as the user adds items, showing how close they are to free shipping (e.g., "Add $50 more for Free Shipping!").
* **Why it fits:** The foundation is already present in `layouts/layout.tpl` where hidden data attributes like `js-ship-free-min`, `js-cart-subtotal`, and `cart.free_shipping` are being tracked.
* **Value:** It's a proven psychological trigger to increase Average Order Value (AOV).

### 2. Sticky "Add to Cart" Bar on Mobile Product Pages
* **What:** As the user scrolls down a product page, a compact, fixed bar appears at the bottom of the screen containing the product price and an "Add to Cart" button.
* **Why it fits:** The theme supports an enormous amount of product page customization, including up to 17 Custom Fields (`product_custom_fields` seen in `config/settings.txt`). This means product pages can become very long on mobile devices.
* **Value:** Ensures the primary Call-To-Action is always accessible, preventing conversion drop-off on long-scrolling mobile screens.

### 3. Interactive "Shop the Look" Hotspots on Carousels
* **What:** The ability to add clickable "pins" or "hotspots" on top of the homepage slider or category banners (`slider`, `banner_promotional`). Clicking a hotspot opens the existing `quick-shop.tpl` modal for the specific product shown in the lifestyle image.
* **Why it fits:** The theme places a huge emphasis on visual merchandising (video showcases, rich banner galleries, Instafeeds in `config/settings.txt`). It also already has a quick-shop modal (`snipplets/grid/quick-shop.tpl`) ready to be utilized.
* **Value:** Creates a modern, highly engaging, and seamless shopping experience right from the homepage visuals.
