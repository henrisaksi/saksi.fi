<script lang="ts">
	import '../app.css';
	import ParallaxBackground from '../components/ParallaxBackground.svelte';
</script>

<ParallaxBackground />

<div class="min-h-screen text-gray-100 flex flex-col relative z-10">
	<slot />
</div>

<style lang="postcss">
	:global(html) {
		@apply scroll-smooth;
		background-color: #111827;
	}
</style>
