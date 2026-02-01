export function scrollCenter(
	element: HTMLElement,
	callback: (isIntersecting: boolean) => void,
	options = { rootMargin: '-48% 0% -48% 0%' }
) {
	// IntersectionObserver to detect when element is in the vertical center of the viewport
	const observer = new IntersectionObserver(
		(entries) => {
			entries.forEach((entry) => {
				callback(entry.isIntersecting);
			});
		},
		{
			rootMargin: options.rootMargin,
			threshold: 0
		}
	);

	observer.observe(element);

	return {
		destroy() {
			observer.disconnect();
		}
	};
}
