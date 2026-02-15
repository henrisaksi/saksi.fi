# Personal Website

[saksi.fi](https://saksi.fi)

Want to use this as template? Check out the template repository: [henrisaksi/sveltekit-template](https://github.com/henrisaksi/sveltekit-template)

My personal website is a containerized SvelteKit web application designed to run on Google Cloud Run. It utilizes a modern tech stack and a robust GitOps-style deployment pipeline managed by Google Cloud Build and Cloud Deploy. Infrastructure is provisioned using Terraform.

## 🚀 Technologies

*   **Application:**
    *   [SvelteKit](https://kit.svelte.dev/) (v2) with Node.js adapter
    *   [TypeScript](https://www.typescriptlang.org/)
    *   [Tailwind CSS](https://tailwindcss.com/) (v4)
    *   [Google Cloud Pub/Sub](https://cloud.google.com/pubsub) integration
*   **Infrastructure & DevOps:**
    *   [Google Cloud Run](https://cloud.google.com/run) (Serverless compute)
    *   [Terraform](https://www.terraform.io/) (Infrastructure as Code)
    *   [Google Cloud Build](https://cloud.google.com/build) (CI)
    *   [Google Cloud Deploy](https://cloud.google.com/deploy) (CD)
    *   [Skaffold](https://skaffold.dev/) (Local development & deployment configuration)
    *   [Docker](https://www.docker.com/)

## 📂 Project Structure

*   `svelte-app/`: The source code for the SvelteKit application.
*   `terraform/`: Terraform configurations to provision Google Cloud infrastructure.
*   `clouddeploy/`: Kubernetes/Knative manifests for Cloud Deploy (Cloud Run services).
*   `cloudbuild.yaml`: Configuration for the build pipeline.
*   `skaffold.yaml`: Configuration for local development and deployment rendering.
*   `Dockerfile`: Multi-stage Docker build for the application.

## 🛠 Prerequisites

Ensure you have the following installed:

*   [Node.js](https://nodejs.org/) (v20 or later)
*   [Docker](https://www.docker.com/)
*   [Google Cloud CLI (`gcloud`)](https://cloud.google.com/sdk/docs/install)
*   [Terraform](https://developer.hashicorp.com/terraform/install)
*   [Skaffold](https://skaffold.dev/docs/install/) (Optional, for local container dev)

## 💻 Local Development

### Running the App Locally (Native)

1.  Navigate to the app directory:
    ```bash
    cd svelte-app
    ```
2.  Install dependencies:
    ```bash
    npm install
    ```
3.  Start the development server:
    ```bash
    npm run dev
    ```

### Running with Docker/Skaffold

To test the containerized version locally:

```bash
skaffold dev
```

## ☁️ Infrastructure Setup

Infrastructure is managed with Terraform. For detailed instructions on how to provision the infrastructure, configure variables, and set up the necessary prerequisites (like domain verification and GitHub tokens), please refer to the **[Terraform README](terraform/README.md)**.

## 🔄 Build and Deployment Pipeline

The project uses a continuous delivery pipeline involving Google Cloud Build and Cloud Deploy.

1.  **Build (Cloud Build):** Builds the Docker image and pushes it to Artifact Registry.
2.  **Deploy (Google Cloud Deploy):** Deploys the image to Cloud Run.

For a deep dive into technical details of the pipeline, see the **[Terraform README](terraform/README.md)**.

To manually trigger a build and deploy via CLI:

```bash
gcloud builds submit --config=cloudbuild.yaml .
```

