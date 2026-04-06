# TiendaNube Theme Project

This is a customized TiendaNube theme repository. The theme is built utilizing Twig templates and a structure optimized for flexibility and customizability through TiendaNube's theme settings.

## Project Structure

The project follows standard TiendaNube theme conventions:

- `config/` - Contains theme configurations such as `settings.txt` that define the custom fields available in the TiendaNube admin interface (colors, fonts, header layout, custom fields).
- `layouts/` - Contains the base HTML structure layouts for the theme.
- `snipplets/` - Contains reusable Twig components (snipplets) used across different templates.
- `static/` - Contains static assets such as CSS, JavaScript, and images.
- `templates/` - Contains the main Twig templates for different pages (e.g., product page, category page, home page).
- `tests/` - Directory for testing scripts and helpers.

## Features

The theme incorporates numerous customizable features, including:
- **Brand Customization:** Fully configurable colors, fonts, and branding elements.
- **Advanced Navigation:** Customizable header, top bar, and secondary menus.
- **Dynamic Content:** Extensive support for promotional banners, custom product fields, and video carousels on the homepage.
- **Custom UI Elements:** Includes custom animations like the "Drag to Left" icon for horizontal scrolling interfaces (see `README-drag-to-left.md`).
- **Product Enhancements:** Supports detailed custom fields, countdown timers, and cashback configurations for products.

## Automation and Scripts

### Automerge Script
The repository includes an `automerge.sh` script to streamline branch management.
- It switches to the `main` branch, pulls the latest changes, and iterates through all remote branches (excluding `main`).
- It attempts to perform a non-interactive merge of each branch into `main`.
- If a conflict occurs, it aborts the process and alerts the user to resolve the conflict manually.
- On success, it pushes the merged `main` branch back to the origin repository.

Usage:
```bash
./automerge.sh
```
