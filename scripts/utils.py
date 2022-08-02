import subprocess

def exec(command, quiet=False, cwd="."):
    process = subprocess.Popen(command.split(" "), stdout = subprocess.PIPE, stderr = subprocess.PIPE, cwd=cwd)
    output = process.communicate()[0]
    global returnCode
    returnCode = process.returncode
    error = process.communicate()[1]
    process.wait()

    if error and not quiet:
        print(error, flush=True)

    return output.decode('utf_8')