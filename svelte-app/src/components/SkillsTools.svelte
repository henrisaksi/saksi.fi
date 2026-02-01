<script lang="ts">
	import { scrollCenter } from '$lib/actions/scrollCenter';
	interface Skill {
		name: string;
		icon: string; // Path to SVG or class for icon font
	}

	const skills: Skill[] = [
		{ name: 'Google Cloud', icon: '/icons/gcp.svg' },
		{ name: 'Snowflake', icon: '/icons/snowflake.png' },
		{ name: 'BigQuery', icon: '/icons/bigquery.svg' },
		{ name: 'Terraform', icon: '/icons/terraform.svg' },
		{ name: 'Kubernetes', icon: '/icons/kubernetes.png' },
		{ name: 'Python', icon: '/icons/python.png' },
		{ name: 'Tableau', icon: '/icons/tableau.svg' },
		{ name: 'dbt', icon: '/icons/dbt.svg' },
		{ name: 'Dagster', icon: '/icons/dagster.svg' },
		{ name: 'Airflow', icon: '/icons/airflow.svg' },
		{ name: 'Supermetrics', icon: '/icons/supermetrics.svg' },
		{ name: 'Fivetran', icon: '/icons/fivetran.png' }
	];

	let activeIndex = 0;
</script>

<section class="py-16 bg-transparent" role="listitem">
	<h2 class="text-4xl font-extrabold text-white text-center mb-12">Skills & Tools</h2>

	<div
		class="max-w-6xl mx-auto grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4 px-4"
		role="list"
	>
		{#each skills as skill, i}
			<div
				role="button"
				tabindex="0"
				class="skill-card relative flex flex-col items-center justify-center p-6 bg-gray-800/80 backdrop-blur-sm rounded-lg shadow-lg transition-all duration-300 ease-out cursor-pointer {activeIndex ===
				i
					? 'active'
					: ''}"
				on:pointerenter={() => (activeIndex = i)}
				on:pointerleave={() => (activeIndex = -1)}
				use:scrollCenter={() => {
					if (typeof window !== 'undefined' && window.innerWidth < 1024) {
						activeIndex = i;
					}
				}}
			>
				<img
					src={skill.icon}
					alt={skill.name}
					class="w-16 h-16 mb-4 filter transition-all duration-300 ease-out"
				/>
				<p class="text-lg font-semibold text-white">{skill.name}</p>
			</div>
		{/each}
	</div>
</section>

<style>
	.skill-card:hover,
	.skill-card.active {
		transform: scale(1.05);
		border: 1px solid theme('colors.blue.500');
		box-shadow:
			0 20px 25px -5px rgb(0 0 0 / 0.1),
			0 8px 10px -6px rgb(0 0 0 / 0.1);
	}

	.skill-card:hover img,
	.skill-card.active img {
		filter: grayscale(0);
	}

	.skill-card {
		border: 1px solid transparent; /* Prevents layout shift when border appears */
		transition:
			transform 0.3s ease-out,
			box-shadow 0.3s ease-out,
			border 0.3s ease-out;
	}

	.skill-card img {
		filter: grayscale(100%);
		transition: filter 0.3s ease-out;
	}
</style>
