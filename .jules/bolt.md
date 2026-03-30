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
