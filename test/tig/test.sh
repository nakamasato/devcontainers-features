#!/bin/bash

set -e

# Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "tig is installed" tig --version
check "tig is executable" which tig

# Report results
reportResults

