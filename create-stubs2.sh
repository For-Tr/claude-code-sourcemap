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

# This round of missing files
stub assistant/AssistantSessionChooser
stub commands/assistant/assistant
stub commands/assistant/index
stub commands/agents-platform/index
stub commands/proactive
stub commands/remoteControlServer/index
stub commands/force-snip
stub commands/peers/index
stub commands/fork/index
stub commands/buddy/index
stub bridge/peerSessions
stub utils/udsClient
stub services/sessionTranscript/sessionTranscript
stub services/compact/snipProjection
stub services/compact/cachedMCConfig
stub services/skillSearch/remoteSkillState
stub services/skillSearch/remoteSkillLoader
stub services/skillSearch/telemetry
stub services/skillSearch/featureCheck
stub services/contextCollapse/persist
stub tools/DiscoverSkillsTool/prompt

# .txt files - bun can import text files with loader
echo "" > "$SRC/yolo-classifier-prompts/auto_mode_system_prompt.txt"
echo "" > "$SRC/yolo-classifier-prompts/permissions_anthropic.txt"
echo "" > "$SRC/yolo-classifier-prompts/permissions_external.txt"

echo "Done!"
