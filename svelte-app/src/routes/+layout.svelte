<script lang="ts">
	import '../app.css';
</script>

<div class="min-h-screen bg-gray-900 text-gray-100 flex flex-col">
	<slot />
</div>

<style lang="postcss">
	:global(html) {
		@apply scroll-smooth;
	}
</style>
