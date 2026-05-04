## 2024-04-30 - Swiper Control Accessibility Pattern
**Learning:** Found a recurring accessibility issue pattern specific to this app's Swiper components: icon-only `div` elements used as slider controls (`swiper-button-prev`/`next`) lack `role="button"`, `tabindex="0"`, and `aria-label`s, making them invisible to screen readers and unreachable via keyboard navigation.
**Action:** Always add `role="button"`, `tabindex="0"`, `aria-label="{{ 'Anterior' | translate }}"` / `{{ 'Próxima' | translate }}"`, and `aria-hidden="true"` on the inner SVG for all custom slider controls across the theme.

## 2024-04-30 - Swiper Control Accessibility Pattern
**Learning:** Found a recurring accessibility issue pattern specific to this app's Swiper components: icon-only `div` elements used as slider controls (`swiper-button-prev`/`next`) lack `role="button"`, `tabindex="0"`, and `aria-label`s, making them invisible to screen readers and unreachable via keyboard navigation.
**Action:** Always add `role="button"`, `tabindex="0"`, `aria-label="{{ 'Anterior' | translate }}"` / `{{ 'Próxima' | translate }}"`, and `aria-hidden="true"` on the inner SVG for all custom slider controls across the theme.
## 2024-05-02 - Keyboard accessibility for role='button'
**Learning:** Adding `role="button"` and `tabindex="0"` to a `div` or `span` makes it focusable and tells screen readers it's a button, but it does *not* automatically give it button keyboard behaviors (Enter/Space to click).
**Action:** When converting non-interactive elements to accessible buttons, always add a `keydown` listener to handle `Enter` and `Space` keys, preventing default action for Space to avoid page scrolling.

## 2024-05-18 - Icon-Only Anchor Link Accessibility
**Learning:** In addition to Swiper pagination `<div>`s, icon-only `<a>` tags used for structural controls like `swiper-button-prev`/`next` and generic play buttons (`video-player`) lack screen reader context when they only wrap an inline `<svg>`.
**Action:** Always add an explicit, localized `aria-label` (e.g., `aria-label="{{ 'Anterior' | translate }}"` or `aria-label="{{ 'Reproducir video' | translate }}"`) to these anchor links to ensure functionality is announced by screen readers.
