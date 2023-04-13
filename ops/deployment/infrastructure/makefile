PROJECT_ID="cloudresume-380001"
WORKLOAD_ID_POOL="gh-actions-pool"
WORKLOAD_ID_PROVIDER="gh-actions"

# This creates the bucket we use to store Terraform
# state. Only needs to be ran on initial project setup
init:
	gcloud storage buckets create --project ${PROJECT_ID} \
						   		  --uniform-bucket-level-access \
								  gs://cloud-resume-tf-state

# Create Workload Identity Provider & Pool
workload-id:
	gcloud iam workload-identity-pools create "${WORKLOAD_ID_POOL}" \
		--project="${PROJECT_ID}" \
		--location="global" \
		--display-name="GitHub Actions Pool" && \
	gcloud iam workload-identity-pools providers create-oidc "${WORKLOAD_ID_PROVIDER}" \
		--project="${PROJECT_ID}" \
		--location="global" \
		--workload-identity-pool="${WORKLOAD_ID_POOL}" \
		--display-name="GitHub Actions Provider" \
		--attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.aud=assertion.aud,attribute.repository=assertion.repository" \
		--issuer-uri="https://token.actions.githubusercontent.com"


# github-actions@cloudresume-380001.iam.gserviceaccount.com
gha-service-account:
	gcloud iam service-accounts create github-actions \
		--project ${PROJECT_ID} \
		--description="GitHub Actions" \
		--display-name="GitHub Actions" && \
	gcloud projects add-iam-policy-binding ${PROJECT_ID} \
		--member="serviceAccount:github-actions@${PROJECT_ID}.iam.gserviceaccount.com" \
		--role="roles/storage.objectAdmin"

# Creates a powerful service account to manage our infrastructure
# Sets the workload identity for the service account so it can
# be used with GitHub actions
tf-service-account:
	gcloud iam service-accounts create tf-provider \
		--project ${PROJECT_ID} \
		--description="Terraform" \
		--display-name="Terraform" && \
	gcloud projects add-iam-policy-binding ${PROJECT_ID} \
		--member="serviceAccount:tf-provider@${PROJECT_ID}.iam.gserviceaccount.com" \
		--role="roles/editor" && \
	gcloud iam service-accounts add-iam-policy-binding tf-provider@${PROJECT_ID}.iam.gserviceaccount.com \
		--project="${PROJECT_ID}" \
		--role="roles/iam.workloadIdentityUser" \
		--member="principalSet://iam.googleapis.com/projects/650273226296/locations/global/workloadIdentityPools/gh-actions-pool/attribute.repository/david-bour/portfolio"

