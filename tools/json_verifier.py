import sys
import json

if len(sys.argv) <= 1:
    exit(1)

status = 0

for file in sys.argv[1:]:
    with open(file, encoding="ISO-8859-1") as f:
        try:
            json.load(f)
        except ValueError as exception:
            print("JSON error in {}".format(file))
            print(exception)
            status = 1

if status == 0:
    print("All JSON files are valid JSON")

exit(status)
