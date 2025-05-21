{
  pkgs,
  osConfig,
  ...
}: let
  todoist-waybar =
    pkgs.writers.writePython3Bin "todoist-waybar" {
      libraries = [pkgs.python3Packages.requests];
      doCheck = false;
    } ''
      #!/usr/bin/env python3
      import os
      import requests
      import json
      from datetime import datetime

      with open("${osConfig.age.secrets.todoist.path}") as f:
        TODOIST_API_TOKEN = f.read().strip()

      PRIORITY_COLORS = {
          4: "#D1453B",  # P4
          3: "#EB8909",  # P3
          2: "#246FE0"   # P2
      }

      def get_project_name(project_id, projects):
          return next((p['name'] for p in projects if p['id'] == project_id), None)

      def api_request(url):
          response = requests.get(
              url,
              headers={"Authorization": f"Bearer {TODOIST_API_TOKEN}"}
          )
          response.raise_for_status()
          return response.json()

      def get_tasks():
          return api_request("https://api.todoist.com/rest/v2/tasks?filter=(overdue|today)")

      def get_projects():
          return api_request("https://api.todoist.com/rest/v2/projects")

      def is_overdue(due_string):
          for fmt in ["%d %b %H:%M", "%d %b"]:
              try:
                  return datetime.strptime(due_string, fmt) < datetime.now()
              except ValueError:
                  continue
          return False

      def generate_tooltip(task, projects):
          project_name = get_project_name(task['project_id'], projects)
          priority_color = PRIORITY_COLORS.get(task['priority'], "#ebdbb2")
          due_emoji = " | OVERDUE 🔥" if is_overdue(task['due']['string']) else ""
          return (
              f"Name: <b><span color='{priority_color}'>{task['content']}</span></b>\n"
              f"Project: {project_name}\n"
              f"Due: {task['due']['string']}{due_emoji}\n"
              f"Labels: {task['labels']}\n\n"
          )

      def main():
          tasks = get_tasks()
          projects = get_projects()

          print(json.dumps({
              "text": str(len(tasks)),
              "tooltip": "".join(generate_tooltip(t, projects) for t in tasks)
          }))

      if __name__ == "__main__":
          main()
    '';
in {
  home.packages = [todoist-waybar];
}
