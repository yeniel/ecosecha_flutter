from utils import *

def main():
    print("\nGetting flutter packages...")

    output = exec("flutter pub get")
    print(output, flush=True)
    output = exec("flutter pub get domain")
    print(output, flush=True)
    output = exec("flutter pub get data")
    print(output, flush=True)

if __name__ == "__main__":
    main()
