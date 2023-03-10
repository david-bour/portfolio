#!/bin/bash

# Creates a permanent IP address for our
# load balancer

gcloud compute addresses create resume \
	--network-tier=PREMIUM \
	--ip-version=IPV4 \
	--global \
	--project=cloudresume-380001
