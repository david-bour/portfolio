#!/bin/bash

# principalSet://iam.googleapis.com/projects/650273226296/locations/global/workloadIdentityPools/github-actions-pool/*

PROJECT_ID="cloudresume-380001"
WORKLOAD_ID_POOL="gh-actions-pool"
WORKLOAD_ID_PROVIDER="gh-actions"

gcloud iam service-accounts add-iam-policy-binding "github-actions@cloudresume-380001.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/650273226296/locations/global/workloadIdentityPools/${WORKLOAD_ID_POOL}/attribute.repository/david-bour/portfolio"