
## $(date +%Y-%m-%d) - IntersectionObserver replacing Scroll Events
**Learning:** Found a scroll event listener using `getBoundingClientRect()` to trigger lazy loading. In modern browsers, this severely blocks the main thread and causes layout thrashing (forced synchronous layout). Replacing it with `IntersectionObserver` handles this asynchronously, offering huge performance gains on scroll-heavy frontend pages.
**Action:** When implementing or debugging scroll-based frontend logic (like lazy loading images/videos or sticky headers), prefer `IntersectionObserver` instead of manual scroll listeners with boundary checking.
