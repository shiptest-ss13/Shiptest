'''
Usage:
    $ python check_regex.py

check_regex.py - Run regex expression tests on all DM code inside current
    directory

    Requires a default/HEAD branch and an origin to exist in the git to
    make use of diffs. So you can easily track changes in your branch
    compared to the master it branched off from. With that said, you will
    require an accessible Git installation for this feature to work as well.

    Requires a check_regex.yaml config to work proper. See in repository's
    root or somewhere applicable to find an example with instructions.
    Granted - if the config was not cargo-culted then stripped.

    This takes the following arguments:
    -c, --config <config file>
        Overrides the default configuration with
        with the specificed configuration yaml file

    -u, --update <OPTIONAL: config file>
        Tells this to update the default or the config overriden as above
        optionally, you can give it the name/path of the configuration file
        it should save to instead of overwriting the original. While updating
        a backup of the original will always be created

    --log-changes-only
        An output option to suppress all matches it was found but not in
        diffs; leaving only files with changed contents, be it add,
        modification, or removal. Good if you want to track down errors
        caused by commit or PR changes.

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
import difflib              # For sequence matching of strings (for updating and merging config files)
# Also for strong typing
from typing import Dict, List, Pattern, Tuple

# Third party
import git                  # For fetching git data & diffs
from git.refs.head import Head
import unidiff              # For parsing of unified diff data
from unidiff.patch import Line, PatchedFile
import yaml                 # For configuration
from yaml.dumper import Dumper
from yaml.nodes import MappingNode
import colorama             # For logging styling
from colorama import Fore, Back, Style

# Defaults
config_file_default_name = "check_regex.yaml"
annotation_file_output_name = "check_regex_output.txt"

# The required ratio score for using the new configuration line instead of old
config_update_string_score_decision_limit = 0.80

preferred_encoding = "utf-8"

# Args
options = argparse.ArgumentParser()
options.add_argument(
    "-c", "--config",
    dest="input_config_file")
options.add_argument(
    "-u",
    "--update",
    dest="update_config_file",
    nargs='?',
    const=True,
    default=False)
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
        method: str,
        dump_hint: int
    ):
        self.expected = expected
        self.message = message
        self.pattern: Pattern = regex.compile(pattern)
        self.method = method
        self.dump_hint = dump_hint

    def __repr__(self) -> str:
        return self.__str__()

    def __str__(self) -> str:
        return ("TestExpression[%s -> %d, %s, %s]" % (
            self.method,
            self.expected,
            self.message,
            self.pattern
        ))

    def copy(self):
        return TestExpression(
            self.expected,
            self.message,
            self.pattern.pattern,
            self.method,
            self.dump_hint
        )

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

DUMP_HINT_SHORT = 1
DUMP_HINT_VERBOSE = 2

def get_config_file() -> str:
    if args.input_config_file is not None:
        return args.input_config_file
    return config_file_default_name

def get_config_update_target_file() -> str:
    if type(args.update_config_file) is str:
        return args.update_config_file
    return get_config_file()

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
                num, message, pattern, method, DUMP_HINT_SHORT
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
                    method,
                    DUMP_HINT_VERBOSE
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

# A override class to override the official specification where
# indentation "iS nOt NeCeSsEcArY", that is bullshit
#
# See https://web.archive.org/web/20170903201521/https://pyyaml.org/ticket/64
class IndentedDumper(yaml.Dumper):
    def increase_indent(self, flow, indentless=False):
        return super(IndentedDumper, self).increase_indent(flow=flow, indentless=False)

# Configuration dumping (for updating)
def dump_config_yaml(config_file: str, standards: List[TestExpression]) -> None:
    def dump_standards_set(dumper: Dumper, l: List[TestExpression]):
        return dumper.represent_list(l)

    def dump_test_expression(dumper: Dumper, standard: TestExpression):
        def dump_short() -> MappingNode:
            mapNode = dumper.represent_dict({})
            listNode = dumper.represent_list([])
            listNode.flow_style = True

            expected = dumper.represent_int(standard.expected)
            message = dumper.represent_str(standard.message)
            message.style = "'"
            pattern = dumper.represent_str(standard.pattern.pattern)
            pattern.style = "'"
            listNode.value.append(expected)
            listNode.value.append(message)
            listNode.value.append(pattern)
            mapNode.value.append(
                (dumper.represent_str(standard.method), listNode)
            )
            return mapNode

        def dump_verbose() -> MappingNode:
            tmp = dumper.sort_keys
            dumper.sort_keys = False
            node = dumper.represent_dict({
                "target": {
                    f"{standard.method}": standard.expected
                },
                "message": standard.message,
                "pattern": standard.pattern.pattern
            })
            dumper.sort_keys = tmp
            return node


        if standard.dump_hint == DUMP_HINT_SHORT:
            return dump_short()
        if standard.dump_hint == DUMP_HINT_VERBOSE:
            return dump_verbose()
        return None

    def string_score(left, right) -> float:
        return difflib.SequenceMatcher(None, left, right).ratio()

    yaml.add_representer(List[TestExpression], dump_standards_set)
    yaml.add_representer(TestExpression, dump_test_expression)

    new_yaml = yaml.dump({
        "standards": standards
    }, indent=2, width=512, Dumper=IndentedDumper)

    old_yaml = ""
    with open(config_file, mode="rt", encoding=preferred_encoding) as f:
        old_yaml = f.read()

    # Create backup of the old config file
    backup_file = f"{config_file}.backup"
    with open(backup_file, mode="wt", encoding=preferred_encoding) as f:
        f.write(old_yaml)
    output_write("Config Update: Created backup file: %s" % backup_file)

    # Try to combine the new into the old
    new_lines = new_yaml.split("\n")
    old_lines = [(l if not l == "" else "\0") for l in old_yaml.split("\n")]
    output = []
    ii, jj = 0, 0
    nnew, nold = len(new_lines), len(old_lines)
    while (ii < nnew or jj < nold):
        increment_left, increment_right = False, False
        new = new_lines[ii] if ii < nnew else None
        old = old_lines[jj] if jj < nold else None

        if new and old:
            score = string_score(new, old)
            if score > config_update_string_score_decision_limit:
                increment_left = True
                increment_right = True
                output.append(new)
            else:
                increment_right = True
                output.append(old)
        else:
            increment_left = increment_right = True
            if (ii < nnew):
                output.append(new)
            else:
                output.append(old)

        if (increment_left and ii < nnew):
            ii += 1
        if (increment_right and jj < nold):
            jj += 1

    # Time to output it
    combined = str.join("\n", [
        l if not l == "\0" else ""
        for l in output
    ])
    with open(config_file, mode="wt", encoding=preferred_encoding) as f:
        f.write(combined)
    output_write("Config Update: Updated config file: %s" % config_file)

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
                if os.name == "nt":
                    full_path = full_path.replace('\\', '/')
                candidates[len(candidates) + 1] = full_path
    return candidates

# Analyzer class
class RegexStandardAnalyzer:
    def __init__(self) -> None:
        self.ignore_comments = False
        self.invalid_encoding = 0
        self.line_comment_regex_expression = regex.compile(r'^\s*\/\/')

    def ___is_a_line_comment(self, line) -> bool:
        return self.line_comment_regex_expression.match(line)

    def ___empty_match_list(self) -> List:
        return [[] for _ in range(0, len(self.expressions))]

    def ___test_content_lines(self, results, key, lines):
        matched = self.___empty_match_list()
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
        try:
            contents = []
            with open(file, 'rt', encoding=preferred_encoding) as f:
                contents = f.readlines()
            return self.___test_content_lines(results, file, contents)
        except UnicodeDecodeError as _:
            self.invalid_encoding += 1
            output_write(" - Not encoded with %s!: %s" % (
                    preferred_encoding,
                    file
                ),
                colour=Fore.RED
            )
            return self.___empty_match_list()

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

def output_write(message, colour=None, to_stdout=True, to_file=True) -> None:
    if to_stdout:
        if colour is not None:
            print(f"{colour}{message}{Fore.RESET}")
        else:
            print(message)
    if to_file and output_file is not None:
        output_file.write(message + "\n")

def create_title(title, char='=') -> None:
    MAX_WIDTH = 100
    if len(title):
        right = MAX_WIDTH - (7 + len(title))
        return f"\n{char*5} {title} {char*right}"
    return char*MAX_WIDTH

def try_normalize_path(filepath) -> str:
    return os.path.normpath(filepath)

def git_diff_range_branches(parent, head=None) -> str:
    parent = f"origin/{parent}"
    if head is not None:
        return "%s...%s" % (head, parent)
    return parent

def git_get_detached_head_ref(head: Head, ref_info: str) -> str:
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
    if args.update_config_file:
        output_write("\nNOTE: Config file %s will be updated end of this script" % (
            get_config_update_target_file()
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

    g: git.Git = git.Git(repo)
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

    # Get diffs
    raw_diff = g.diff([
        git_diff_range_branches(head_branch, other_branch),
        "*.dm"
    ])
    diffs = unidiff.PatchSet.from_string(raw_diff)

    changed_files = list()
    diff_added_content:   Dict[str, Dict[int, str]] = dict()
    diff_removed_content: Dict[str, Dict[int, str]] = dict()
    diff: PatchedFile
    n_added_lines = 0
    n_removed_lines = 0
    for diff in diffs:
        if not diff.path.endswith(".dm"):
            continue
        changed_files.append(diff.path)

        to_add = {}
        to_remove = {}
        for hunk in diff:
            line: Line
            for line in hunk:
                # For love of mother god, please do not use `index` here
                # Else you will cause an overwrite of what was saved to
                # the lists below, as each file can have more than one
                # hunk. Which index will go back to 0 several times
                if line.is_added:
                    to_add[line.target_line_no] = line.value
                if line.is_removed:
                    to_remove[line.source_line_no] = line.value

        assert(diff.added == len(to_add))
        assert(diff.removed == len(to_remove))

        diff_added_content[diff.path] = to_add
        diff_removed_content[diff.path] = to_remove
        n_added_lines += len(to_add)
        n_removed_lines += len(to_add)

    output_write(" - Found %d *.dm files with diffs" % (len(changed_files)))
    output_write(f"    - Added lines:   {n_added_lines}")
    output_write(f"    - Removed lines: {n_removed_lines}")

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
                list(added_matches[jj].keys()),
                list(removed_matches[jj].keys())
            )
        else:
            all_files = set().union(
                list(matched_lines_by_expression[jj].keys()),
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

    if args.update_config_file:
        output_write("" , to_file=False)
        new_standards = [
            s.copy() for s in standards
        ]

        updates = 0
        for ii in range(0, len(standards)):
            new = new_standards[ii]
            old = standards[ii]
            new.expected = results[ii]['SUM']
            if new.expected != old.expected:
                updates += 1

        if updates > 0:
            output_write("Config Update: %d target%s will be updated" % (
                updates,
                "s" if updates > 1 else ""
            ))
            dump_config_yaml(
                get_config_update_target_file(),
                new_standards
            )
        else:
            output_write("Config Update: No deltas were found between results and targets, the config will not be updated.")
    else:
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

    fail_files = analyser.invalid_encoding
    if fail_files > 0:
        output_write(
            "\nThere are %d file(s) not encoded with \"%s\", please fix those shown in \"Analysizing\" stage!" % (
                fail_files,
                preferred_encoding
            ),
            colour=Fore.RED
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

    exit(failure > 0 or fail_files > 0)
