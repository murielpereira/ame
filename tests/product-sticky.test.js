const assert = require('assert');
const path = require('path');
const fs = require('fs');

const scriptPath = path.join(__dirname, '../static/js/product-sticky.js');
const scriptContent = fs.readFileSync(scriptPath, 'utf8');

// The original script uses vanilla JS:
// document.querySelector('[data-store="product-price-278754942"]')
// document.querySelector('.lb-product-image-container-sticky')

let scrollListeners = [];
let resizeListeners = [];

const windowMock = {
    addEventListener: function(event, callback) {
        if (event === 'scroll') scrollListeners.push(callback);
        if (event === 'resize') resizeListeners.push(callback);
    }
};

let priceRect = { bottom: 0 };
let classList = new Set(['lb-product-image-container-sticky']);

let mockPriceElement = {
    getBoundingClientRect: () => priceRect
};

let mockStickyElement = {
    classList: {
        add: (cls) => classList.add(cls),
        remove: (cls) => classList.delete(cls),
        contains: (cls) => classList.has(cls)
    }
};

let documentMock = {};

const resetMocks = () => {
    scrollListeners = [];
    resizeListeners = [];
    priceRect = { bottom: 0 };
    classList = new Set(['lb-product-image-container-sticky']);
    documentMock = {
        querySelector: function(selector) {
            if (selector === '[data-store="product-price-278754942"]') {
                return mockPriceElement;
            }
            if (selector === '.lb-product-image-container-sticky') {
                return mockStickyElement;
            }
            return null;
        }
    };
};

const executeScript = () => {
    const fn = new Function('window', 'document', scriptContent);
    fn(windowMock, documentMock);
};

function runTest(name, setup, execute, verify) {
    console.log(`Running test: ${name}`);

    resetMocks();

    setup();
    execute();
    try {
        verify();
        console.log(`✅ Passed\n`);
    } catch (error) {
        console.error(`❌ Failed: ${error.message}\n`);
        process.exit(1);
    }
}

runTest(
    "Should attach scroll and resize event listeners",
    () => {
        executeScript();
    },
    () => {},
    () => {
        assert.ok(scrollListeners.length > 0, "Scroll listener should be attached");
        assert.ok(resizeListeners.length > 0, "Resize listener should be attached");
    }
);

runTest(
    "Should remove sticky class when price element scrolls out of view (bottom < 0)",
    () => {
        executeScript();
        priceRect.bottom = -10;
        classList.add('lb-product-image-container-sticky');
    },
    () => {
        scrollListeners.forEach(cb => cb());
    },
    () => {
        assert.strictEqual(classList.has('lb-product-image-container-sticky'), false, "Class should be removed");
    }
);

runTest(
    "Should add sticky class when price element is in view (bottom >= 0)",
    () => {
        executeScript();
        priceRect.bottom = 10;
        classList.delete('lb-product-image-container-sticky');
    },
    () => {
        scrollListeners.forEach(cb => cb());
    },
    () => {
        assert.strictEqual(classList.has('lb-product-image-container-sticky'), true, "Class should be added");
    }
);

runTest(
    "Should not throw if price element is missing",
    () => {
        documentMock.querySelector = function(selector) {
            if (selector === '.lb-product-image-container-sticky') return mockStickyElement;
            return null; // Missing price element
        };
        executeScript();
        classList.add('lb-product-image-container-sticky');
        priceRect.bottom = -10;
    },
    () => {
        scrollListeners.forEach(cb => cb());
    },
    () => {
        assert.strictEqual(classList.has('lb-product-image-container-sticky'), true, "Class should remain if price missing");
    }
);

console.log('All tests passed! 🎉');
