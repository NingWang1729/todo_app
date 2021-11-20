#!/bin/bash

# Variable declarations:
FROM=${GMAIL}
USER=${GUSER}
PASS=${GPASS}
TO=${GMAIL}
SUBJECT='Subject'
MESSAGE='Message'

# Help menu
print_usage() {
	printf "Usage:\n\t [-f] From\n\t [-u] Username\n\t [-p] Password\n\t [-t] To\n\t [-s] Subject\n\t [-m] Message\n\t [-h] Help\n"
}

while getopts 'f:u:p:t:s:m:vh' flag; do
	case "${flag}" in
		f) FROM="${OPTARG}" ;;
		u) USER="${OPTARG}" ;;
		p) PASS="${OPTARG}" ;;
		t) TO="${OPTARG}" ;;
		s) SUBJECT="${OPTARG}" ;;
		m) MESSAGE="${OPTARG}" ;;
		v) verbose='true' ;;
		h) print_usage
		   exit 1;;
		*) print_usage
		   exit 1 ;;
	esac
done

echo "${FROM}"

sendEmail -f ${FROM} -t ${TO} -u ${SUBJECT} -m ${MESSAGE} -s smtp.googlemail.com:587 -xu ${USER} -xp ${PASS} -o tls=yes
