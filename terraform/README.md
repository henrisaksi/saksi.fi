# Build and Deployment Pipeline

This repository contains the Terraform configuration for a fully automated CI/CD pipeline on Google Cloud Platform (GCP). It deploys a SvelteKit application to Cloud Run and attaches a custom domain.

## Architecture & Technical Details

The pipeline is built using the following GCP services:

1.  **Cloud Build**: Acts as the CI engine. It is triggered by pushes to the GitHub repository.
    *   **Build Step**: Builds the Docker image from the source code.
    *   **Push Step**: Pushes the image to **Artifact Registry**.
    *   **Release Step**: Creates a new release in **Cloud Deploy**.
2.  **Artifact Registry**: Stores the versioned Docker images.
3.  **Cloud Deploy**: Manages the CD (Continuous Delivery) process.
    *   It uses a `delivery_pipeline` to manage the lifecycle of a deployment.
    *   It targets **Cloud Run v2** for the final deployment.
4.  **Cloud Run v2**: Hosts the containerized SvelteKit application.
5.  **Secret Manager**: Securely stores the GitHub Personal Access Token (PAT) used by Cloud Build to connect to the repository.

### The Flow
1.  **Code Push**: A developer pushes code to GitHub.
2.  **Trigger**: Cloud Build detects the push and starts a build.
3.  **Containerize**: Cloud Build creates a container image and stores it in Artifact Registry.
4.  **Deploy**: Cloud Build triggers Cloud Deploy to create a "Release". Cloud Deploy then rolls out the new version to the Cloud Run v2 service.
5.  **Networking**: The Cloud Run service is accessible via a custom domain managed by a Domain Mapping resource.

---

## Getting Started

Follow these steps to deploy this infrastructure to a new GCP project.

### Prerequisites

*   A GCP Project with billing enabled.
*   [Terraform](https://www.terraform.io/downloads.html) (>= 1.14.4) installed locally.
*   [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) installed and authenticated (`gcloud auth application-default login`).
*   A GitHub Personal Access Token (PAT) with `repo` and `read:org` scopes.
*   A verified domain in your GCP project (for domain mapping).

### Setup Steps

1.  **Clone the Repository**
    ```bash
    git clone <repository-url>
    cd terraform
    ```

2.  **Domain Verification (Prerequisite)**
    Before applying the Terraform configuration, you must verify ownership of your domain in GCP:
    1.  Acquire a domain (e.g., `example.com`).
    2.  Go to the [Google Search Console Verification page](https://www.google.com/webmasters/verification/verification?domain=example.com) (replace `example.com` with your domain).
    3.  Complete domain ownership verification by adding the required TXT DNS record and clicking **Verify**.

3.  **Configure Variables**
    Copy the example variables file and fill in your details:
    ```bash
    cp terraform.tfvars.example terraform.tfvars
    ```
    Edit `terraform.tfvars` and provide:
    *   `project_id`: Your GCP project ID.
    *   `github_owner`: Your GitHub username or org.
    *   `github_repo`: The repository name.
    *   `github_pat`: Your GitHub Personal Access Token.
    *   `domain_name`: Your custom domain (e.g., `example.com`).

4.  **Initialize Terraform**
    Since the backend uses Google Cloud Storage, you first need to create the bucket manually or modify `main.tf` to use a local backend initially. If you have the bucket ready:
    ```bash
    terraform init -backend-config="bucket=YOUR_TF_STATE_BUCKET_NAME"
    ```

5.  **Deploy Infrastructure**
    ```bash
    terraform plan
    terraform apply
    ```
    This deploys a placeholder image "gcr.io/cloudrun/hello" to the service. Next push to main will build and deploy real image.

6.  **Post-Deployment DNS Configuration**
    Once Terraform successfully creates the domain mapping:
    1.  Go to the [Cloud Run Domain Mappings console](https://console.cloud.google.com/run/domains).
    2.  Click **DNS records** for your service.
    3.  Copy all those DNS records (A, AAAA, or CNAME) to your domain registrar's DNS management settings via your domain registrar service.
    4.  Wait for DNS propagation (can take up to 24 hours, but usually faster).
