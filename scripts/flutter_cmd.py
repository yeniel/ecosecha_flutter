from utils import *
import argparse
import pub_get

parser = argparse.ArgumentParser()

parser.add_argument("-build_runner", nargs='?', const="y", help="Execute command flutter pub run build_runner build --delete-conflicting-outputs")
parser.add_argument("-icons", nargs='?', const="y", help="Execute command flutter pub run flutter_launcher_icons:main")
parser.add_argument("-clean", nargs='?', const="y", help="Execute command flutter clean")
parser.add_argument("-pubget", nargs='?', const="y", help="Execute flutter pub get in all packages (data, domain, main)")

args = parser.parse_args()

if args.build_runner == "y":
	print("Running build_runner...")
	output = exec("flutter pub run build_runner build --delete-conflicting-outputs")
	print(output, flush=True)

if args.icons == "y":
	print("Generating launcher icons...")
	output = exec("flutter pub run flutter_launcher_icons:main")
	print(output, flush=True)

if args.clean == "y":
	print("\nFlutter clean...")
	output = exec("flutter clean")
	print(output, flush=True)

	print("\nUninstalling app from ios simulators...\n")

	exec("xcrun simctl terminate booted com.yeniellandestoy.ecosecha.ecosechaFlutter")
	exec("xcrun simctl uninstall booted com.yeniellandestoy.ecosecha.ecosechaFlutter")

	pub_get.main()

if args.pubget == "y":
	pub_get.main()