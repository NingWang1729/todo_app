#!/bin/bash

# Variable declarations:
FROM=${GMAIL}
USER=${GUSER}
PASS=${GPASS}
TO=${GMAIL}
SUBJECT='Subject'
MESSAGE='Message'
MESSAGE_FILE=''
TEXT=false
FILE=false

# Help menu
print_usage() {
	printf "Usage:\n\t[-f] From: Your name or identifier\n\t[-u] Username: Override default username\n\t[-p] Password: Override default password\n\t[-t] To: Recipient of email\n\t[-s] Subject: Subject line of email\n\t[-m] Attach message from text input (mutually exclusive with[-o])\n\t[-o] Attach message from file input (mutually exclusive with[-m])\n\t[-h] Help\n"
}

# Parse command line arguments
while getopts 'f:u:p:t:s:m:o:vh' flag; do
	case "${flag}" in
		f) FROM="${OPTARG}" ;;
		u) USER="${OPTARG}" ;;
		p) PASS="${OPTARG}" ;;
		t) TO="${OPTARG}" ;;
		s) SUBJECT="${OPTARG}" ;;
		m) MESSAGE="${OPTARG}"
		   TEXT=true ;;
		o) MESSAGE_FILE="${OPTARG}"
		   FILE=true ;;
		v) verbose='true' ;;
		h) print_usage
		   exit 1;;
		*) print_usage
		   exit 1 ;;
	esac
done

# Verify mutually exclusive options
if [[ "${FILE}" == true && "${TEXT}" == true ]]; then
	echo "Error: Cannot send both message and file."
	exit 1;
fi

# Toggle between messaging text and messaging from file
if ${FILE}; then
	sendEmail -f ${FROM} -t ${TO} -u ${SUBJECT} -s smtp.googlemail.com:587 -xu ${USER} -xp ${PASS} -o tls=yes message-file=${MESSAGE_FILE}
else
	sendEmail -f ${FROM} -t ${TO} -u ${SUBJECT} -m ${MESSAGE} -s smtp.googlemail.com:587 -xu ${USER} -xp ${PASS} -o tls=yes
fi

