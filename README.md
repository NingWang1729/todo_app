TODO App:

This TODO App is a MacOS command line application that serves as a TODO app. This app allows the user to add and remove tasks, as well as be reminded about upcoming deadlines via email notification. By default, this application sends a reminder approximately 24hrs before any deadline, or earlier, if the assignment was added within 24 hours of the due date.

---

todo_list.txt: List of tasks to do.

Format: One task per line following the following format

${TASK_DESCRIPTION} DUE: ${GNU_TIME_AND_DATE_FORMAT}

---

sent_list.txt: List of tasks TODO App already sent reminders for.

---

init.sh: Initializes initial configurations.

---

todo_loader.sh: Loads the TODO app upon startup.

---

todo_app.sh: TODO app that runs in the background

---

gmail.sh: A basic script to send out emails.

Usage:
	[-f] From: Your name or identifier
	[-u] Username: Override default username
	[-p] Password: Override default password
	[-t] To: Recipient of email
	[-s] Subject: Subject line of email
	[-m] Attach message from text input (mutually exclusive with [-o])
	[-o] Attach message from file input (mutually exclusive with [-m])
	[-h] Help

