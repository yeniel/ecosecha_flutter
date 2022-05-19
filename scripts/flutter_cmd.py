from utils import *
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-build_runner", nargs='?', const="y", help="Execute command flutter pub run build_runner build")
parser.add_argument("-icons", nargs='?', const="y", help="Execute command flutter pub run flutter_launcher_icons:main")
args = parser.parse_args()

if args.build_runner == "y":
	print("Running build_runner...")
	output = exec("flutter pub run build_runner build")
	print(output, flush=True)

if args.icons == "y":
	print("Generating launcher icons...")
	output = exec("flutter pub run flutter_launcher_icons:main")
	print(output, flush=True)