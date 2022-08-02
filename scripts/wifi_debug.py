from utils import *
import argparse
import pub_get

parser = argparse.ArgumentParser()

parser.add_argument("-ip", nargs='?', const="192.168.1.34", default="192.168.1.34", required=False, help="Ip of the device")

args = parser.parse_args()

output = exec("adb tcpip 5555")
print(output, flush=True)

output = exec(f"adb connect {args.ip}:5555")
print(output, flush=True)

output = exec("adb devices")
print(output, flush=True)