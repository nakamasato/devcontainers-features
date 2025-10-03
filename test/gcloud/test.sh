#!/bin/bash

set -e

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "gcloud is installed" gcloud --version
check "gcloud is executable" which gcloud

# Report results
reportResults
