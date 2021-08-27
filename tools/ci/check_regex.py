'''
Usage:
    $ python check_regex.py

check_regex.py - Run regex expression tests on all DM code inside current
    directory

    To add, modify, or remove test cases/expressions, edit this script.
    See the "cases" variable and the use of exact(int, string, string).

Copyright 2021 Martin Lyrå

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
'''

# Standard Python
from io import FileIO       # For strong typing
import os                   # For file and directory operations
import re as regex          # For regex
import time                 # For very basic performance profiling
# Also for strong typing
from typing import Dict, List, Tuple

# Third party
import git                  # For fetching git data & diffs
import unidiff              # For parsing of unified diff data
import yaml                 # For configuration
import colorama             # For logging styling
from colorama import Fore, Back, Style

# Defaults
config_file_default_name = "check_regex.yaml"
annotation_file_output_name = "check_regex_output.txt"

preferred_encoding = "utf-8"

# Data struct for holding info about standardization rules
class TestExpression:
    def __init__(
        self,
        expected: int,
        message: str,
        pattern: str,
        method: str
    ):
        self.expected = expected
        self.message = message
        self.pattern = regex.compile(pattern)
        self.method = method

    def __repr__(self) -> str:
        return self.__str__()

    def __str__(self) -> str:
        return ("TestExpression[%s -> %d, %s, %s]" % (
            self.method,
            self.expected,
            self.message,
            self.pattern
        ))

#
# Test methods & result defines
#
RESULT_FAIL = 2
RESULT_WARNING = 1
RESULT_OK = 0

def exactly_cmp(target, result):
    if result == target:
        return RESULT_OK
    return RESULT_FAIL

def no_more_cmp(target, result):
    if result <= target:
        if result == target:
            return RESULT_OK
        return RESULT_WARNING
    return RESULT_FAIL

# Used to bind a config string to the corresponding function
target_method_binding = {
    "exactly": exactly_cmp,
    "no_more": no_more_cmp
}

#
# Configuration
#

# Configuration loading
def load_yaml_config(config_file: str) -> Dict:
    if not os.path.exists(config_file):
        print(f"Could not find {config_file}")
        return None
    if not os.path.isfile(config_file):
        print(f"Could not open {config_file}: is not a file")
        return None

    yaml_entries = {}
    try:
        with open(config_file, 'rt', encoding="utf-8") as f:
            all_entries = yaml.load(f, Loader=yaml.SafeLoader)
            yaml_entries = all_entries
    except Exception as e:
        print(f"Could not read config {config_file}: {e}")
        return None

    return yaml_entries

# Configuration parsing
def parse_yaml_config(yaml_data: Dict) -> Tuple[List]:
    def get_tuple(entry):
        return list(entry.items())[0]

    def parse_standards():
        def parse_short(entry):
            (method, args) = get_tuple(entry)
            (num, message, pattern) = args
            return TestExpression(
                num, message, pattern, method
            )

        def parse_verbose(entry):
            (target, message, pattern) = (
                entry["target"],
                entry["message"],
                entry["pattern"]
            )
            (method, number) = get_tuple(target)
            if method in target_method_binding:
                return TestExpression(
                    number,
                    message,
                    pattern,
                    method
                )
            return None

        configured_standards = list()
        standards_config = yaml_data["standards"]
        for standard in standards_config:
            arg_count = len(standard.items())
            if arg_count == 1:
                try:
                    configured_standards.append(parse_short(standard))
                except Exception as e:
                    print(f"The yaml object {standard} is not a valid short config: {e}")
            else:
                try:
                    s = parse_verbose(standard)
                    if s is not None:
                        configured_standards.append(s)
                except Exception as e:
                    print(f"The yaml object {standard} is not a valid config: {e}")
        return configured_standards

    return (
        parse_standards()
    )

#
# Analysis
#

# Collection of data/code files to work on
def construct_filename_regex(extensions):
    return regex.compile(rf'\.({str.join("|", extensions)})$')

