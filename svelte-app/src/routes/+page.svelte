<script lang="ts">
	import HeroSection from '../components/HeroSection.svelte';
	import ExperienceTimeline from '../components/ExperienceTimeline.svelte';
	import SkillsTools from '../components/SkillsTools.svelte';
	import GetInTouch from '../components/GetInTouch.svelte';
</script>

<svelte:head>
	<title>Henri Saksi - Data Platform Engineer</title>
	<meta
		name="description"
		content="Henri Saksi is a Data Platform Engineer building scalable cloud infrastructure. Specialized in modern data stacks including GCP, Snowflake, Kubernetes and dbt."
	/>
	<meta
		name="keywords"
		content="Data Platform Engineer, Data Engineer, Freelancer, Agentic Coding, GCP, Snowflake, Python, Terraform, Helsinki, Finland"
	/>
	<meta property="og:title" content="Henri Saksi - Data Platform Engineer" />
	<meta
		property="og:description"
		content="Henri Saksi is a Data Platform Engineer building scalable cloud infrastructure. Specialized in modern data stacks including GCP, Snowflake, Kubernetes and dbt."
	/>
	<meta property="og:type" content="profile" />
	<meta property="og:url" content="https://saksi.fi/" />
	<meta property="og:image" content="https://saksi.fi/images/profile-picture.jpeg" />
	<link rel="canonical" href="https://saksi.fi/" />
	<script type="application/ld+json">
		{
			"@context": "https://schema.org",
			"@type": "Person",
			"name": "Henri Saksi",
			"url": "https://saksi.fi",
			"jobTitle": "Data Platform Engineer",
			"sameAs": ["https://www.linkedin.com/in/henrisaksi/", "https://github.com/henrisaksi"],
			"knowsAbout": [
				"Data Platform Engineering",
				"Data Engineering",
				"Data Architecture",
				"Cloud Infrastructure",
				"Google Cloud Platform (GCP)",
				"Snowflake",
				"BigQuery",
				"dbt",
				"Python",
				"Terraform",
				"Kubernetes",
				"ArgoCD",
				"Dagster",
				"Airflow",
				"Fivetran",
				"Supermetrics",
				"Tableau",
				"Looker",
				"Agentic Coding",
				"Claude Code",
				"Svelte",
				"TypeScript",
				"SQL"
			],
			"makesOffer": [
				{
					"@type": "Offer",
					"itemOffered": {
						"@type": "Service",
						"name": "Freelance Data Engineering",
						"description": "Building scalable cloud data platforms and modern data stacks."
					}
				},
				{
					"@type": "Offer",
					"itemOffered": {
						"@type": "Service",
						"name": "Data Platform Architecture",
						"description": "Designing robust, automated, and secure data infrastructure using Infrastructure as Code."
					}
				}
			]
		}
	</script>
</svelte:head>

<HeroSection />
<ExperienceTimeline />
<SkillsTools />
<GetInTouch />
