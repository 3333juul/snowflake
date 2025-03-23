#!/usr/bin/env python3
import requests
import json
from datetime import datetime

TODOIST_API_TOKEN = ""

PRIORITY_COLORS = {
    4: "#D1453B",  # P4
    3: "#EB8909",  # P3
    2: "#246FE0"   # P2
}

def get_project_name(project_id, projects):
    for project in projects:
        if project['id'] == project_id:
            return project['name']
    return None

def get_tasks():
    response = requests.get(
        "https://api.todoist.com/rest/v2/tasks?filter=(overdue|today)",
        headers={"Authorization": f"Bearer {TODOIST_API_TOKEN}"}
    )
    tasks = response.json()
    return tasks

def get_projects():
    response = requests.get(
        "https://api.todoist.com/rest/v2/projects",
        headers={"Authorization": f"Bearer {TODOIST_API_TOKEN}"}
    )
    projects = response.json()
    return projects

def is_overdue(due_date_string):
    date_formats = ["%d %b %H:%M", "%d %b"]
    for fmt in date_formats:
        try:
            due_date = datetime.strptime(due_date_string, fmt)
            return due_date < datetime.now()
        except ValueError:
            continue
    return False

def main():
    tasks = get_tasks()
    projects = get_projects()

    data = {'text': f'{len(tasks)}', 'tooltip': ''}

    for task in tasks:
        project_name = get_project_name(task['project_id'], projects)
        priority_color = PRIORITY_COLORS.get(task['priority'], "#ebdbb2")  
        due_date_emoji = " | OVERDUE 🔥" if is_overdue(task['due']['string']) else ""
        data['tooltip'] += f"<b><span color='{priority_color}'>{task['content']}</span></b>\n"
        data['tooltip'] += f"Project: {project_name}\n"
        data['tooltip'] += f"Due date: {task['due']['string']}{due_date_emoji}\n"
        #data['tooltip'] += f"Priority: {task['priority']}\n"
        data['tooltip'] += f"Labels: {task['labels']}\n\n"

    print(json.dumps(data))

if __name__ == "__main__":
    main()


