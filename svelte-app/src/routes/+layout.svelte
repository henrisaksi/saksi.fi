<script lang="ts">
	import '../app.css';
	import favicon from '$lib/assets/favicon.svg';

	let { children } = $props();
</script>

<svelte:head>
	<link rel="icon" href={favicon} />
</svelte:head>

<main class="min-h-screen flex flex-col">
	<header class="flex items-center justify-between p-4 border-b bg-white shadow-sm">
		<!-- Left: burger menu -->
		<button class="flex flex-col space-y-1">
			<span class="block w-6 h-0.5 bg-gray-800"></span>
			<span class="block w-6 h-0.5 bg-gray-800"></span>
			<span class="block w-6 h-0.5 bg-gray-800"></span>
		</button>

		<!-- Center: title -->
		<h1 class="text-lg font-semibold text-gray-800">moonshot</h1>

		<!-- Right: empty placeholder -->
		<div class="w-6"></div>
	</header>
	<div class="flex-1">
		{@render children?.()}
	</div>

	<footer class="mt-10 p-4 bg-gray-100 text-center text-sm text-gray-600">
		<p>© {new Date().getFullYear()} MyProject. All rights reserved.</p>
		<p>Some placeholder footer text here.</p>
	</footer>
</main>
