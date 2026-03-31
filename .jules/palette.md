
## 2025-03-31 - Add ARIA Labels to Quantity Buttons
**Learning:** Found that custom quantity increment/decrement controls embedded in TiendaNube Twig templates (`.tpl`) lack proper accessible names and roles by default, making them unreadable to screen readers.
**Action:** When working on similar custom form controls, specifically those using spans and icon SVGs to act as buttons, always inject `role="button"` and translated `aria-label` attributes to ensure they are keyboard/screen reader accessible without breaking existing visual styling or JavaScript event listeners.
