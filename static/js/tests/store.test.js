const fs = require('fs');
const assert = require('assert');
const path = require('path');

// Read the template file
const templatePath = path.join(__dirname, '../store.js.tpl');
const templateContent = fs.readFileSync(templatePath, 'utf8');

// Extract the cleanURLHash function
// Matching: cleanURLHash = function(){ ... };
const functionMatch = templateContent.match(/cleanURLHash = function\(\)\{[\s\S]*?\n        \};/);
if (!functionMatch) {
  console.error("Could not find cleanURLHash function in store.js.tpl");
  process.exit(1);
}

const functionCode = functionMatch[0];

// Define our mock environment
global.window = {
    location: {
        toString: () => global.window.mockUrl
    },
    history: {
        replaceState: (state, title, url) => {
            global.window.lastReplacedUrl = url;
            global.window.replaceStateCalled++;
        }
    }
};

global.document = {
    title: 'Example Page'
};

// Evaluate the extracted function code into the global scope
eval('var ' + functionCode);

console.log("🧪 Testing cleanURLHash logic...\n");

function resetMocks(url) {
    global.window.mockUrl = url;
    global.window.lastReplacedUrl = null;
    global.window.replaceStateCalled = 0;
}

// Test 1: URL with hash
resetMocks('https://example.com/products/item#details');
cleanURLHash();
assert.strictEqual(global.window.replaceStateCalled, 1, 'Expected replaceState to be called exactly once');
assert.strictEqual(global.window.lastReplacedUrl, 'https://example.com/products/item', 'Hash was not correctly stripped');
console.log("✅ Passed: URL with hash is correctly cleaned.");

// Test 2: URL without hash
resetMocks('https://example.com/products/item');
cleanURLHash();
assert.strictEqual(global.window.replaceStateCalled, 0, 'Expected replaceState to NOT be called when there is no hash');
assert.strictEqual(global.window.lastReplacedUrl, null, 'URL should not have been replaced');
console.log("✅ Passed: URL without hash is not modified.");

// Test 3: URL ending exactly with hash
resetMocks('https://example.com/products/item#');
cleanURLHash();
assert.strictEqual(global.window.replaceStateCalled, 1, 'Expected replaceState to be called exactly once');
assert.strictEqual(global.window.lastReplacedUrl, 'https://example.com/products/item', 'Empty hash was not correctly stripped');
console.log("✅ Passed: URL ending exactly with hash is correctly cleaned.");

console.log("\nAll tests passed successfully!");
