#!/usr/bin/env bash
set -euo pipefail

RESULT_BUNDLE="${1:-TestResults.xcresult}"
OUTPUT_FILE="${2:-coverage-comment.md}"
TARGET_NAME="${3:-GithubStars}"

write_fallback() {
  local reason="$1"
  cat > "$OUTPUT_FILE" <<EOF
## Code coverage

Coverage report unavailable ($reason).
EOF
  echo "Wrote fallback coverage comment: $reason" >&2
  cat "$OUTPUT_FILE"
}

if [[ ! -d "$RESULT_BUNDLE" ]]; then
  write_fallback "tests did not produce a result bundle"
  exit 0
fi

if ! xcrun xccov view --report --json "$RESULT_BUNDLE" > coverage.json; then
  write_fallback "failed to parse coverage from result bundle"
  exit 1
fi

if ! python3 - "$OUTPUT_FILE" "$TARGET_NAME" "$RESULT_BUNDLE" <<'PY'
import json
import subprocess
import sys
from pathlib import Path

output_file = sys.argv[1]
target_name = sys.argv[2]
result_bundle = sys.argv[3]

try:
    data = json.loads(Path("coverage.json").read_text())
except Exception as exc:
    Path(output_file).write_text(
        "## Code coverage\n\n"
        f"Coverage report unavailable (invalid coverage JSON: {exc}).\n"
    )
    sys.exit(1)

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

try:
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
except Exception:
    test_line = "Tests: unavailable"

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
then
  write_fallback "failed to build coverage markdown"
  exit 1
fi
