<<<<<<< HEAD
<<<<<<< HEAD
## 2024-05-24 - Intersection Observer vs. Scroll Events for Lazy Loading
**Learning:** The frontend used a scroll event listener coupled with `getBoundingClientRect()` to check for elements visibility for lazy loading `.js-section-video-products-lazy` items. Even with a 50ms throttle, `getBoundingClientRect()` triggers layout recalculation (thrashing) on scroll, which is a significant performance bottleneck, leading to janky scrolling on mobile devices and lower frame rates.
**Action:** Always prefer `IntersectionObserver` over scroll events and `getBoundingClientRect()` for visibility detection. It runs off the main thread and provides a much more performant way to know when elements enter the viewport.
=======

## 2026-04-30 - IntersectionObserver replacing Scroll Events
**Learning:** Found a scroll event listener using `getBoundingClientRect()` to trigger lazy loading. In modern browsers, this severely blocks the main thread and causes layout thrashing (forced synchronous layout). Replacing it with `IntersectionObserver` handles this asynchronously, offering huge performance gains on scroll-heavy frontend pages.
**Action:** When implementing or debugging scroll-based frontend logic (like lazy loading images/videos or sticky headers), prefer `IntersectionObserver` instead of manual scroll listeners with boundary checking.
>>>>>>> origin/bolt-intersection-observer-18396028972581411862
=======
## 2026-03-28 - [Replaced scroll listener with IntersectionObserver]
**Learning:** Scroll event listeners in the frontend used for things like lazy loading can block the main thread and impact scrolling performance.
**Action:** Always prefer `IntersectionObserver` for lazy loading logic over throttling scroll events.
>>>>>>> origin/bolt/intersection-observer-lazy-load-17289792565937233437

## 2024-05-28 - Optimized Swiper Slider DOM Queries & Redundant Listeners
**Learning:** In sliders with videos (`js-section-video-products`), querying the global DOM (e.g., `document.querySelectorAll`) inside Swiper callbacks (`slideChange`) is very expensive. Furthermore, attaching `timeupdate` and `ended` listeners to elements repeatedly without a guard causes significant memory leaks and duplicate handler executions.
**Action:** Always cache slider-specific DOM nodes (like `this.allVideos`) inside the `init` event, and access active/next slides using Swiper's internal array (`this.slides[this.activeIndex]`). Use a `dataset` attribute (e.g., `dataset.progressInitialized`) as a guard to ensure event listeners are attached only once.

## 2026-04-30 - Prevent IntersectionObserver memory leaks inside resize handlers
**Learning:** Initializing an `IntersectionObserver` within a `resize` event handler without disconnecting the previous instance causes severe memory leaks. On mobile devices, `resize` events fire frequently (e.g., when the browser's address bar collapses/expands), creating multiple orphaned observers that degrade scrolling performance.
**Action:** When initializing `IntersectionObserver` within event handlers that trigger frequently (like `resize`), you must store the observer instance in a higher scope and explicitly call `.disconnect()` before re-initializing it to prevent memory leaks and duplicate executions.
## 2026-04-11 - Optimize Scroll Listeners
**Learning:** Un-optimized scroll events without state tracking and the passive flag block the main thread and cause layout thrashing.
**Action:** Always add state tracking variables and the { passive: true } option to scroll event listeners.

## 2024-05-24 - Optimize Scroll Listeners
**Learning:** Un-optimized scroll events that repeatedly query the DOM and lack state tracking cause excessive reflows and block the main thread.
**Action:** Always add state tracking variables, cache DOM nodes outside the listener, and use the `{ passive: true }` option for scroll events.
## 2026-04-30 - Reused single IntersectionObserver for multiple elements
**Learning:** Creating a new `IntersectionObserver` instance for every single element in a list creates excessive concurrent observers, degrading performance.
**Action:** Always instantiate a single `IntersectionObserver` outside the loop, reuse it, and explicitly call `observer.unobserve(element)` once resolved.

## 2024-05-24 - Layout Thrashing in Scroll Listeners
**Learning:** Querying DOM properties like `.outerHeight()` inside an un-throttled scroll event listener, and repeatedly querying the same DOM elements (e.g., `jQueryNuvem(".js-head-main")`) on every scroll tick causes significant layout thrashing.
**Action:** Always cache DOM elements outside of scroll listeners, and throttle execution using `requestAnimationFrame` to align DOM reads/writes with the browser's render cycle.
## 2024-05-24 - Layout Thrashing in Un-throttled Scroll Listeners
**Learning:** Adding complex logic and DOM queries to un-throttled scroll event listeners blocks the main thread and forces synchronous layout recalculation, drastically degrading scroll performance (jank).
**Action:** Always wrap scroll listener logic in `requestAnimationFrame` with a boolean state tracking (`isTicking`), and cache external DOM dependencies outside the scroll listener.