def collect_candidate_files(directory, extensions):
    if not isinstance(extensions, list):
        extensions = [extensions]
    expression = construct_filename_regex(extensions)

    def is_a_match(file):
        return regex.search(expression, file) is not None

    candidates = dict()
    for path, subdirectories, files in os.walk(directory):
        for file in files:
            if is_a_match(file):
                full_path = os.path.join(path, file)
                full_path = os.path.normpath(full_path)
                candidates[len(candidates) + 1] = full_path
    return candidates

# Analysis functions

# A constant for the function below, so it won't be compiled
# every time the function is called
line_comment_regex_expression = regex.compile(r'^\s*\/\/')

def test_content_lines(results, expressions, lines, ignore_comments=False):
    def is_a_line_comment(line):
        return line_comment_regex_expression.match(line)

    matched = [None] * len(expressions)
    for i in range(0, len(expressions)):
        matched[i] = []

    line_number = 0
    is_comment_block = False
    for line in lines:
        line_number += 1
        if ignore_comments:
            if str.find(line, '/*') >= 0:
                is_comment_block = True
            if str.find(line, '*/') >= 0:
                is_comment_block = False
            if is_comment_block or is_a_line_comment(line):
                continue

        for it in range(0, len(expressions)):
            expression = expressions[it]
            matches = regex.findall(expression, line)
            if len(matches) > 0:
                matched[it].append(line_number)
                key = file
                count = len(matches)
                if key not in results[it]:
                    results[it][key] = count
                else:
                    results[it][key] += count
                results[it]["SUM"] += count
    return matched

def test_file(results, expressions, file, ignore_comments=False):
    contents = []
    with open(file, 'rt', encoding=preferred_encoding) as f:
        contents = f.readlines()
    return test_content_lines(results, expressions, contents, ignore_comments)

#
# Logging & Output formatting
#

# For writing to both stdout and file at once
output_file: FileIO = None

def output_write(message, colour=None, to_stdout=True, to_file=True):
    if to_stdout:
        if colour is not None:
            print(f"{colour}{message}{Fore.RESET}")
        else:
            print(message)
    if to_file and output_file is not None:
        output_file.write(message + "\n")

def create_title(title, char='='):
    MAX_WIDTH = 100
    if len(title):
        right = MAX_WIDTH - (7 + len(title))
        return f"\n{char*5} {title} {char*right}"
    return char*MAX_WIDTH

def try_normalize_path(filepath):
    return os.path.normpath(filepath)

