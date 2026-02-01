<script lang="ts">
	import { onMount } from 'svelte';

	let scrollY = 0;
	let innerHeight = 0;
	let innerWidth = 0;

	// Configuration for shapes
	const shapes = [
		{ type: 'circle', top: '10%', left: '5%', size: 40, speed: 0.2, color: 'bg-blue-500', opacity: 0.1 },
		{ type: 'square', top: '25%', left: '85%', size: 60, speed: 0.15, color: 'bg-purple-500', opacity: 0.1 },
		{ type: 'triangle', top: '45%', left: '15%', size: 50, speed: 0.25, color: 'bg-teal-500', opacity: 0.1 },
		{ type: 'circle', top: '60%', left: '75%', size: 80, speed: 0.1, color: 'bg-indigo-500', opacity: 0.08 },
		{ type: 'square', top: '80%', left: '10%', size: 45, speed: 0.3, color: 'bg-pink-500', opacity: 0.1 },
		{ type: 'triangle', top: '15%', left: '50%', size: 30, speed: 0.18, color: 'bg-orange-500', opacity: 0.1 },
		{ type: 'circle', top: '90%', left: '60%', size: 100, speed: 0.12, color: 'bg-cyan-500', opacity: 0.05 },
		{ type: 'square', top: '35%', left: '30%', size: 25, speed: 0.22, color: 'bg-emerald-500', opacity: 0.1 },
        { type: 'circle', top: '5%', left: '90%', size: 120, speed: 0.08, color: 'bg-blue-400', opacity: 0.05 },
        { type: 'triangle', top: '70%', left: '40%', size: 60, speed: 0.14, color: 'bg-red-400', opacity: 0.08 },
	];

    // Generate more random small particles
    const particles = Array.from({ length: 20 }, (_, i) => ({
        top: `${Math.random() * 100}%`,
        left: `${Math.random() * 100}%`,
        size: Math.random() * 10 + 4,
        speed: Math.random() * 0.4 + 0.1,
        color: ['bg-blue-300', 'bg-purple-300', 'bg-teal-300'][Math.floor(Math.random() * 3)],
        opacity: Math.random() * 0.1 + 0.05
    }));

</script>

<svelte:window bind:scrollY bind:innerHeight bind:innerWidth />

<div class="fixed inset-0 overflow-hidden pointer-events-none z-[-1] bg-gray-900">
	<!-- Soft Gradient Mesh -->
	<div class="absolute inset-0">
        <div class="absolute top-[-20%] left-[-10%] w-[50%] h-[50%] rounded-full bg-blue-600/20 blur-[100px] animate-pulse-slow"></div>
        <div class="absolute bottom-[-10%] right-[-10%] w-[60%] h-[60%] rounded-full bg-purple-600/20 blur-[120px] animate-pulse-slow" style="animation-delay: 2s;"></div>
        <div class="absolute top-[40%] left-[40%] w-[40%] h-[40%] rounded-full bg-teal-600/20 blur-[90px] animate-pulse-slow" style="animation-delay: 4s;"></div>
	</div>

	<!-- Shapes -->
	{#each shapes as shape, i}
		<div
			class="absolute {shape.color} backdrop-blur-sm"
			style="
				top: {shape.top};
				left: {shape.left};
				width: {shape.size}px;
				height: {shape.size}px;
				opacity: {shape.opacity};
				transform: translateY({-(scrollY * shape.speed)}px) rotate({scrollY * 0.1 * (i % 2 === 0 ? 1 : -1)}deg);
                border-radius: {shape.type === 'circle' ? '50%' : shape.type === 'square' ? '10%' : '0'};
                clip-path: {shape.type === 'triangle' ? 'polygon(50% 0%, 0% 100%, 100% 100%)' : 'none'};
			"
		></div>
	{/each}

    <!-- Particles -->
    {#each particles as particle, i}
        <div
            class="absolute {particle.color} rounded-full"
            style="
                top: {particle.top};
                left: {particle.left};
                width: {particle.size}px;
                height: {particle.size}px;
                opacity: {particle.opacity};
                transform: translateY({-(scrollY * particle.speed)}px);
            "
        ></div>
    {/each}
</div>

<style>
    @keyframes pulse-slow {
        0%, 100% { transform: scale(1); opacity: 1; }
        50% { transform: scale(1.1); opacity: 0.7; }
    }
    .animate-pulse-slow {
        animation: pulse-slow 8s infinite ease-in-out;
        animation-fill-mode: both;
    }
</style>
