<script lang="ts">
	import { scrollCenter } from '$lib/actions/scrollCenter';

	interface ExperienceItem {
		id: number;
		company: string;
		title: string;
		period: string;
		description: string;
		brandColor: string;
		isOdd?: boolean;
	}

	const experiences: ExperienceItem[] = [
		{
			id: 1,
			company: 'Supermetrics',
			title: 'Lead Data Platform Engineer',
			period: '2026 - Present',
			description: 'Designing and developing internal Data Platform.',
			brandColor: '#D32329' // Red
		},
		{
			id: 2,
			company: 'Fiksuruoka.fi – Foodello',
			title: 'Chief Data Officer',
			period: '2018 - 2025',
			description:
				'Built data capabilities from scratch. Built and led team of Data Engineers and Analysts.',
			brandColor: '#2e7a75' // Green
		},
		{
			id: 3,
			company: 'Aalto University',
			title: 'MSc in Industrial Engineering and Management',
			period: '2014 - 2021',
			description: 'Minoring in Machine Learning, Data Science and Artificial Intelligence.',
			brandColor: '#FF8D4F' // Aalto School of Science color (Orange)
		}
	].map((item, i) => ({ ...item, isOdd: i % 2 !== 0 }));

	let activeId: number | null = null;

	// Action to handle intersection observer for each element (animation)
	function viewport(element: HTMLElement) {
		const observer = new IntersectionObserver(
			(entries) => {
				entries.forEach((entry) => {
					if (entry.isIntersecting) {
						entry.target.classList.add('in-view');
						observer.unobserve(entry.target); // Trigger once
					}
				});
			},
			{ threshold: 0.1, rootMargin: '0px 0px -50px 0px' }
		);

		observer.observe(element);

		return {
			destroy() {
				observer.disconnect();
			}
		};
	}
</script>

<section class="relative py-24 bg-transparent overflow-hidden min-h-screen">
	<div class="relative z-10 max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
		<h2 class="text-5xl font-bold text-center text-white mb-20 tracking-tight">Experience</h2>

		<div class="relative">
			<!-- Vertical Spine -->
			<div
				class="absolute left-0 md:left-1/2 transform -translate-x-1/2 w-0.5 h-full bg-gray-800 rounded-full"
			></div>

			{#each experiences as item (item.id)}
				<!-- Timeline Row -->
				<div
					class="timeline-row flex items-center justify-between w-full mb-12 sm:mb-24 {item.isOdd
						? 'md:flex-row-reverse timeline-row-odd'
						: ''}"
					use:viewport
				>
					<!-- Spacer (Opposite Side) -->
					<div class="w-1/2 hidden md:block"></div>

					<!-- Center Point (Absolute to Spine) -->
					<div
						class="absolute left-0 md:left-1/2 transform -translate-x-1/2 w-4 h-4 rounded-full border-4 border-gray-900 z-10 transition-colors duration-300 {activeId ===
						item.id
							? 'bg-blue-500 scale-125'
							: 'bg-gray-600'}"
						style="background-color: {activeId === item.id ? item.brandColor : ''}"
					></div>

					<!-- Content Card -->
					<div class="w-full md:w-[45%] relative group pl-8 md:pl-0">
						<div
							class="p-6 md:p-8 rounded-2xl bg-gray-800/50 border border-gray-700/50 backdrop-blur-sm shadow-xl transition-all duration-300 {activeId ===
							item.id
								? 'active-card -translate-y-1 shadow-2xl bg-gray-800 border-gray-600'
								: 'hover:-translate-y-1 hover:shadow-2xl hover:bg-gray-800 hover:border-gray-600'}"
							on:mouseenter={() => (activeId = item.id)}
							use:scrollCenter={() => (activeId = item.id)}
							role="group"
						>
							<div class="flex flex-col">
								<span
									class="font-mono text-sm tracking-wider mb-2"
									style="color: {item.brandColor}"
								>
									{item.period}
								</span>
								<h3
									class="text-2xl font-bold text-white mb-1 transition-colors"
									style="color: {activeId === item.id
										? item.brandColor
										: ''}; --brand-hover-color: {item.brandColor}"
								>
									{item.company}
								</h3>
								<h4 class="text-lg text-gray-400 mb-4">{item.title}</h4>
								<p class="text-gray-300 leading-relaxed text-sm md:text-base">
									{item.description}
								</p>
							</div>
						</div>
					</div>
				</div>
			{/each}
		</div>
	</div>
</section>

<style>
	/* Animation States */
	.timeline-row {
		opacity: 0;
		transition:
			opacity 1s ease-out,
			transform 1s cubic-bezier(0.16, 1, 0.3, 1);
	}

	/* Initial positions */
	/* Even (Right aligned content) - row is normal flex, content is on right */
	/* We want the ROW to slide or the CONTENT?
       If we slide the row, the spacer slides too. That's fine.
    */

	/* Default (Even/Right): Slide in from Right */
	.timeline-row {
		transform: translateX(50px);
	}

	/* Odd (Left aligned content): Slide in from Left (Desktop Only) */
	@media (min-width: 768px) {
		.timeline-row-odd {
			transform: translateX(-50px);
		}
	}

	/* Visible State */
	.timeline-row:global(.in-view) {
		opacity: 1;
		transform: translateX(0);
	}

	.active-card {
		border-color: theme('colors.blue.500') !important;
		box-shadow: 0 0 20px rgba(59, 130, 246, 0.2);
	}

	.group:hover h3 {
		color: var(--brand-hover-color) !important;
	}
</style>