#
# Entry point & main behaviour
#
if __name__ == "__main__":
    colorama.init()


    output_file = open(
        annotation_file_output_name,
        mode='wt',
        encoding=preferred_encoding
    )

    output_write(create_title("Configuration"))
    output_write("- Trying to load config: %s" % (
        try_normalize_path(config_file_default_name)
    ))

    raw_config = load_yaml_config(config_file_default_name)
    (standards) = parse_yaml_config(raw_config)

    output_write("- Succesfully loaded config: %s" % (
        try_normalize_path(config_file_default_name)
    ))
    output_write("- Loaded %d standardization rules" % (
        len(standards)
    ))

    output_write(create_title(
        "Processing", '-'
    ))

    start_time = time.time()

    # Get diffs
    repo = git.Repo("./")
    assert not repo.bare
    assert repo.remotes.origin.exists()
    assert len(repo.remotes.origin.url)

    g = git.cmd.Git("./")
    origin_info = g.execute("git remote show origin")
    head_pattern = regex.compile(r'[ ]*HEAD branch: ([\w\S]+)')
    head_branch = head_pattern.findall(origin_info)[0]
    active_branch = repo.active_branch

    output_write(" - Found git remote default: %s" % (head_branch))
    output_write(" - Found git local active:   %s" % (active_branch))
    # Get what files have been changed, instead of getting all diffs at once
    changed_files = g.diff(
        "%s...%s" % (head_branch, active_branch),
        "--name-only"
        ).split("\n")

    changed_files = list(filter(
        lambda item: item.endswith(".dm"),
        changed_files
    ))

    output_write(" - %d *.dm files with diffs found" % (len(changed_files)))

    for changed in changed_files:
        raw_diff = g.diff(
            "%s...%s" % (head_branch, active_branch),
            changed
            )

        diff_data = unidiff.PatchSet.from_string(raw_diff, encoding=preferred_encoding)

        print(diff_data)

    exit(0)

    # Get files
    files_to_test = collect_candidate_files('./', 'dm')

    output_write(f" - Found {len(files_to_test)} '*.dm' files")

    results = list()
    expressions = list()
    matched_lines_by_expression = list()
    for ii in range(0, len(standards)):
        s = standards[ii]
        results.append({
            "SUM": 0
        })
        expressions.append(s.pattern)
        matched_lines_by_expression.append(dict())

    for it in files_to_test:
        file = files_to_test[it]
        matched = test_file(results, expressions, file)
        for j in range(0, len(expressions)):
            matched_lines = matched[j]
            if len(matched_lines) > 0:
                matched_lines_by_expression[j][file] = matched_lines

    # This is the end, go process the data then show the results!
    output_write(create_title("Regex Results"))
    output_write("\n%-12s | %-6s | %s"
        % (
            "Result",
            "Target",
            "Description"
        ),
    )
    output_write(f"{'-'*13}+{'-'*8}+{'-'*(77)}")

    failure = 0
    warning = 0
    for jj in range(0, len(results)):
        standard = standards[jj]
        count = results[jj]["SUM"]

        prefix = "OK"
        colour = Fore.GREEN
        matching = target_method_binding[standard.method](
            standard.expected,
            count
        )
        if matching == RESULT_FAIL:
            failure += 1
            prefix = ">>>>"
            colour = Fore.RED
        elif matching == RESULT_WARNING:
            warning += 1
            prefix = "!!!!"
            colour = Fore.YELLOW

        output_write(
            f"\n{'-'*13}+{'-'*8}+{'-'*(77)}",
            to_stdout= False
        )
        output_write("%4s:%7i |%7i | %s"
            % (
                prefix,
                count,
                standard.expected,
                standard.message
            ),
            colour=colour
        )

        # Annotation info
        if not output_file.writable():
            continue
        lines_by_file = list(matched_lines_by_expression[jj].items())
        files_count = len(lines_by_file)
        output_write(
            f"{'-'*13}+{'-'*8}+{'-'*(77)}",
            to_stdout= False
        )
        for kk in range(0, len(lines_by_file)):
            file, matches = lines_by_file[kk]
            branch = "\u251C" if kk < len(lines_by_file) - 1 else "\u2514"
            output_write(
                "%13s %-72s: %s" % (
                    "%4s:%7i%2s" % (
                        prefix,
                        len(matches),
                        branch
                    ),
                    file,
                    matches
                ),
                to_stdout= False
            )
        if not len(lines_by_file):
            output_write(
                "%14s %s" % (
                    "\u2514",
                    "None found"
                ),
                to_stdout= False
            )

    output_write("\n"
        + (
            "There are mismatches present, please address those"
            if failure else
            "There are possible improvements, a review of code or configured values is recommended"
            if warning else
            "All OK!"
        ),
        colour=
            Fore.RED if failure else
            Fore.YELLOW if warning else
            Fore.GREEN,
        to_file= False
    )
    output_write("\nThis script completed in %7.3f seconds"
        % (time.time() - start_time)
    )
    output_write("\nFull match and annotation written to: %s"
        % (
            try_normalize_path(
                str.join("/", [os.getcwd(), annotation_file_output_name])
        )),
        to_file=False
    )
    output_write(
        create_title(''),
        to_file= False
    )

    output_file.close()
    output_file = None

    exit(failure > 0)
