import pkg_resources

import subprocess

import os

import sys

from robot import run
 
 
def check_and_install_robot_libraries():

    # Get all installed packages

    installed_packages = {pkg.key for pkg in pkg_resources.working_set}
 
    # List of Robot Framework-related libraries to check/install

    robot_libraries = [

        'robotframework',

        'robotframework-seleniumlibrary',

        'robotframework-requests',

        'robotframework-appiumlibrary',

        'robotframework-datadriver',

        'robotframework-browser',

        'wxPython',

        'robotframework-ride'

    ]
 
    # Separate installed and missing libraries

    installed_robot_libraries = [lib for lib in robot_libraries if lib.lower() in installed_packages]

    missing_robot_libraries = [lib for lib in robot_libraries if lib.lower() not in installed_packages]
 
    # Display installed libraries

    if installed_robot_libraries:

        print("Installed Robot Framework libraries:")

        for lib in installed_robot_libraries:

            print(f"- {lib}")

    else:

        print("No Robot Framework libraries are installed.")
 
    # Install missing libraries

    if missing_robot_libraries:

        print("\nMissing libraries detected. Initiating installation...")

        for lib in missing_robot_libraries:

            try:

                print(f"Installing {lib}...")

                subprocess.check_call(['pip', 'install', lib])

                print(f"{lib} successfully installed.")

            except subprocess.CalledProcessError as e:

                print(f"Failed to install {lib}: {e}")

    else:

        print("\nAll required libraries are already installed.")
 
 
def add_libraries_to_env_variables():

    # Get installation locations of all installed libraries

    for package in pkg_resources.working_set:

        package_location = package.location

        if package_location not in os.environ['PATH']:

            # Add the library location to PATH for the current session

            os.environ['PATH'] += os.pathsep + package_location

            print(f"Added {package_location} to PATH for the session.")
 
            # Add permanently to system variables (Windows example)

            if sys.platform == "win32":

                subprocess.run(['setx', 'PATH', os.environ['PATH']], shell=True)

                print(f"Added {package_location} to PATH permanently (Windows).")

            else:

                # Add permanently to Unix/Linux environment

                bashrc_path = os.path.expanduser("~/.bashrc")

                with open(bashrc_path, "a") as bashrc:

                    bashrc.write(f'\nexport PATH=$PATH:{package_location}')

                print(f"Added {package_location} to PATH permanently in .bashrc.")
 
 
def execute_robot_script(script_name):

    try:

        print(f"Executing Robot Framework script: {script_name}")

        run(script_name)

    except Exception as e:

        print(f"Error executing script: {e}")
 
 
if __name__ == "__main__":

    # Step 1: Check and install required Robot Framework libraries

    check_and_install_robot_libraries()
 
    # Step 2: Add all installed libraries to system environment variables

    add_libraries_to_env_variables()
 
    # Step 3: Execute a specific Robot Framework script

    script_path = "C:/Users/Soumya/AppData/Roaming/Python/Python313/Scripts/Test.robot"  # Change this to your actual script path

    execute_robot_script(script_path)
 