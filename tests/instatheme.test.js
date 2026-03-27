const assert = require('assert');
const fs = require('fs');
const path = require('path');

// 1. Mock the environment
const globalWindow = {};
global.window = globalWindow;

const mockJQueryNuvem = function(selector) {
    return {
        selector: selector,
        find: function() { return { length: 1 }; },
        show: function() {},
        hide: function() {},
        removeClass: function() { return this; },
        removeAttr: function() { return this; },
        attr: function() { return this; },
        each: function(cb) { cb.call(this, 0, this); return this; },
        outerWidth: function() { return 100; },
        hasClass: function() { return false; },
        addClass: function() { return this; },
        on: function() { return this; }
    };
};
global.$ = mockJQueryNuvem;

const instaElements = {
    Logo: function(options) { this.options = options; },
    Sections: function(options) { this.options = options; },
    Text: function(options) { this.options = options; },
    Lambda: function(options) { this.options = options; }
};

// 2. Load the script
const scriptPath = path.join(__dirname, '../static/js/instatheme-a041d149003d24df898f0e19c980802230.js');
const scriptContent = fs.readFileSync(scriptPath, 'utf8');

// We evaluate the script which assigns to window.tiendaNubeInstaTheme
try {
    const fn = new Function('jQueryNuvem', 'window', scriptContent + '\n; return window.tiendaNubeInstaTheme;');
    globalWindow.tiendaNubeInstaTheme = fn(mockJQueryNuvem, globalWindow);
} catch (e) {
    console.error("Error evaluating script:", e);
    process.exit(1);
}

const themePlugin = globalWindow.tiendaNubeInstaTheme;

function runTests() {
    console.log("Running tests...");

    // Test: waitFor
    console.log("  Testing waitFor()...");
    const waitResult = themePlugin.waitFor();
    assert.deepStrictEqual(waitResult, [], "waitFor should return an empty array");

    // Test: placeholders
    console.log("  Testing placeholders()...");
    const placeholdersResult = themePlugin.placeholders();
    assert.ok(Array.isArray(placeholdersResult), "placeholders should return an array");
    assert.ok(placeholdersResult.length > 0, "placeholders should return a non-empty array");

    // Verify one of the placeholders properties
    const firstPlaceholder = placeholdersResult[0];
    assert.strictEqual(firstPlaceholder.placeholder, '.js-home-slider-placeholder');
    assert.strictEqual(firstPlaceholder.content, '.js-home-slider-top');

    // Verify contentReady mock behavior
    // Mock the context for contentReady
    const mockContext = mockJQueryNuvem('mock');

    const isReady = firstPlaceholder.contentReady.call(mockContext);
    assert.strictEqual(isReady, true, "contentReady should return true when images are found");

    // Test: handlers
    console.log("  Testing handlers()...");
    const handlersResult = themePlugin.handlers(instaElements);

    assert.ok(handlersResult.logo instanceof instaElements.Logo, "handlers should create a Logo instance");
    assert.ok(handlersResult.home_order_position instanceof instaElements.Sections, "handlers should create a Sections instance for home_order_position");

    assert.ok(handlersResult.featured_products_title instanceof instaElements.Text, "handlers should create Text instance for featured_products_title");

    // Checking for lambda instantiations
    assert.ok(handlersResult.slider_align instanceof instaElements.Lambda, "handlers should create Lambda instance for slider_align");
    assert.ok(handlersResult.featured_products_mobile instanceof instaElements.Lambda, "handlers should create Lambda instance for featured_products_mobile");

    console.log("All tests passed! ✅");
}

runTests();
