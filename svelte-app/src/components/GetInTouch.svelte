<script lang="ts">
	import { fade, fly, slide } from 'svelte/transition';

	let step = 1;
	let message = '';
	let email = '';
	let isFocused = false;
	let showValidation = false;
	let isSent = false;

	// Reactive email validation
	$: isEmailValid = /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
	$: canProceed = step === 1 ? message.trim().length > 0 : isEmailValid;

	function handleNext() {
		if (step === 1) {
			if (message.trim().length > 0) {
				step = 2;
			} else {
				triggerValidation();
			}
		} else if (step === 2) {
			if (isEmailValid) {
				handleSubmit();
			} else {
				triggerValidation();
			}
		}
	}

	let validationTimeout: ReturnType<typeof setTimeout>;

	function triggerValidation() {
		showValidation = true;
		clearTimeout(validationTimeout);
		validationTimeout = setTimeout(() => (showValidation = false), 3000);
	}

	function clearValidation() {
		showValidation = false;
		clearTimeout(validationTimeout);
	}

	function handleSubmit() {
		const formData = new FormData();
		formData.append('message', message);
		formData.append('email', email);

		fetch('?/submitMessage', {
			method: 'POST',
			body: formData
		})
			.then((response) => {
				if (response.ok) {
					isSent = true;
				} else {
					// Handle error if needed
					console.error('Submission failed');
				}
			})
			.catch((error) => {
				console.error('Error:', error);
			});
	}

	function handleKeydown(e: KeyboardEvent) {
		if (e.key === 'Enter' && !e.shiftKey) {
			e.preventDefault();
			handleNext();
		}
	}

	function autoResize(e: Event) {
		const target = e.target as HTMLTextAreaElement;
		adjustHeight(target);
	}

	function adjustHeight(node: HTMLTextAreaElement) {
		node.style.height = 'auto';
		node.style.height = node.scrollHeight + 'px';
	}

	function resizeTextarea(node: HTMLTextAreaElement) {
		adjustHeight(node);
	}
</script>

