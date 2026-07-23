#!/usr/bin/env bash
#
# Convert bare YouTube video links in content/ to Hugo's built-in
# {{< youtube >}} shortcode so posts get an embedded player instead
# of a plain link.
#
#   scripts/convert_youtube_links.sh            # rewrite files
#   scripts/convert_youtube_links.sh --dry-run  # preview, no changes
#
# Only lines that consist solely of a video link are converted, in
# these shapes (leading/trailing whitespace allowed):
#
#   https://youtu.be/<id>
#   https://www.youtube.com/watch?v=<id>
#   https://youtube.com/live/<id>
#   [<url>](<url>)          (link text identical to the target)
#
# The www. prefix is optional on youtube.com forms. Links with query
# params (e.g. ?t= timestamps) are left alone: an embed would lose
# the timestamp.
#
# WordPress-escaped underscores in ids (e.g. 0s\_3jVIttnc) are
# unescaped. Inline links, links with real anchor text, playlist and
# channel links are left untouched.

set -euo pipefail

cd "$(dirname "$0")/.."

dry_run=0
if [[ "${1:-}" == "--dry-run" ]]; then
  dry_run=1
elif [[ $# -gt 0 ]]; then
  echo "Usage: $0 [--dry-run]" >&2
  exit 1
fi

awk_program='
function extract_id(url,    id) {
  if (url ~ /^https:\/\/youtu\.be\/[A-Za-z0-9_\\-]+$/) {
    id = url
    sub(/^https:\/\/youtu\.be\//, "", id)
  } else if (url ~ /^https:\/\/(www\.)?youtube\.com\/watch\?v=[A-Za-z0-9_\\-]+$/) {
    id = url
    sub(/^.*v=/, "", id)
  } else if (url ~ /^https:\/\/(www\.)?youtube\.com\/live\/[A-Za-z0-9_\\-]+$/) {
    id = url
    sub(/^.*\/live\//, "", id)
  } else {
    return ""
  }
  gsub(/\\/, "", id)  # WordPress migration escaped underscores
  return id
}

{
  trimmed = $0
  sub(/^[ \t]+/, "", trimmed)
  sub(/[ \t]+$/, "", trimmed)

  url = ""
  if (trimmed ~ /^\[[^]]+\]\([^)]+\)$/) {
    text = trimmed
    sub(/^\[/, "", text)
    sub(/\].*$/, "", text)
    target = trimmed
    sub(/^[^)]*\(/, "", target)
    sub(/\)$/, "", target)
    if (text == target) url = target
  } else {
    url = trimmed
  }

  id = extract_id(url)
  if (id != "") {
    printf "{{< youtube \"%s\" >}}\n", id
    if (mode == "report") printf "%s:%d: %s\n", FILENAME, FNR, trimmed > "/dev/stderr"
    converted++
  } else {
    print
  }
}

END { exit (converted > 0 ? 0 : 1) }
'

total=0
files=0

while IFS= read -r file; do
  if ((dry_run)); then
    # Report matches; discard the rewritten output.
    matches=$(awk -v mode=report "$awk_program" "$file" 2>&1 >/dev/null) || continue
    echo "$matches"
    count=$(printf '%s\n' "$matches" | wc -l | tr -d ' ')
  else
    tmp="${file}.ytconvert.tmp"
    if matches=$(awk -v mode=report "$awk_program" "$file" 2>&1 > "$tmp"); then
      count=$(printf '%s\n' "$matches" | wc -l | tr -d ' ')
      mv "$tmp" "$file"
      echo "$file: converted $count link(s)"
    else
      rm -f "$tmp"
      continue
    fi
  fi
  total=$((total + count))
  files=$((files + 1))
done < <(find content -name '*.md' -type f | sort)

if ((dry_run)); then
  echo "Dry run: would convert $total link(s) in $files file(s)."
else
  echo "Converted $total link(s) in $files file(s)."
fi
