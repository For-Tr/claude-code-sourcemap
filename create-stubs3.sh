#!/bin/bash
SRC="/Users/xiangbingzhou/xbz/claude-code-sourcemap/restored-src/src"

stub() {
  local path="$SRC/$1.ts"
  local dir=$(dirname "$path")
  mkdir -p "$dir"
  echo "// Stub: $1 (not restored from sourcemap)
export {}" > "$path"
  echo "Created: $1.ts"
}

# Correct locations from grep results
stub memdir/memoryShapeTelemetry
stub utils/protectedNamespace
stub skills/bundled/dream
stub skills/bundled/hunter
stub skills/bundled/runSkillGenerator

# ink/devtools
stub ink/devtools

# utils/attributionTrailer
stub utils/attributionTrailer

# components/tasks
stub components/tasks/WorkflowDetailDialog
stub components/tasks/MonitorMcpDetailDialog

# entrypoints
stub entrypoints/sdk/coreTypes.generated
stub entrypoints/sdk/runtimeTypes
stub entrypoints/sdk/toolTypes

# services
stub services/contextCollapse/operations

# tasks
stub tasks/LocalWorkflowTask/LocalWorkflowTask

# utils/systemThemeWatcher
stub utils/systemThemeWatcher

# proactive
stub proactive/useProactive

# tools
stub tools/TungstenTool/TungstenLiveMonitor
stub tools/WebBrowserTool/WebBrowserPanel

# components/messages
stub components/messages/SnipBoundaryMessage

# ultraplan prompt .txt
mkdir -p "$SRC/utils/ultraplan"
echo "" > "$SRC/utils/ultraplan/prompt.txt"

# global.d.ts stub (TypeScript ambient declarations)
echo "// global type declarations stub" > "$SRC/global.d.ts"

echo "Done round 3!"
