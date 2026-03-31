## 2024-05-24 - [Fix Tabnabbing Risk in target="_blank" Links]
**Vulnerability:** Found multiple `<a>` tags with `target="_blank"` missing the `rel="noopener noreferrer"` attribute across the codebase.
**Learning:** This exposes the application to "reverse tabnabbing", where the newly opened tab can manipulate the original tab's `window.opener` object, potentially leading to phishing attacks.
**Prevention:** Always add `rel="noopener noreferrer"` when using `target="_blank"`. Added a script to automate this fix across all `.tpl` files.
