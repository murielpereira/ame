## 2026-03-28 - [Replaced scroll listener with IntersectionObserver]
**Learning:** Scroll event listeners in the frontend used for things like lazy loading can block the main thread and impact scrolling performance.
**Action:** Always prefer `IntersectionObserver` for lazy loading logic over throttling scroll events.
