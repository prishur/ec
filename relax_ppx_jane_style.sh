#!/usr/bin/env bash
set -e

echo "Patching source files to relax Jane Street PPX style rules..."

# Fix "Ignored expression must come with a type annotation"
# → Wrap ignored expressions with `ignore (...)`
grep -rl '^[[:space:]]*[a-zA-Z0-9_]\+(.*);$' . \
  | grep '\.ml$' \
  | xargs sed -i 's/^\([[:space:]]*\)\([a-zA-Z0-9_]\+(.*)\);$/\1ignore (\2);/'

# Fix "Toplevel expressions not allowed here"
# → Add `let _ =` in front of bare expressions
grep -rl '^[[:space:]]*[a-zA-Z0-9_]\+(.*);;$' . \
  | grep '\.ml$' \
  | xargs sed -i 's/^\([[:space:]]*\)\([a-zA-Z0-9_]\+(.*)\);\;$/\1let _ = \2;;/'

echo "Patch applied successfully."

