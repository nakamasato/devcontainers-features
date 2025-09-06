#!/bin/bash
set -e
source dev-container-features-test-lib

check "tig version" tig --version
check "tig executable" which tig
check "tig help" tig --help

reportResults
