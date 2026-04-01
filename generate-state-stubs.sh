#!/bin/bash
# Generate stub exports for all missing bootstrap/state.ts symbols
STATE_FILE="/Users/xiangbingzhou/xbz/claude-code-sourcemap/restored-src/src/bootstrap/state.ts"

# Missing exports to add as stubs
MISSING=(
  addInvokedSkill
  addSlowOperation
  clearInvokedSkillsForAgent
  flushInteractionTime
  getAdditionalDirectoriesForClaudeMd
  getAgentColorMap
  getAllowedChannels
  getAllowedSettingSources
  getBudgetContinuationCount
  getClientType
  getCodeEditToolDecisionCounter
  getCommitCounter
  getCurrentTurnTokenBudget
  getEventLogger
  getHasDevChannels
  getInitialMainLoopModel
  getInlinePlugins
  getInvokedSkillsForAgent
  getIsInteractive
  getIsNonInteractiveSession
  getIsRemoteMode
  getIsScrollDraining
  getKairosActive
  getLastAPIRequest
  getLastInteractionTime
  getLocCounter
  getMainLoopModelOverride
  getMainThreadAgentType
  getMcpHubClientInfoForConnection
  getMeter
  getNeedsAutoModeExitAttachment
  getNeedsPlanModeExitAttachment
  getQuestionPreviewFormat
  getScheduledTasksEnabled
  getSdkBetas
  getSessionBypassPermissionsMode
  getSessionMcpToolCache
  getSessionPersistenceDisabled
  getSessionSource
  getSessionTrustAccepted
  getStatsStore
  getTeleportedSessionInfo
  getTokensForTurn
  getUseCoworkPlugins
  getUserMsgOptIn
  hasExitedPlanMode
  incrementBudgetContinuationCount
  incrementCodeEditToolDecisionCounter
  incrementCommitCounter
  incrementLocCounter
  isReplBridgeActive
  onTurnTokenBudgetChange
  resetBudgetContinuationCount
  resetCodeEditToolDecisionCounter
  resetCommitCounter
  resetLocCounter
  resetTurnTokenCounters
  resetTurnTokenCounters_FOR_TESTS_ONLY
  setAdditionalDirectoriesForClaudeMd
  setAgentColorMap
  setAllowedChannels
  setAllowedSettingSources
  setChromeFlagOverride
  setClientType
  setCostStateForRestore
  setFlagSettingsPath
  setHasDevChannels
  setHasExitedPlanMode
  setHasUnknownModelCost
  setInitialMainLoopModel
  setInlinePlugins
  setIsInteractive
  setIsRemoteMode
  setKairosActive
  setLspRecommendationShownThisSession
  setMainLoopModelOverride
  setMainThreadAgentType
  setMeter
  setNeedsAutoModeExitAttachment
  setNeedsPlanModeExitAttachment
  setQuestionPreviewFormat
  setScheduledTasksEnabled
  setSdkBetas
  setSessionBypassPermissionsMode
  setSessionPersistenceDisabled
  setSessionSource
  setSessionTrustAccepted
  setStatsStore
  setTeleportedSessionInfo
  setUseCoworkPlugins
  setUserMsgOptIn
  snapshotOutputTokensForTurn
  updateLastInteractionTime
  waitForScrollIdle
)

# Append stub functions to state.ts
{
  echo ""
  echo "// ===== STUB EXPORTS (not restored from sourcemap) ====="
  for fn in "${MISSING[@]}"; do
    # Skip type-only names
    echo "export function ${fn}(..._args: any[]): any { return undefined as any }"
  done
  echo "// Special alias"
  echo "export const getActiveTimeCounterImpl = () => undefined as any"
  echo "export function typeChannelEntry(..._args: any[]): any { return undefined as any }"
} >> "$STATE_FILE"

echo "Added $(echo "${#MISSING[@]}") stub exports to state.ts"
