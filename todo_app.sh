#!/bin/bash

# Unload todo_loader.sh
LOADER_PIDS=(`ps | grep "todo_loader.sh" | sed -E "s/([0-9]+).*/\1/g"`)
ACTIVE_PIDS=(`ps | grep -E "[0-9]+" | sed -E "s/([0-9]+).*/\1/g"`)

for loader_pid in "${LOADER_PIDS[@]}"; do
	for active_pid in "${ACTIVE_PIDS[@]}"; do
		if [[ "${loader_pid}" == "${active_pid}" ]]; then
			echo "Killing pid: ${loader_pid}"
			kill ${loader_pid}
		fi
	done
done

while true; do
	gsleep 15m
	gdate
	while read line; do
		DUE_DATE=`echo "${line}" | sed -E "s/.*DUE: (.*)/\1/g"`
		# Check if due tomorrow
		DUE=`${TODO_LIST_PATH}/due_tomorrow.sh "${DUE_DATE}"`
		echo "${DUE_DATE} is tomorrow ${DUE}"
		
		SENT=false
		if [[ "${DUE}" == "true" ]]; then
			echo "Should send a message"
			while read sent_item; do
				if [[ "${line}" == "${sent_item}" ]]; then
					echo "Message already sent."
					SENT=true
				fi
			done < ${TODO_LIST_PATH}/sent_list.txt
			if [[ "${SENT}" == "false" ]]; then
				${TODO_LIST_PATH}/gmail.sh -s "Upcoming task due ${DUE_DATE}" -m "${line}"
				echo "${line}" >> ${TODO_LIST_PATH}/sent_list.txt
			fi
		else
			echo "Should send no message"
		fi
	done < ${TODO_LIST_PATH}/todo_list.txt
done

