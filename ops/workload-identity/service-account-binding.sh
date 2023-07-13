#!/bin/bash

# principalSet://iam.googleapis.com/projects/650273226296/locations/global/workloadIdentityPools/github-actions-pool/*

PROJECT_ID="cloudops-388321"
WORKLOAD_ID_POOL="gh-actions-pool"
WORKLOAD_ID_PROVIDER="gh-actions"

gcloud iam service-accounts add-iam-policy-binding "github-actions@cloudops-388321.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/774194386647/locations/global/workloadIdentityPools/${WORKLOAD_ID_POOL}/attribute.repository/david-bour/portfolio"