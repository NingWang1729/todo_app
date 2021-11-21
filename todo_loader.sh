#!/bin/bash

TODO_COUNT=`ps | grep "todo_app.sh" | wc -l`

if (( ${TODO_COUNT} > 1 )); then
    echo "TODO App is active…"
else
    echo "Loading TODO App…"
    ${TODO_LIST_PATH}/todo_app.sh
fi
