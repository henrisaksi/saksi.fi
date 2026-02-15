<script lang="ts">
	import { onMount } from 'svelte';
	import { spring } from 'svelte/motion';

	const roles = ['Data Platform Engineer', 'Developer', 'Data Engineer', 'Freelancer', 'Builder'];
	let currentText = '';
	let roleIndex = 0;
	let charIndex = 0;
	let isDeleting = false;
	let isError = false; // Flag to track typos
	let timeoutId: number; // Keep track of the timeout

	function type() {
		const currentRole = roles[roleIndex];
		const alphabet = 'abcdefghijklmnopqrstuvwxyz';
		let typingSpeed = isDeleting ? 50 : 150;

		if (isDeleting) {
			// Normal deleting logic
			currentText = currentRole.substring(0, charIndex - 1);
			charIndex--;

			// If we just finished deleting the typo, stop deleting and get back to work
			if (isError) {
				isError = false;
				isDeleting = false;
				typingSpeed = 200; // Quick pause after correcting
			}
		} else {
			// 10% chance to make a mistake, only if we aren't already in an error state
			// and we aren't at the very beginning or end of the string.
			const shouldMakeMistake =
				Math.random() < 0.05 && charIndex > 3 && charIndex < currentRole.length;

			if (shouldMakeMistake && !isError) {
				const randomChar = alphabet[Math.floor(Math.random() * alphabet.length)];
				currentText = currentRole.substring(0, charIndex) + randomChar;
				isError = true;
				typingSpeed = 150;
				// We don't increment charIndex here so that substring() knows where to return to
			} else {
				currentText = currentRole.substring(0, charIndex + 1);
				charIndex++;
			}
		}

		// Logic for finishing a word or an error
		if (isError && !isDeleting) {
			// We just typed the wrong char, now trigger the immediate "backspace"
			timeoutId = window.setTimeout(() => {
				isDeleting = true;
				type();
			}, 300); // Pause briefly so the user sees the mistake
			return;
		}

		if (!isDeleting && charIndex === currentRole.length) {
			isDeleting = true;
			typingSpeed = 1500; // Pause at end of word
		} else if (isDeleting && charIndex === 0) {
			isDeleting = false;
			roleIndex = (roleIndex + 1) % roles.length;
			typingSpeed = 500;
		}

		timeoutId = window.setTimeout(type, typingSpeed);
	}

	onMount(() => {
		type();
		lastScrollY = window.scrollY;
		return () => clearTimeout(timeoutId); // Cleanup on destroy
	});

	let turbulence = spring(0, {
		stiffness: 0.1,
		damping: 0.15
	});
	let resetTimeout: number;
	let lastScrollY = 0;
	let lastTouch: { x: number; y: number } | null = null;

	function handleMouseMove(event: MouseEvent) {
		const speed = Math.hypot(event.movementX, event.movementY);
		updateTurbulence(speed * 2);
	}

	function handleScroll() {
		const currentScrollY = window.scrollY;
		const speed = Math.abs(currentScrollY - lastScrollY);
		lastScrollY = currentScrollY;
		updateTurbulence(speed * 1.5);
	}

	function handleTouchMove(event: TouchEvent) {
		const touch = event.touches[0];
		if (lastTouch) {
			const speed = Math.hypot(touch.clientX - lastTouch.x, touch.clientY - lastTouch.y);
			updateTurbulence(speed * 2);
		}
		lastTouch = { x: touch.clientX, y: touch.clientY };
	}

	function updateTurbulence(value: number) {
		if (value > 0) {
			turbulence.set(Math.min(value, 20));

			clearTimeout(resetTimeout);
			resetTimeout = window.setTimeout(() => {
				turbulence.set(0);
				lastTouch = null;
			}, 100);
		}
	}
</script>

<svelte:window on:scroll={handleScroll} />

<section
	on:mousemove={handleMouseMove}
	on:touchmove={handleTouchMove}
	class="relative min-h-screen flex flex-col justify-center items-center overflow-hidden py-16 px-4"
	role="img"
>
	<div class="relative z-10 text-center">
		<div class="relative w-40 h-40 mx-auto mb-8 flex justify-center items-center">
			<div class="relative w-32 h-32 rounded-full overflow-hidden z-10">
				<img src="/images/profile-picture.jpeg" alt="Profile" class="w-full h-full object-cover" />
			</div>

			<svg class="absolute w-full h-full pointer-events-none" viewBox="0 0 100 100">
				<defs>
					<linearGradient id="gradient" x1="0%" y1="0%" x2="100%" y2="100%">
						<stop offset="0%" stop-color="#8e2de2" />
						<stop offset="100%" stop-color="#4a00e0" />
					</linearGradient>
					<filter id="liquid">
						<feTurbulence type="fractalNoise" baseFrequency="0.05" numOctaves="2" result="noise" />
						<feDisplacementMap in="SourceGraphic" in2="noise" scale={$turbulence} />
					</filter>
				</defs>
				<g class="animate-spin-slow origin-center">
					<circle
						cx="50"
						cy="50"
						r="46"
						stroke="url(#gradient)"
						stroke-width="2"
						fill="none"
						filter="url(#liquid)"
						class="animate-pulse-custom"
					/>
				</g>
			</svg>
		</div>

		<h1 class="text-8xl font-bold mb-4">Henri Saksi</h1>
		<div class="h-8 font-mono text-xl text-blue-400">
			&gt; <span class="typing-animation pr-1">{currentText}</span>
		</div>
	</div>
</section>

<style>
	/* Simplify the CSS - keep the logic in the script/markup */
	.typing-animation {
		border-right: 2px solid #60a5fa; /* Tailwind blue-400 */
		white-space: nowrap;
		animation: blink 0.75s step-end infinite;
	}

	@keyframes blink {
		from,
		to {
			border-color: transparent;
		}
		50% {
			border-color: #60a5fa;
		}
	}

	/* Force the image to stay circular even if the filter warps the container */
	img {
		mask-image: radial-gradient(circle, white 100%, transparent 100%);
	}

	.animate-spin-slow {
		animation: spin 10s linear infinite;
	}
	.origin-center {
		transform-box: fill-box;
		transform-origin: center;
	}
	.animate-pulse-custom {
		animation: pulse-scale 3s ease-in-out infinite;
	}
	@keyframes spin {
		from {
			transform: rotate(0deg);
		}
		to {
			transform: rotate(360deg);
		}
	}
	@keyframes pulse-scale {
		0%,
		100% {
			stroke-width: 2px;
			transform: scale(1);
		}
		50% {
			stroke-width: 3px;
			transform: scale(0.98);
		}
	}
</style>
