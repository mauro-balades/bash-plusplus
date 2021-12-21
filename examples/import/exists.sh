#!/bin/bash
. "$BASHPP_LIBS"/Import.sh

# NOTE: nexists is just the same but with
#       an inversed return value

import.exists module
EXISTS=$?
echo "BEFORE EXISTS: $EXISTS"

import module

import.exists module
EXISTS=$?
echo "AFTER EXISTS: $EXISTS"
hello