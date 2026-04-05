# TiendaNube Base Theme

A basic skeleton theme designed to be cloned and customized for creating new TiendaNube / Nuvemshop templates.

## Structure

This theme follows the standard TiendaNube theme structure.

- **config/**: Configuration files for the theme, including `data.json`, `defaults.txt`, and settings configurations.
- **layouts/**: Contains the main layout template, `layout.tpl`.
- **snipplets/**: Reusable smaller components like headers, footers, product grids, banners, etc.
- **static/**: Static assets such as CSS, JS, images, and fonts.
- **templates/**: Core page templates (e.g., `home.tpl`, `product.tpl`, `category.tpl`, `cart.tpl`, etc.).
- **tests/**: Test specifications and configurations.

## Setup & Development

To use this as a base for a new TiendaNube theme:

1.  Clone this repository or use it as a template.
2.  Follow the official [TiendaNube Theme documentation](https://dev.tiendanube.com/docs/themes/) to connect this codebase with a development store.
3.  Modify configurations in `config/` to define theme settings and defaults.
4.  Edit templates in `layouts/`, `templates/`, and `snipplets/` using Twig syntax to structure your theme's frontend.
5.  Add and manage assets in the `static/` directory.

## Testing

Ensure that you add relevant test cases inside the `tests/` directory as you develop new features and templates.

## Additional Features

- **Drag to Left Icon**: Includes an animated SVG icon to indicate horizontal scroll/swipe capabilities. See `README-drag-to-left.md` for details on implementation and usage.

## License

(Add the appropriate license here if necessary)