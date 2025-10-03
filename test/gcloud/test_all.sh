#!/bin/bash
set -e
source dev-container-features-test-lib

check "gcloud version" gcloud --version
check "gcloud executable" which gcloud
check "gcloud help" gcloud --help

reportResults