<section class="min-h-[60vh] flex flex-col items-center pt-32 pb-20 px-4 relative">
	<h2 class="text-4xl font-extrabold text-white text-center mb-24">Get in Touch</h2>

	<div class="w-full max-w-3xl relative">
		{#if isSent}
			<div in:fade={{ duration: 400 }} class="text-center absolute inset-0 -top-10">
				<div
					class="inline-flex items-center justify-center w-20 h-20 rounded-full bg-green-500 mb-6 shadow-[0_0_20px_rgba(34,197,94,0.5)]"
				>
					<svg class="w-10 h-10 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
						<path
							stroke-linecap="round"
							stroke-linejoin="round"
							stroke-width="3"
							d="M5 13l4 4L19 7"
						/>
					</svg>
				</div>
				<h3 class="text-3xl font-bold text-white mb-2">Message Sent!</h3>
				<p class="text-gray-400 text-lg">I'll get back to you soon.</p>
			</div>
		{:else}
			<!-- Previous Answer Context (The "Slide up" effect) -->
			{#if step === 2}
				<div class="mb-6" transition:slide={{ duration: 400, axis: 'y' }}>
					<!-- svelte-ignore a11y-click-events-have-key-events -->
					<!-- svelte-ignore a11y-no-static-element-interactions -->
					<div
						class="w-full text-gray-500 font-mono text-sm md:text-base cursor-pointer group hover:text-blue-400 transition-colors"
						on:click={() => (step = 1)}
					>
						<div class="flex items-center gap-2">
							<span
								class="block text-xs uppercase tracking-widest mb-1 text-gray-600 group-hover:text-blue-400"
								>Message <span class="text-[10px] lowercase opacity-50 ml-1">(click to edit)</span
								></span
							>
						</div>
						<div class="max-w-xl text-gray-400 italic group-hover:text-blue-300 break-words">
							"{message}"
						</div>
					</div>
				</div>
			{/if}

			<!-- The Line Container -->
			<div
				class="relative w-full border-b-2 grid grid-cols-1"
				class:shake={showValidation}
				class:border-gray-700={!isFocused && !showValidation && !isEmailValid}
				class:border-white={isFocused && !showValidation && step === 1}
				class:border-blue-500={step === 2 && isFocused && !showValidation}
				class:border-green-400={step === 2 && isEmailValid && !showValidation}
				class:border-red-500={showValidation}
				class:shadow-[0_4px_20px_rgba(239,68,68,0.3)]={showValidation}
				class:shadow-[0_4px_20px_rgba(96,165,250,0.3)]={step === 2 && isFocused && !isEmailValid}
				class:shadow-[0_4px_20px_rgba(74,222,128,0.3)]={step === 2 && isEmailValid}
			>
				<!-- Step 1: Message Input -->
				{#if step === 1}
					<div class="col-start-1 row-start-1 w-full" out:slide={{ duration: 400, axis: 'y' }}>
						<textarea
							bind:value={message}
							on:focus={() => (isFocused = true)}
							on:blur={() => (isFocused = false)}
							on:keydown={handleKeydown}
							on:input={(e) => {
								autoResize(e);
								clearValidation();
							}}
							use:resizeTextarea
							rows="1"
							class="w-full bg-transparent text-xl md:text-3xl text-white placeholder-gray-600 outline-none py-4 px-6 pr-42 font-light resize-none overflow-hidden"
							placeholder="I have an idea for..."
							autofocus
							in:fade={{ duration: 300, delay: 50 }}
						/>
					</div>
				{/if}

				<!-- Step 2: Email Input -->
				{#if step === 2}
					<div class="col-start-1 row-start-1 w-full" in:fade={{ duration: 300, delay: 200 }}>
						<input
							type="email"
							bind:value={email}
							on:focus={() => (isFocused = true)}
							on:blur={() => (isFocused = false)}
							on:keydown={handleKeydown}
							on:input={clearValidation}
							class="w-full bg-transparent text-xl md:text-3xl text-white placeholder-gray-600 outline-none py-4 px-6 pr-42 font-light"
							placeholder="My email is..."
							autofocus
						/>
					</div>
				{/if}

				<!-- Action Button (Next/Send) -->
				<button
					on:click={handleNext}
					class="absolute right-4 top-1/2 -translate-y-1/2 text-white transition-all duration-300 group"
					class:opacity-40={!canProceed}
					class:opacity-100={canProceed}
					class:hover:scale-110={canProceed}
				>
					{#if step === 1}
						<div class="flex items-center gap-2">
							<span
								class="hidden md:inline text-lg font-bold tracking-widest uppercase opacity-0 group-hover:opacity-100 transition-opacity duration-300 translate-x-4 group-hover:translate-x-0"
								>Next</span
							>
							<svg
								class="w-8 h-8 md:w-10 md:h-10 transform group-hover:translate-x-1 transition-transform"
								fill="none"
								stroke="currentColor"
								viewBox="0 0 24 24"
							>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									stroke-width="2"
									d="M17 8l4 4m0 0l-4 4m4-4H3"
								/>
							</svg>
						</div>
					{:else}
						<div class="flex items-center gap-2">
							<span class="text-lg md:text-xl font-bold tracking-widest uppercase">Send</span>
							<svg
								class="w-6 h-6 md:w-8 md:h-8 transform -rotate-45 group-hover:rotate-0 transition-transform duration-300"
								fill="none"
								stroke="currentColor"
								viewBox="0 0 24 24"
							>
								<path
									stroke-linecap="round"
									stroke-linejoin="round"
									stroke-width="2"
									d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8"
								/>
							</svg>
						</div>
					{/if}
				</button>
			</div>

			<!-- Error / Validation Message -->
			{#if showValidation}
				<div
					class="absolute top-full left-0 mt-4 text-red-500 font-medium z-50 pointer-events-none"
					in:fade
				>
					<div class="flex items-center gap-2">
						<svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
							<path
								stroke-linecap="round"
								stroke-linejoin="round"
								stroke-width="2"
								d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
							/>
						</svg>
						{#if step === 1}
							Please tell me about your idea first.
						{:else}
							I'll need a valid email to get back to you!
						{/if}
					</div>
				</div>
			{/if}
		{/if}
	</div>
</section>

<style>
	/* Custom wobble for validation attention */
	:global(.shake) {
		animation: shake 0.5s cubic-bezier(0.36, 0.07, 0.19, 0.97) both;
	}

	@keyframes shake {
		10%,
		90% {
			transform: translate3d(-1px, 0, 0);
		}
		20%,
		80% {
			transform: translate3d(2px, 0, 0);
		}
		30%,
		50%,
		70% {
			transform: translate3d(-4px, 0, 0);
		}
		40%,
		60% {
			transform: translate3d(4px, 0, 0);
		}
	}
</style>
