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
import argparse             # For arguments
# Also for strong typing
from typing import Dict, List, Tuple

# Third party
import git
from git.index import typ                  # For fetching git data & diffs
from git.refs.head import Head
import unidiff              # For parsing of unified diff data
from unidiff.patch import Line, PatchedFile
import yaml                 # For configuration
import colorama             # For logging styling
from colorama import Fore, Back, Style

# Defaults
config_file_default_name = "check_regex.yaml"
annotation_file_output_name = "check_regex_output.txt"

preferred_encoding = "utf-8"

# Args
options = argparse.ArgumentParser()
options.add_argument(
    "-c", "--config",
    dest="input_config_file")
options.add_argument(
    "-u",
    "--update",
    dest="update_config_file")
options.add_argument(
    "--log-changes-only",
    dest="log_changes_only",
    default=False,
    action="store_true")

args = options.parse_args()

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

def get_config_file() -> str:
    if args.input_config_file is not None:
        return args.input_config_file
    return config_file_default_name

# Configuration loading
def load_yaml_config(config_file: str) -> Dict:
    if not os.path.exists(config_file):
        raise IOError(f"Could not find {config_file}")
        return None
    if not os.path.isfile(config_file):
        raise IOError(f"Could not open {config_file}: is not a file")
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

# Analyzer class
class RegexStandardAnalyzer:
    def __init__(self) -> None:
        self.ignore_comments = False
        self.line_comment_regex_expression = regex.compile(r'^\s*\/\/')

    def ___is_a_line_comment(self, line):
        return self.line_comment_regex_expression.match(line)

    def ___test_content_lines(self, results, key, lines):
        matched = [None] * len(self.expressions)
        for i in range(0, len(self.expressions)):
            matched[i] = []

        is_comment_block = False

        enumeration = list()
        if type(lines) is dict:
            enumeration = list(lines.items())
        else:
            enumeration = enumerate(lines)

        for (index, line) in enumeration:
            if self.ignore_comments:
                if str.find(line, '/*') >= 0:
                    is_comment_block = True
                if str.find(line, '*/') >= 0:
                    is_comment_block = False
                if is_comment_block or self.___is_a_line_comment(line):
                    continue

            for it in range(0, len(self.expressions)):
                expression = self.expressions[it]
                matches = regex.findall(expression, line)
                if len(matches) > 0:
                    matched[it].append(index + 1)
                    count = len(matches)
                    if key not in results[it]:
                        results[it][key] = count
                    else:
                        results[it][key] += count
                    results[it]["SUM"] += count
        return matched

    def ___test_file(self, results, file):
        contents = []
        with open(file, 'rt', encoding=preferred_encoding) as f:
            contents = f.readlines()
        return self.___test_content_lines(results, file, contents)

    def ___create_data_sets(self) -> Tuple[Dict, Dict]:
        results = list()
        matched_lines_by_expression = list()
        for ii in range(0, len(self.expressions)):
            results.append({
                "SUM": 0
            })
            matched_lines_by_expression.append(dict())
        return (results, matched_lines_by_expression)

    def set_expressions(self, expressions: List[TestExpression]):
        self.expressions = [None] * len(expressions)
        for ii in range(0, len(expressions)):
            s = expressions[ii]
            self.expressions[ii] = s.pattern

    def analyze_files(
        self,
        files_to_test
    ) -> Tuple[Dict, Dict]:
        (r, mlbe) = self.___create_data_sets()

        for key in files_to_test:
            file = files_to_test[key]
            matched = self.___test_file(r, file)
            for ii in range(0, len(self.expressions)):
                matched_lines = matched[ii]
                if len(matched_lines) > 0:
                    mlbe[ii][file] = matched_lines

        return (r, mlbe)

    def analyze_file_contents(
        self,
        file_contents: Dict[str, Dict[int, str]]
    ) -> Tuple[Dict, Dict]:
        (r, mlbe) = self.___create_data_sets()

        for key in file_contents:
            contents = file_contents[key]
            matched = self.___test_content_lines(r, key, contents)
            for ii in range(0, len(self.expressions)):
                matched_lines = matched[ii]
                if len(matched_lines) > 0:
                    mlbe[ii][key] = matched_lines

        return (r, mlbe)

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

