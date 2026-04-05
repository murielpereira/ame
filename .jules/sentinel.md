## 2024-05-24 - [Fix Tabnabbing Risk in target="_blank" Links]
**Vulnerability:** Found multiple `<a>` tags with `target="_blank"` missing the `rel="noopener noreferrer"` attribute across the codebase.
**Learning:** This exposes the application to "reverse tabnabbing", where the newly opened tab can manipulate the original tab's `window.opener` object, potentially leading to phishing attacks.
**Prevention:** Always add `rel="noopener noreferrer"` when using `target="_blank"`. Added a script to automate this fix across all `.tpl` files.

## 2024-06-25 - [Fix DOM XSS Vulnerability]
**Vulnerability:** Found `jQueryNuvem(...).html()` being used in `static/js/store.js.tpl` which could lead to DOM-based XSS.
**Learning:** Using `.html()` to set or get content that might contain user-controlled data can lead to Cross-Site Scripting (XSS).
**Prevention:** Always use `.text()` instead of `.html()` when dealing with user-controlled data or when only text manipulation is needed.
