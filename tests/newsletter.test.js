const fs = require('fs');
const path = require('path');
const { JSDOM } = require('jsdom');
const assert = require('assert');

// Read the template file
const tplPath = path.join(__dirname, '../static/js/store.js.tpl');
const tplContent = fs.readFileSync(tplPath, 'utf8');

// Extract the relevant JavaScript logic for newsletter subscription
const match = tplContent.match(/jQueryNuvem\('#news-popup-form'\)\.on\("submit",[\s\S]*?LS\.newsletter\([\s\S]*?\}\);/);
if (!match) {
    throw new Error('Could not find newsletter logic in store.js.tpl');
}
const jsLogic = match[0];

// Set up JSDOM environment
const dom = new JSDOM(`
  <!DOCTYPE html>
  <html>
    <body>
      <div id="home-modal" class="modal-show">
        <div id="news-popup-form-container">
          <form id="news-popup-form">
            <button type="submit" class="js-news-popup-submit"></button>
            <div class="js-news-spinner" style="display:none;"></div>
            <div class="js-news-popup-success" style="display:none;"></div>
            <div class="js-news-popup-failed" style="display:none;"></div>
          </form>
        </div>
      </div>
    </body>
  </html>
`);

const window = dom.window;
const document = window.document;

// Mock jQuery
function mockJQuery(selector) {
    // If it's a DOM element (like `this` in event handlers)
    if (typeof selector === 'object') {
        return createJQueryObject([selector]);
    }

    // If it's a string selector
    let elements = [];
    if (selector === document) {
        elements = [document];
    } else {
        elements = Array.from(document.querySelectorAll(selector));
    }

    return createJQueryObject(elements);
}

function createJQueryObject(elements) {
    return {
        length: elements.length,
        0: elements[0],
        get: () => elements,
        find: (sel) => {
            const found = [];
            elements.forEach(el => {
                if (el && el.querySelectorAll) {
                    found.push(...Array.from(el.querySelectorAll(sel)));
                }
            });
            return createJQueryObject(found);
        },
        on: (event, handler) => {
            // For submit, we'll store the handler so we can trigger it manually in tests
            if (event === 'submit') {
                elements.forEach(el => {
                    el._submitHandler = handler;
                });
            }
            return createJQueryObject(elements);
        },
        show: () => {
            elements.forEach(el => {
                if (el && el.style) el.style.display = 'block';
            });
            return createJQueryObject(elements);
        },
        hide: () => {
            elements.forEach(el => {
                if (el && el.style) el.style.display = 'none';
            });
            return createJQueryObject(elements);
        },
        prop: (propName, value) => {
            if (value !== undefined) {
                elements.forEach(el => {
                    if (el) el[propName] = value;
                });
                return createJQueryObject(elements);
            }
            return elements.length > 0 ? elements[0][propName] : undefined;
        },
        fadeIn: () => {
            elements.forEach(el => {
                if (el && el.style) el.style.display = 'block';
            });
            return createJQueryObject(elements);
        },
        fadeOut: () => {
            // Keep elements in DOM, just hide them. We mock fadeOut to not immediately hide to allow CSS check later, but actually our mock of fadeOut happens inside setTimeout which runs synchronously.
            elements.forEach(el => {
                if (el && el.style) el.style.display = 'none';
            });
            return createJQueryObject(elements);
        },
        css: (prop, value) => {
            if (value !== undefined) {
                elements.forEach(el => {
                    if (el && el.style) el.style[prop] = value;
                });
                return createJQueryObject(elements);
            }
            return elements.length > 0 && elements[0].style ? elements[0].style[prop] : undefined;
        },
        removeClass: (className) => {
            elements.forEach(el => {
                if (el && el.classList) el.classList.remove(className);
            });
            return createJQueryObject(elements);
        }
    };
}

const jQueryNuvem = mockJQuery;

// Mock LS object
let currentCallback = null;
const LS = {
    newsletter: (containerSelector, modalSelector, url, callback) => {
        // Store the callback so we can simulate the response
        currentCallback = callback;
    }
};