def git_diff_range_branches(parent, head=None):
    parent = f"origin/{parent}"
    if head is not None:
        return "%s...%s" % (head, parent)
    return parent

def git_get_detached_head_ref(head: Head, ref_info: str):
    raw = "%s (\S+)" % head.commit.hexsha
    pattern = regex.compile(raw)
    return pattern.findall(ref_info)[0]

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

    config_file = get_config_file()

    output_write(create_title("Configuration"))
    output_write(" - Trying to load config: %s" % (
        try_normalize_path(config_file)
    ))

    raw_config = load_yaml_config(config_file)
    (standards) = parse_yaml_config(raw_config)

    N = len(standards)

    output_write(" - Succesfully loaded config: %s" % (
        try_normalize_path(config_file)
    ))
    output_write(" - Loaded %d standardization rules" % (
        len(standards)
    ))

    output_write(create_title(
        "Collection", '-'
    ))

    start_time = time.time()

    # Get diffs
    repo = git.Repo("./")
    assert not repo.bare
    assert repo.remotes.origin.exists()
    assert len(repo.remotes.origin.url)

    g = git.cmd.Git(repo)
    origin_info = g.execute(["git", "remote", "show", "origin"])
    head_pattern = regex.compile(r'[ ]*HEAD branch: ([\w\S]+)')
    head_branch = head_pattern.findall(origin_info)[0]
    other_branch = None

    output_write(" - Diff branch #1: origin/%s" % (head_branch))
    if other_branch is not None:
        output_write(" - Diff branch #2: %s" % (other_branch))
    else:
        # It is common practice to fetch PR branch as a detached branch in Github Actions
        # And a dumb bug in GitPython will always cause a "HEAD is a detached symbolic reference to xxxx"
        # when trying to get the active_branch, despite that git shows it when using "git branch"
        # But we want the actual ref, and it is possible to retrieve it from "git show-ref", then find
        # it by using the detached head's commit sha.
        d, b = "", ""
        try:
            ab = repo.active_branch
            b = ab.name
        except TypeError as te:
            other_head = repo.head
            ref_info = g.execute(["git", "show-ref"])
            d = "Detached "
            b = git_get_detached_head_ref(other_head, ref_info)
        output_write(" - Diff branch #2: %sHEAD @ %s" % (d, b))

    # Get what files have been changed, instead of getting all diffs at once
    files_with_diffs = g.diff(
        git_diff_range_branches(head_branch, other_branch),
        "--name-only"
        ).split("\n")

    files_of_interest = list(filter(
        lambda item: item.endswith(".dm"),
        files_with_diffs
    ))

    raw_diff = g.diff(git_diff_range_branches(head_branch, other_branch))
    diffs = unidiff.PatchSet.from_string(raw_diff)

    output_write(" - Found %d *.dm files with diffs, out of %d changed files" % (len(files_of_interest) ,len(files_with_diffs)))

    changed_files = list()
    diff_added_content:   Dict[str, Dict[int, str]] = dict()
    diff_removed_content: Dict[str, Dict[int, str]] = dict()
    diff: PatchedFile
    for diff in diffs:
        if not diff.path in files_of_interest:
            continue
        changed_files.append(diff.path)

        to_add = {}
        to_remove = {}
        for hunk in diff:
            line: Line
            for index, line in enumerate(hunk):
                if line.is_added:
                    to_add[index] = line.value
                elif line.is_removed:
                    to_remove[index] = line.value

        diff_added_content[diff.path] = to_add
        diff_removed_content[diff.path] = to_remove

    # Get files
    files_to_test = collect_candidate_files('./', 'dm')

    output_write(f" - Found {len(files_to_test)} '*.dm' files in local state")

    output_write(create_title(
        "Analysizing", '-'
    ))

    analyser = RegexStandardAnalyzer()
    analyser.set_expressions(standards)

    # Hate this? Don't worry. I hate it too.
    (results,       matched_lines_by_expression)    = analyser.analyze_files(files_to_test)
    (sum_added,     added_matches)                  = analyser.analyze_file_contents(diff_added_content)
    (sum_removed,   removed_matches)                = analyser.analyze_file_contents(diff_removed_content)

    # Process the results
    sum_deltas = dict()
    for ii in range(0, N):
        if sum_added[ii]['SUM'] or sum_removed[ii]['SUM']:
            if ii not in sum_deltas:
                sum_deltas[ii] = dict()
            keys = set().union(list(sum_added[ii].keys()), list(sum_removed[ii].keys()))
            for key in list(keys):
                added = sum_added[ii][key] if key in sum_added[ii] else 0
                removed = sum_removed[ii][key] if key in sum_removed[ii] else 0
                sum_deltas[ii][key] = added - removed

    # This is the end, go process the data then show the results!
    output_write(create_title("Regex Results"))
    if args.log_changes_only:
        output_write(" - Showing changes only", to_stdout=False)
    output_write("\n%27s | %-6s | %s"
        % (
            "Result",
            "Target",
            "Description"
        ),
    )
    output_write(f"{'-'*28}+{'-'*8}+{'-'*(63)}")

    failure = 0
    warning = 0
    for jj in range(0, len(results)):
        standard = standards[jj]
        count = results[jj]["SUM"]
        added = sum_added[jj]["SUM"]
        removed = sum_removed[jj]["SUM"]
        delta = sum_deltas[jj]["SUM"] if jj in sum_deltas else None

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

        stats = "%-6s %-6s %6i" % (
            ("+%-5i" % added) if added else "",
            ("-%-5i" % removed) if removed else "",
            count
        )

        output_write(
            f"{'-'*28}+{'-'*8}+{'-'*(63)}",
            to_stdout= False
        )
        output_write("%4s: %21s |%7i | %s"
            % (
                prefix,
                stats,
                standard.expected,
                standard.message
            ),
            colour=colour
        )

        # Annotation info to a file
        if not output_file.writable():
            continue


        matched_files = matched_lines_by_expression[jj]
        output_write(
            f"{'-'*28}+{'-'*8}+{'-'*(63)}",
            to_stdout= False
        )

        all_files = set()
        if args.log_changes_only:
            all_files = set().union(
                list(matched_lines_by_expression[jj].keys()),
                list(added_matches[jj].keys()),
                list(removed_matches[jj].keys())
            )
        else:
            all_files = set().union(
                list(added_matches[jj].keys()),
                list(removed_matches[jj].keys())
            )
        files_count = len(all_files)

        # Collect subitems first, depending on changes
        to_show = list()
        if files_count:
            for (index, file) in enumerate(all_files):
                lines = []
                show_items = []
                inner_prefix = ""

                matches = (matched_files[file] if file in matched_files else [])
                adds = (added_matches[jj][file] if file in added_matches[jj] else [])
                removes = (removed_matches[jj][file] if file in removed_matches[jj] else [])

                if len(matches):
                    show_items.append("Current (%4i): %s" % (len(matches), matches))
                if len(adds):
                    show_items.append("+++++++ (%4i): %s" % (len(adds), adds))
                    inner_prefix = prefix
                if len(removes):
                    show_items.append("------- (%4i): %s" % (len(removes), removes))
                    inner_prefix = prefix

                lines.append(
                    "%2s %s" % (
                        "\u2500\u252C",
                        file
                    )
                )
                for nn in range(0, len(show_items)):
                    inner_branch = "\u251C" if nn < len(show_items) - 1 else "\u2514"
                    lines.append("%2s %s" % (
                            inner_branch,
                            show_items[nn]
                        )
                    )
                to_show.append((inner_prefix, lines))

        # Finally render subitems if there are any present
        if len(to_show):
            for (index, (inner_prefix, lines)) in enumerate(to_show):
                branch = "\u251C" if index < len(to_show) - 1 else "\u2514"
                stem = "\u2502" if index < len(to_show) -1 else " "
                for jj, line in enumerate(lines):
                    if jj == 0:
                        output_write("%4s %1s%s" % (inner_prefix, branch, line), to_stdout=False)
                    else:
                        output_write("%4s %1s%s" % (inner_prefix, stem, line), to_stdout=False)
                if index < len(to_show) - 1:
                    output_write("%4s %1s" % (inner_prefix, stem), to_stdout=False)
        else:
            output_write(
                "%6s %s" % (
                    "\u2514",
                    "None found" if not args.log_changes_only else "No changes found"
                ),
                to_stdout= False
            )
        # end

        output_write("", to_stdout=False) # Just space out between the lines

    output_write("\n"
        + (
            "There are mismatches present, please address those"
            if failure else
            "There are possible improvements present, a review of code or configured values is recommended"
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
