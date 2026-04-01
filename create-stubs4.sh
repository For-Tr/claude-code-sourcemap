#!/bin/bash
SRC="/Users/xiangbingzhou/xbz/claude-code-sourcemap/restored-src/src"

stub() {
  local path="$SRC/$1"
  local dir=$(dirname "$path")
  mkdir -p "$dir"
  echo "// Stub: $1 (not restored from sourcemap)
export {}" > "$path"
  echo "Created: $1"
}

# Tools
stub tools/ReviewArtifactTool/ReviewArtifactTool.ts
stub tools/WorkflowTool/WorkflowPermissionRequest.ts

# Permissions components
stub components/permissions/ReviewArtifactPermissionRequest/ReviewArtifactPermissionRequest.tsx
stub components/permissions/MonitorPermissionRequest/MonitorPermissionRequest.tsx

# global.d.ts for ink (already in correct place under src/global.d.ts but need under src/ink/../global.d.ts = src/global.d.ts)
# Box.tsx imports '../global.d.ts' from src/ink/components/ so the path resolves to src/global.d.ts
echo "// global type declarations" > "$SRC/global.d.ts"

# skills/bundled types
# The ./types.js error - find which directory it's from
# Check skills/bundled for types reference
stub skills/bundled/types

# skills/bundled .md files - need to exist as text files
mkdir -p "$SRC/skills/bundled/verify/examples"
mkdir -p "$SRC/skills/bundled/claude-api/csharp"
mkdir -p "$SRC/skills/bundled/claude-api/curl"
mkdir -p "$SRC/skills/bundled/claude-api/go"
mkdir -p "$SRC/skills/bundled/claude-api/java"
mkdir -p "$SRC/skills/bundled/claude-api/php"
mkdir -p "$SRC/skills/bundled/claude-api/python/agent-sdk"
mkdir -p "$SRC/skills/bundled/claude-api/python/claude-api"
mkdir -p "$SRC/skills/bundled/claude-api/ruby"
mkdir -p "$SRC/skills/bundled/claude-api/shared"
mkdir -p "$SRC/skills/bundled/claude-api/typescript/agent-sdk"
mkdir -p "$SRC/skills/bundled/claude-api/typescript/claude-api"

# Create empty .md files
for f in \
  "skills/bundled/verify/SKILL.md" \
  "skills/bundled/verify/examples/cli.md" \
  "skills/bundled/verify/examples/server.md" \
  "skills/bundled/claude-api/SKILL.md" \
  "skills/bundled/claude-api/csharp/claude-api.md" \
  "skills/bundled/claude-api/curl/examples.md" \
  "skills/bundled/claude-api/go/claude-api.md" \
  "skills/bundled/claude-api/java/claude-api.md" \
  "skills/bundled/claude-api/php/claude-api.md" \
  "skills/bundled/claude-api/python/agent-sdk/README.md" \
  "skills/bundled/claude-api/python/agent-sdk/patterns.md" \
  "skills/bundled/claude-api/python/claude-api/README.md" \
  "skills/bundled/claude-api/python/claude-api/batches.md" \
  "skills/bundled/claude-api/python/claude-api/files-api.md" \
  "skills/bundled/claude-api/python/claude-api/streaming.md" \
  "skills/bundled/claude-api/python/claude-api/tool-use.md" \
  "skills/bundled/claude-api/ruby/claude-api.md" \
  "skills/bundled/claude-api/shared/error-codes.md" \
  "skills/bundled/claude-api/shared/live-sources.md" \
  "skills/bundled/claude-api/shared/models.md" \
  "skills/bundled/claude-api/shared/prompt-caching.md" \
  "skills/bundled/claude-api/shared/tool-use-concepts.md" \
  "skills/bundled/claude-api/typescript/agent-sdk/README.md" \
  "skills/bundled/claude-api/typescript/agent-sdk/patterns.md" \
  "skills/bundled/claude-api/typescript/claude-api/README.md" \
  "skills/bundled/claude-api/typescript/claude-api/batches.md" \
  "skills/bundled/claude-api/typescript/claude-api/files-api.md" \
  "skills/bundled/claude-api/typescript/claude-api/streaming.md" \
  "skills/bundled/claude-api/typescript/claude-api/tool-use.md"
do
  echo "" > "$SRC/$f"
  echo "Created: $f"
done

echo "Done round 4!"
