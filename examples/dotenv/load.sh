#!/bin/bash

. "$BASHPP_LIBS"/Import.sh

import dotenv

echo "BEFORE DOTENV (VAR): $VAR"

load_dotenv

echo "AFTER DOTENV (VAR): $VAR"
