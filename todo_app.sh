#!/bin/bash

# Unload todo_loader.sh
LOADER_PIDS=(`ps | grep "todo_loader.sh" | sed -E "s/([0-9]+).*/\1/g"`)
ACTIVE_PIDS=(`ps | grep -E "[0-9]+" | sed -E "s/([0-9]+).*/\1/g"`)

for loader_pid in "${LOADER_PIDS[@]}"; do
	for active_pid in "${ACTIVE_PIDS[@]}"; do
		if (( "${loader_pid}" == "${active_pid}" )); then
			echo "Killing pid: ${loader_pid}"
			kill ${loader_pid}
		fi
	done
done

while true; do
	gsleep 10s
	while read line; do
		DUE_DATE=`echo "${line}" | sed -E "s/.*DUE: (.*)/\1/g"`
		# Check if due tomorrow
		DUE=`${TODO_LIST_PATH}/due_tomorrow.sh "${DUE_DATE}"`
		echo "${DUE_DATE} is tomorrow ${DUE}"
	done < ${TODO_LIST_PATH}/todo_list.txt
done

