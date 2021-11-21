#!/bin/bash

# Compute dates
TODAY=`gdate +%s`
DUE_DATE=`gdate --date="${1}" +%s`

# Compare deadline
if (( ${TODAY} < ${DUE_DATE} && ${TODAY} + 86400 > ${DUE_DATE} )); then
	echo "true"
else
	echo "false"
fi

