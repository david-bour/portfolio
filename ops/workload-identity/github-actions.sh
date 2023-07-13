#!/bin/bash

# ##########################################
# This script will set up our GCP workload
# identity to GitHub action runners
# ##########################################

PROJECT_ID="cloudops-388321"
WORKLOAD_ID_POOL="gh-actions-pool"
WORKLOAD_ID_PROVIDER="gh-actions"

gcloud iam workload-identity-pools create "${WORKLOAD_ID_POOL}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="GitHub Actions Pool"

gcloud iam workload-identity-pools providers create-oidc "${WORKLOAD_ID_PROVIDER}" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="${WORKLOAD_ID_POOL}" \
  --display-name="GitHub Actions Provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.aud=assertion.aud,attribute.repository=assertion.repository" \
  --issuer-uri="https://token.actions.githubusercontent.com"
