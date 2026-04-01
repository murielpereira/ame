
## 2025-03-31 - Add ARIA Labels to Quantity Buttons
**Learning:** Found that custom quantity increment/decrement controls embedded in TiendaNube Twig templates (`.tpl`) lack proper accessible names and roles by default, making them unreadable to screen readers.
**Action:** When working on similar custom form controls, specifically those using spans and icon SVGs to act as buttons, always inject `role="button"` and translated `aria-label` attributes to ensure they are keyboard/screen reader accessible without breaking existing visual styling or JavaScript event listeners.
## 2024-05-27 - Icon-only Div Buttons require ARIA context
**Learning:** In TiendaNube `.tpl` themes, slider controls (like `js-swiper-product-thumbs-prev`) are often implemented using `<div>` elements containing only an `<svg>` icon without any accessible text or interactive roles.
**Action:** Always add `role="button"`, `tabindex="0"`, and `aria-label="{{ 'Text' | translate }}"` to the container `div`, and `aria-hidden="true"` to the inner SVG to ensure these custom icon-only controls are perceivable and operable by screen readers and keyboard users.
