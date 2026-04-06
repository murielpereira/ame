## 2024-05-24 - [Fix Tabnabbing Risk in target="_blank" Links]
**Vulnerability:** Found multiple `<a>` tags with `target="_blank"` missing the `rel="noopener noreferrer"` attribute across the codebase.
**Learning:** This exposes the application to "reverse tabnabbing", where the newly opened tab can manipulate the original tab's `window.opener` object, potentially leading to phishing attacks.
**Prevention:** Always add `rel="noopener noreferrer"` when using `target="_blank"`. Added a script to automate this fix across all `.tpl` files.

## 2024-05-24 - Cross-Site Scripting (XSS) in Countdown Timer
**Vulnerability:** User-controlled Twig variables (like `settings.COUNTDOWN_MESSAGE`) were being injected directly into JavaScript strings without escaping in `snipplets/header/header-countdown-bar.tpl`. An attacker (or careless admin) could break out of the string context by injecting single quotes and execute arbitrary JavaScript.
**Learning:** TiendaNube variables injected directly into `<script>` blocks must be explicitly escaped for JavaScript to prevent XSS.
**Prevention:** Always use the `escape('js')` filter (e.g., `{{ settings.VAR | escape('js') }}`) when passing Twig variables into JavaScript contexts.
