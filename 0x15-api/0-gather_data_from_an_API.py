#!/usr/bin/python3
"""
This script returns information about an employee's TODO list progress,
for a given employee ID.
"""
import requests
import sys


def get_employee_data(employee_id):
    """
    Fetches the employee data and their TODO list from the API.

    Args:
        employee_id (int): The ID of the employee.

    Returns:
        tuple: A tuple containing two elements:
            - dict: The employee's data containing keys like 'id', 'name',
                    'username', etc.
            -list: A list of dictionaries, each representing a TODO task
                    for the employee. Each dictionary contains keys like
                    'userID', 'id', 'title', 'completed'.

    Raises:
        requests.exceptions.RequestExceptions: If there is an issue with
        the HTTP requests.
    """
    # Base URL for the API
    base_url = "https://jsonplaceholder.typicode.com/"

    # Fetch user data
    user_response = requests.get(f"{base_url}users/{employee_id}")
    if user_response.status_code != 200:
        print("Error fetching user data")
        return None
    user_data = user_response.json()

    # Fetch TODO list data
    todos_response = requests.get(f"{base_url}todos?userId={employee_id}")
    if todos_response.status_code != 200:
        print("Error fetching TODO list")
        return None
    todos_data = todos_response.json()

    return user_data, todos_data


def display_todo_progress(employee_id):
    """
    Displays the TODO list progress of a given employee.

    This function fetches the employee's data and TODO list using the
    `get_employee_data` function, calculates the number of completed
    and total tasks, and prints the employee's TODO list progress in a
    specific format.

    Args:
        employee_id (int): The ID of the employee.

    Returns:
        None

    Prints:
        The employee's name, number of completed tasks, total number of tasks,
        and the titles of the completed tasks to the standard output in the
        following format:

        Employee EMPLOYEE_NAME is done with tasks
        (NUMBER_OF_DONE_TASKS/TOTAL_NUMBER_OF_TASKS):
             TASK_TITLE_1
             TASK_TITLE_2
             ...
    """
    # Get the employee data
    data = get_employee_data(employee_id)
    if data is None:
        return

    user_data, todos_data = data

    # Employee name
    employee_name = user_data.get('name')

    # Calculate the number of completed and total tasks
    total_tasks = len(todos_data)
    done_tasks = sum(1 for task in todos_data if task.get('completed'))

    # Print the employee TODO list progress
    print(f"Employee {employee_name} is done\
          with tasks({done_tasks}/{total_tasks}):")

    # Print the titles of completed tasks
    for task in todos_data:
        if task.get('completed'):
            print(f"\t {task.get('title')}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 0-gather_data_from_an_API.py\
              <employee_id>")
        sys.exit(1)

    try:
        employee_id = int(sys.argv[1])
    except ValueError:
        print("Employee ID must be an integer")
        sys.exit(1)

    display_todo_progress(employee_id)
