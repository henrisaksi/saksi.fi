<script lang="ts">
	import HeroSection from '../components/HeroSection.svelte';
	import ExperienceTimeline from '../components/ExperienceTimeline.svelte';
	import SkillsTools from '../components/SkillsTools.svelte';
	import GetInTouch from '../components/GetInTouch.svelte';

	const schema = {
		'@context': 'https://schema.org',
		'@type': 'Person',
		name: 'Henri Saksi',
		url: 'https://saksi.fi',
		jobTitle: 'Data Platform Engineer',
		sameAs: ['https://www.linkedin.com/in/henrisaksi/', 'https://github.com/henrisaksi'],
		knowsAbout: [
			'Data Platform Engineering',
			'Data Engineering',
			'Google Cloud Platform',
			'Snowflake',
			'BigQuery',
			'dbt',
			'Python',
			'Terraform',
			'Agentic Coding',
			'Svelte',
			'TypeScript'
		],
		makesOffer: {
			'@type': 'Offer',
			itemOffered: {
				'@type': 'Service',
				name: 'Freelance Data Engineering Services'
			}
		}
	};
</script>

<svelte:head>
	<title>Henri Saksi - Data Platform Engineer</title>
	<meta
		name="description"
		content="Henri Saksi is a Data Platform Engineer specializing in GCP, Snowflake, and Python. Open to freelance opportunities in data engineering and agentic coding."
	/>
	<meta
		name="keywords"
		content="Data Platform Engineer, Data Engineer, Freelancer, Agentic Coding, GCP, Snowflake, Python, Terraform"
	/>
	<meta property="og:title" content="Henri Saksi - Data Platform Engineer & Freelancer" />
	<meta
		property="og:description"
		content="Building scalable data platforms and modern web solutions. Expert in GCP, Snowflake, and Agentic Coding."
	/>
	<meta property="og:type" content="profile" />
	<meta property="og:url" content="https://saksi.fi/" />
	<meta property="og:image" content="https://saksi.fi/images/profile-picture.jpeg" />
	<script type="application/ld+json">
		{@html JSON.stringify(schema)}
	</script>
</svelte:head>

<HeroSection />
<ExperienceTimeline />
<SkillsTools />
<GetInTouch />
