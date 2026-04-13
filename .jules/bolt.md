<<<<<<< HEAD
<<<<<<< HEAD
## 2024-05-24 - Intersection Observer vs. Scroll Events for Lazy Loading
**Learning:** The frontend used a scroll event listener coupled with `getBoundingClientRect()` to check for elements visibility for lazy loading `.js-section-video-products-lazy` items. Even with a 50ms throttle, `getBoundingClientRect()` triggers layout recalculation (thrashing) on scroll, which is a significant performance bottleneck, leading to janky scrolling on mobile devices and lower frame rates.
**Action:** Always prefer `IntersectionObserver` over scroll events and `getBoundingClientRect()` for visibility detection. It runs off the main thread and provides a much more performant way to know when elements enter the viewport.
=======

## $(date +%Y-%m-%d) - IntersectionObserver replacing Scroll Events
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

## $(date +%Y-%m-%d) - Prevent IntersectionObserver memory leaks inside resize handlers
**Learning:** Initializing an `IntersectionObserver` within a `resize` event handler without disconnecting the previous instance causes severe memory leaks. On mobile devices, `resize` events fire frequently (e.g., when the browser's address bar collapses/expands), creating multiple orphaned observers that degrade scrolling performance.
**Action:** When initializing `IntersectionObserver` within event handlers that trigger frequently (like `resize`), you must store the observer instance in a higher scope and explicitly call `.disconnect()` before re-initializing it to prevent memory leaks and duplicate executions.
## 2024-05-24 - Optimization of legacy scroll listeners
**Learning:** Found several active scroll event listeners in `store.js.tpl` (e.g. for sticky category controls and slim headers) executing expensive `.outerHeight()`, `.css()`, and `.addClass()` calls on every frame without passive configuration or state checking. This forces repeated main-thread blocking operations, causing dropped frames on scroll.
**Action:** When optimizing unavoidable scroll event listeners, implement state tracking variables to ensure DOM updates only occur when the actual state changes, cache DOM queries outside the listener, and append `{ passive: true }` to prevent main-thread blocking.
