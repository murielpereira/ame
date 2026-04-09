const fs = require('fs');
const jsdom = require('jsdom');
const { JSDOM } = jsdom;

let content = fs.readFileSync('./static/js/store.js.tpl', 'utf8');

// Basic Twig stripping (naïve approach for syntax check)
content = content.replace(/\{#.*?#\}/gs, ''); // Remove comments
content = content.replace(/\{\{.*?\}\}/g, '""'); // Replace output with empty string
content = content.replace(/\{%.*?%\}/g, ''); // Remove control blocks

try {
  // Just parsing to check syntax
  new Function(content);
  console.log("Syntax is valid after stripping Twig.");
} catch (e) {
  console.error("Syntax error or complex Twig logic prevented naive verification.");
  console.error(e.message);
  // Expected behavior as per memory:
  // "If new Function() validation fails due to these preexisting artifacts, rely on explicit git diff reviews to verify patches instead."
}
