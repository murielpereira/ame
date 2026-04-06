## 2024-05-24 - [Fix Tabnabbing Risk in target="_blank" Links]
**Vulnerability:** Found multiple `<a>` tags with `target="_blank"` missing the `rel="noopener noreferrer"` attribute across the codebase.
**Learning:** This exposes the application to "reverse tabnabbing", where the newly opened tab can manipulate the original tab's `window.opener` object, potentially leading to phishing attacks.
**Prevention:** Always add `rel="noopener noreferrer"` when using `target="_blank"`. Added a script to automate this fix across all `.tpl` files.
## 2025-04-04 - [Fix DOM XSS Vulnerability]
**Vulnerability:** Found `jQuery().html()` being used in `static/js/store.js.tpl` to insert data into the DOM and read values, which opens up the potential for DOM-based Cross-Site Scripting (XSS).
**Learning:** Even internal formatting values (like formatting totals) or reading values from the DOM can be risky if parsed as HTML instead of text.
**Prevention:** Always use `jQuery().text()` instead of `.html()` when handling potentially dynamic input data or where HTML parsing is not strictly required.
