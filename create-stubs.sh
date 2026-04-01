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

# Coordinator
stub coordinator/workerAgent

# Skills
stub skills/mcpSkills

# Tasks
stub tasks/MonitorMcpTask/MonitorMcpTask

# Tools
stub tools/OverflowTestTool/OverflowTestTool
stub tools/TerminalCaptureTool/TerminalCaptureTool
stub tools/TerminalCaptureTool/prompt
stub tools/TungstenTool/TungstenTool
stub tools/WorkflowTool/WorkflowTool
stub tools/WorkflowTool/createWorkflowCommand
stub tools/WorkflowTool/constants
stub tools/WorkflowTool/bundled/index
stub tools/VerifyPlanExecutionTool/VerifyPlanExecutionTool
stub tools/VerifyPlanExecutionTool/constants
stub tools/ListPeersTool/ListPeersTool
stub tools/MonitorTool/MonitorTool
stub tools/PushNotificationTool/PushNotificationTool
stub tools/REPLTool/REPLTool
stub tools/SendUserFileTool/SendUserFileTool
stub tools/SendUserFileTool/prompt
stub tools/SleepTool/SleepTool
stub tools/SnipTool/SnipTool
stub tools/SnipTool/prompt
stub tools/SubscribePRTool/SubscribePRTool
stub tools/SuggestBackgroundPRTool/SuggestBackgroundPRTool
stub tools/WebBrowserTool/WebBrowserTool
stub tools/CtxInspectTool/CtxInspectTool

# Services
stub services/contextCollapse/index
stub services/skillSearch/localSearch
stub services/skillSearch/prefetch
stub services/compact/reactiveCompact
stub services/compact/snipCompact
stub services/compact/cachedMicrocompact

# Utils
stub utils/attributionHooks
stub utils/taskSummary
stub utils/udsMessaging

# SDK
stub sdk/runtimeTypes
stub sdk/toolTypes

# Types
stub types/connectorText

# Jobs
stub jobs/classifier

# Root-level
stub coreTypes.generated
stub dream
stub hunter
stub protectedNamespace
stub runSkillGenerator

# Commands
stub commands/subscribe-pr
stub commands/torch
stub commands/workflows/index

# YoloClassifier prompt text files (as TS)
mkdir -p "$SRC/yolo-classifier-prompts"
echo "export default ''" > "$SRC/yolo-classifier-prompts/auto_mode_system_prompt.txt.ts"
echo "export default ''" > "$SRC/yolo-classifier-prompts/permissions_anthropic.txt.ts"
echo "export default ''" > "$SRC/yolo-classifier-prompts/permissions_external.txt.ts"

# These are referenced as .txt files - create actual .txt files
echo "" > "$SRC/yolo-classifier-prompts/auto_mode_system_prompt.txt"
echo "" > "$SRC/yolo-classifier-prompts/permissions_anthropic.txt"
echo "" > "$SRC/yolo-classifier-prompts/permissions_external.txt"

echo "Done! All stubs created."
