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
from io import FileIO
import sys
import os
import re as regex
import time

# Third party
import colorama
from colorama import Fore, Back, Style

annotation_file_output_name = "check_regex_output.txt"

class TestExpression:
    def __init__(self, expected, message, pattern) -> None:
        self.expected = expected
        self.message = message
        self.pattern = pattern

def exactly(num, message, pattern) -> TestExpression:
    return TestExpression(num, message, pattern)

# These were lifted from the old check_paths.sh script
# With the original comment:
#
# With the potential exception of << if you increase any
# of these numbers you're probably doing it wrong
cases = [
    exactly(8, "escapes", r'\\\\(red|blue|green|black|b|i[^mc])'),
    exactly(9, "Del()s", r'\WDel\('),

    exactly(0, "/atom text paths", r'"/atom'),
    exactly(1, "/area text paths", r'"/area'),
    exactly(16, "/datum text paths", r'"/datum'),
    exactly(4, "/mob text paths", r'"/mob'),
    exactly(49, "/obj text paths", r'"/obj'),
    exactly(0, "/turf text paths", r'"/turf'),
    exactly(126, "text2path uses", r'text2path'),

    exactly(22, "world << uses", r'world[ \t]*<<'),
    exactly(0, "world.log << uses", r'world.log[ \t]*<<'),

    exactly(946, "<< uses", r'(?<!<)<<(?!<)'),
    exactly(0, "incorrect indentations", r'^(?:  +)(?!\*)'),
    exactly(0, "superflous whitespace", r'[ \t]+$'),
    exactly(36, "mixed indentation", r'^( +\t+|\t+ +)'),

    exactly(2243, "indentions inside #defines", r'^(\s*)#define (\w*)( {2,}| ?\t+)(?!(\/\/|\/\*))')
]
# With the potential exception of << if you increase any
# of these numbers you're probably doing it wrong

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

# A constant for the function below, so it won't be compiled
# every time the function is called
line_comment_regex_expression = regex.compile(r'^\s*\/\/')

def test_file(results, expressions, file, ignore_comments=False):
    def is_a_line_comment(line):
        return line_comment_regex_expression.match(line)

    matched = [None] * len(expressions)
    for i in range(0, len(expressions)):
        matched[i] = []

    line_number = 0
    is_comment_block = False
    for line in open(file, 'r', encoding='latin-1'):
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

if __name__ == "__main__":
    colorama.init()

    start_time = time.time()
    files_to_test = collect_candidate_files('./', 'dm')

    results = list()
    expressions = list()
    matched_lines_by_expression = list()
    for it in range(0, len(cases)):
        case = cases[it]
        results.append({
            "SUM": 0
        })
        expressions.append(regex.compile(case.pattern))
        matched_lines_by_expression.append(dict())

    for it in files_to_test:
        file = files_to_test[it]
        matched = test_file(results, expressions, file)
        for j in range(0, len(expressions)):
            matched_lines = matched[j]
            if len(matched_lines) > 0:
                matched_lines_by_expression[j][file] = matched_lines

    # This is the end, go process the data then show the results!

    output_file = open(annotation_file_output_name, mode='wt', encoding="utf-8")

    output_write(f"\n{'='*5} Regex Results {'='*66}")
    output_write("\n%-12s | %-6s | %s"
        % (
            "Result",
            "Target",
            "Description"
        ),
    )
    output_write(f"{'-'*13}+{'-'*8}+{'-'*63}")

    failure = 0
    for it in range(0, len(results)):
        case = cases[it]
        count = results[it]["SUM"]

        match = True
        colour = Fore.GREEN
        if not count == case.expected:
            failure += 1
            match = False
            colour = Fore.RED

        output_write("\n", to_stdout=False)
        output_write((f"%4s:%7i |%7i | %s")
            % (
                "OK" if match else ">>>>",
                count,
                case.expected,
                case.message
            ),
            colour=colour
        )

        # Annotation info
        if not output_file.writable():
            continue
        lines_by_file = list(matched_lines_by_expression[it].items())
        files_count = len(lines_by_file)
        for jt in range(0, len(lines_by_file)):
            file, matches = lines_by_file[jt]
            padding = "\u251C" if jt < len(lines_by_file) - 1 else "\u2514"
            output_write(
                "%3s %-86s: (%3i) %s" % (padding, file, len(matches), matches),
                to_stdout= False
            )

    output_write("\n"
        + (
            f"There are mismatches present, please address those"
            if failure else
            f"All OK!"
        ),
        colour= Fore.RED if failure else Fore.GREEN,
        to_file= False
    )
    output_write("\nThis script completed in %7.3f seconds"
        % (time.time() - start_time)
    )
    output_write("\nFull match and annotation written to: %s"
        % (str.join("/", [os.getcwd(), annotation_file_output_name])),
        to_file=False
    )
    output_write(f"{'='*86}\n", to_file= False)

    output_file.close()
    output_file = None

    exit(failure > 0)
