# This creates the bucket we use to store Terraform
# state. Only needs to be ran on initial project setup
init:
	gcloud storage buckets create --project cloudresume-380001 \
						   		  --uniform-bucket-level-access \
								  gs://cloud-resume-tf-state

# Creates a powerful service account to manage our infrastructure
tf-service-account:
	gcloud iam service-accounts create tf-provider \
		--project cloudresume-380001 \
		--description="Terraform" \
		--display-name="Terraform" && \
	gcloud projects add-iam-policy-binding cloudresume-380001 \
		--member="serviceAccount:tf-provider@cloudresume-380001.iam.gserviceaccount.com" \
		--role="roles/editor"

tf-workload-id-binding:
	gcloud iam service-accounts add-iam-policy-binding tf-provider@cloudresume-380001.iam.gserviceaccount.com \
		--project="cloudresume-380001" \
		--role="roles/iam.workloadIdentityUser" \
		--member="principalSet://iam.googleapis.com/projects/650273226296/locations/global/workloadIdentityPools/gh-actions-pool/attribute.repository/david-bour/portfolio"
