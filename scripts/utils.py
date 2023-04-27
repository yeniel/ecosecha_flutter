import subprocess
import shlex

def exec(command, quiet=False, cwd="."):
    process = subprocess.Popen(shlex.split(command), stdout = subprocess.PIPE, stderr = subprocess.PIPE, cwd=cwd)
    stdout, stderr = process.communicate()

    global returnCode

    returnCode = process.returncode

    if returnCode == 0:
        return stdout.decode('utf_8')
    else:
        print(f"Command failed with return code {returnCode} and output:\n{stderr.decode('utf-8')}")