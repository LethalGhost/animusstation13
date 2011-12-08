#!/bin/bash
set -euo pipefail

find icons sound music -name *.dmi -or -name *.png -or -name *.html -or -name *.ogg -or -name *.wav | sed 's/ /\\ /g'

