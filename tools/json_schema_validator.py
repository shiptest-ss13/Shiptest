import sys
import json
import jsonschema

if len(sys.argv) <= 2:
    exit(1)

status = 0

with open(sys.argv[1], encoding="ISO-8859-1") as schema_file:
    validator = jsonschema.Draft4Validator(json.load(schema_file))

for file in sys.argv[2:]:
    with open(file, encoding="ISO-8859-1") as f:
        try:
            json_data = json.load(f)
            for error in sorted(validator.iter_errors(json_data), key=str):
                print("\nJSON Schema error in {}".format(file))
                print(error)
                status = 1
        except ValueError as exception:
            print("JSON error in {}".format(file))
            print(exception)
            status = 1

exit(status)
