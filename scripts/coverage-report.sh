#!/usr/bin/env bash
set -euo pipefail

RESULT_BUNDLE="${1:-TestResults.xcresult}"
OUTPUT_FILE="${2:-coverage-comment.md}"
TARGET_NAME="${3:-GithubStars}"

if [[ ! -d "$RESULT_BUNDLE" ]]; then
  echo "Result bundle not found: $RESULT_BUNDLE" >&2
  exit 1
fi

xcrun xccov view --report --json "$RESULT_BUNDLE" > coverage.json

python3 - "$OUTPUT_FILE" "$TARGET_NAME" "$RESULT_BUNDLE" <<'PY'
import json
import subprocess
import sys
from pathlib import Path

output_file = sys.argv[1]
target_name = sys.argv[2]
result_bundle = sys.argv[3]
data = json.loads(Path("coverage.json").read_text())

targets = data.get("targets", [])
target = next(
    (
        t
        for t in targets
        if t.get("name") in {target_name, f"{target_name}.app"}
    ),
    None,
)

if target is None:
    line_coverage = "N/A"
else:
    line_coverage = f"{target.get('lineCoverage', 0) * 100:.1f}%"

summary = subprocess.run(
    [
        "xcrun",
        "xcresulttool",
        "get",
        "test-results",
        "summary",
        "--path",
        result_bundle,
    ],
    check=True,
    capture_output=True,
    text=True,
)
test_data = json.loads(summary.stdout)
passed = test_data.get("passedTests", 0)
failed = test_data.get("failedTests", 0)
total = passed + failed

if failed:
    test_line = f"Tests: {passed} passed, {failed} failed ({total} total)"
else:
    test_line = f"Tests: {passed} passed"

display_name = target.get("name", target_name) if target else target_name
markdown = f"""## Code coverage

| Target | Line coverage |
| ------ | ------------- |
| {display_name} | {line_coverage} |

{test_line}
"""

Path(output_file).write_text(markdown)
print(markdown)
PY
