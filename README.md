# TiendaNube / Nuvemshop Custom Theme

This repository contains a custom TiendaNube / Nuvemshop theme implementation with various custom features, layout components, and optimizations.

## Features

Based on the project checklist, the following custom features and enhancements are included:

- **"Tutor and Pet Data" Button:** A toggleable button that opens input fields when clicked.
- **Improved Product Gallery:** Replaced the standard carousel below the main image with a "Drag to Left" indicator to improve UX for viewing additional images.
- **Sticky Product Image:** The main product image remains fixed during page scroll.
- **Category CTA Buttons:** Products in category pages feature a Call to Action (CTA) button. For custom products, clicking leads directly to the product detail page.
- **Empty Search Suggestions:** When a search yields no results, product suggestions are displayed.
- **Video Showcase:** A dedicated video content showcase section on the homepage.
- **SEO Enhancements:** Extended text descriptions in category pages for better Search Engine Optimization.
- **Custom Fields:** Implementation of 13 custom fields for detailed product/order information.
- **Product Grouping:** Grouped product photos across showcases and category pages.

## Directory Structure

The project follows standard TiendaNube theme conventions:

- `config/`: Theme settings and configuration files (`settings.txt`, `defaults.txt`, etc.).
- `layouts/`: Base HTML structure templates (e.g., `layout.tpl`).
- `templates/`: Page-specific templates (home, product, category, cart, etc.).
- `snipplets/`: Reusable template components and partials.
- `static/`: Static assets including CSS/SCSS, JavaScript, and images.
- `tests/`: Project test files.

## Utilities

### Drag to Left Icon
A custom animated SVG icon used to indicate horizontal scrolling capabilities (e.g., in image galleries). See `README-drag-to-left.md` and `drag-to-left-example.html` for documentation and usage examples.

### Auto-Merge Script
An `automerge.sh` bash script is included to facilitate merging remote branches into the `main` branch.

## Development

Modifications to styles should be done via SCSS files within the `static/` directory, and template changes in `templates/` or `snipplets/`. Settings schema updates are handled in `config/settings.txt`.
