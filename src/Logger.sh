#!/bin/bash

# Define colors
Logger.bold=$(tput bold)
Logger.underline=$(tput sgr 0 1)
Logger.reset=$(tput sgr0)

Logger.purple=$(tput setaf 171)
Logger.red=$(tput setaf 1)
Logger.green=$(tput setaf 76)
Logger.tan=$(tput setaf 3)
Logger.blue=$(tput setaf 38)

Logger.reset="\033[m"
