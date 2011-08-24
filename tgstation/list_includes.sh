#!/bin/bash
set -euo pipefail

sed 's#\\#/#g' tgstation.dme | grep '^#include' | sed -r 's/^.*"(.*)".*$/\1/' | sed 's/ /\\ /g'

