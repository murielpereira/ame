## 2024-04-30 - Swiper Control Accessibility Pattern
**Learning:** Found a recurring accessibility issue pattern specific to this app's Swiper components: icon-only `div` elements used as slider controls (`swiper-button-prev`/`next`) lack `role="button"`, `tabindex="0"`, and `aria-label`s, making them invisible to screen readers and unreachable via keyboard navigation.
**Action:** Always add `role="button"`, `tabindex="0"`, `aria-label="{{ 'Anterior' | translate }}"` / `{{ 'Próxima' | translate }}"`, and `aria-hidden="true"` on the inner SVG for all custom slider controls across the theme.

## 2024-04-30 - Swiper Control Accessibility Pattern
**Learning:** Found a recurring accessibility issue pattern specific to this app's Swiper components: icon-only `div` elements used as slider controls (`swiper-button-prev`/`next`) lack `role="button"`, `tabindex="0"`, and `aria-label`s, making them invisible to screen readers and unreachable via keyboard navigation.
**Action:** Always add `role="button"`, `tabindex="0"`, `aria-label="{{ 'Anterior' | translate }}"` / `{{ 'Próxima' | translate }}"`, and `aria-hidden="true"` on the inner SVG for all custom slider controls across the theme.
## 2024-05-24 - Accessible Modal Close Buttons
**Learning:** Icon-only modal close buttons implemented as `div` elements in TiendaNube themes lack accessibility context and keyboard functionality.
**Action:** When using `div` for interactive controls like modal close buttons, always add `role="button"`, `tabindex="0"`, an `aria-label`, and a corresponding `keydown` listener for 'Enter' and 'Space' to ensure keyboard and screen reader accessibility.