// Mock setTimeout
// We do not want to run the setTimeout callbacks immediately because
// the newsletter logic checks `if (jQueryNuvem(".js-news-popup-success").css("display") == "block")`
// AFTER a setTimeout that fades out the popup.
// If we run setTimeout synchronously, the fadeOut happens before the check.
const originalSetTimeout = global.setTimeout;
const timeoutQueue = [];
global.setTimeout = (fn, ms) => {
    timeoutQueue.push(fn);
    return 1;
};

function flushTimeouts() {
    while (timeoutQueue.length > 0) {
        const fn = timeoutQueue.shift();
        fn();
    }
}

try {
    console.log("Setting up tests...");

    // Execute the extracted script
    // Note: We need to replace the twig tag {{ store.contact_url | escape('js') }}
    const cleanJsLogic = jsLogic.replace("{{ store.contact_url | escape('js') }}", "/contact");

    const setupFunc = new Function('jQueryNuvem', 'LS', 'document', cleanJsLogic);
    setupFunc(jQueryNuvem, LS, document);

    console.log("Running form submit handler test...");

    // Test 1: Form Submit Handler
    const form = document.getElementById('news-popup-form');
    // Call the stored handler with 'this' bound to the form
    form._submitHandler.call(form);

    // Assert spinner is shown and button is disabled
    assert.strictEqual(document.querySelector('.js-news-spinner').style.display, 'block', 'Spinner should be shown on submit');
    assert.strictEqual(document.querySelector('.js-news-popup-submit').disabled, true, 'Submit button should be disabled on submit');

    console.log("Running success path test...");

    // Test 2: Success Callback Path
    // Reset state
    document.querySelector('.js-news-spinner').style.display = 'block';
    document.querySelector('.js-news-popup-submit').disabled = true;
    document.querySelector('.js-news-popup-success').style.display = 'none';

    // Simulate success response using 'this' bound to a dummy wrapper (to mimic jQuery `this`)
    const successWrapper = document.getElementById('home-modal');
    currentCallback.call(successWrapper, { success: true });

    // Assertions for success path before timeouts
    assert.strictEqual(document.querySelector('.js-news-spinner').style.display, 'none', 'Spinner should be hidden after callback');
    assert.strictEqual(document.querySelector('.js-news-popup-submit').disabled, false, 'Submit button should be enabled after callback');
    assert.strictEqual(document.querySelector('.js-news-popup-success').style.display, 'block', 'Success message should be shown');

    // Flush timeouts to trigger modal hide
    flushTimeouts();

    assert.strictEqual(document.getElementById('home-modal').classList.contains('modal-show'), false, 'Modal should have modal-show removed');
    assert.strictEqual(document.getElementById('home-modal').style.display, 'none', 'Modal should be hidden');

    console.log("Running error path test...");

    // Test 3: Error Callback Path (The missing test)
    // Reset state
    document.querySelector('.js-news-spinner').style.display = 'block';
    document.querySelector('.js-news-popup-submit').disabled = true;
    document.querySelector('.js-news-popup-success').style.display = 'none';
    document.querySelector('.js-news-popup-failed').style.display = 'none';
    document.getElementById('home-modal').classList.add('modal-show');
    document.getElementById('home-modal').style.display = 'block';

    // Simulate error response
    currentCallback.call(successWrapper, { success: false });

    // Assertions for error path before timeouts
    assert.strictEqual(document.querySelector('.js-news-spinner').style.display, 'none', 'Spinner should be hidden after error callback');
    assert.strictEqual(document.querySelector('.js-news-popup-submit').disabled, false, 'Submit button should be enabled after error callback');
    assert.strictEqual(document.querySelector('.js-news-popup-failed').style.display, 'block', 'Failed message should be shown on error');
    assert.strictEqual(document.querySelector('.js-news-popup-success').style.display, 'none', 'Success message should NOT be shown on error');

    flushTimeouts();

    assert.strictEqual(document.getElementById('home-modal').classList.contains('modal-show'), true, 'Modal should remain shown on error');
    assert.notStrictEqual(document.getElementById('home-modal').style.display, 'none', 'Modal should not be hidden on error');

    console.log("All tests passed successfully! 🚀");
} catch (e) {
    console.error("Test failed:", e);
    process.exit(1);
} finally {
    // Restore setTimeout
    global.setTimeout = originalSetTimeout;
}
