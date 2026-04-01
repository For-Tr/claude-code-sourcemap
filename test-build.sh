#!/bin/bash
cd /Users/xiangbingzhou/xbz/claude-code-sourcemap
SETUP='
cp -r /src/. /build && cd /build &&
export BUN_CONFIG_REGISTRY=https://registry.npmmirror.com &&
bun install --ignore-scripts 2>&1 | tail -3 &&
mkdir -p "node_modules/@ant/claude-for-chrome-mcp" &&
echo "{\"name\":\"@ant/claude-for-chrome-mcp\",\"version\":\"0.0.0\",\"main\":\"index.js\"}" > "node_modules/@ant/claude-for-chrome-mcp/package.json" &&
echo "export default {}; export function createClaudeForChromeMcpServer(){}" > "node_modules/@ant/claude-for-chrome-mcp/index.js" &&
for pkg in "@ant/computer-use-input" "@ant/computer-use-swift"; do
  mkdir -p "node_modules/$pkg" &&
  echo "{\"name\":\"$pkg\",\"version\":\"0.0.0\",\"main\":\"index.js\"}" > "node_modules/$pkg/package.json" &&
  echo "export default {}" > "node_modules/$pkg/index.js"
done &&
mkdir -p node_modules/@ant/computer-use-mcp &&
echo "{\"name\":\"@ant/computer-use-mcp\",\"version\":\"0.0.0\",\"main\":\"index.js\",\"exports\":{\".\": \"./index.js\",\"./sentinelApps\":\"./sentinelApps.js\",\"./types\":\"./types.js\"}}" > node_modules/@ant/computer-use-mcp/package.json &&
echo "export default {}; export const API_RESIZE_PARAMS = {}; export const targetImageSize = { width: 1280, height: 800 }; export function bindSessionContext(){}; export const ComputerUseSessionContext = {}; export const CuCallToolResult = {}; export const CuPermissionRequest = {}; export const CuPermissionResponse = {}; export const DEFAULT_GRANT_FLAGS = {}; export const ScreenshotDims = {}; export function buildComputerUseTools(){}; export function createComputerUseMcpServer(){}" > node_modules/@ant/computer-use-mcp/index.js &&
echo "export function getSentinelCategory(){return null}" > node_modules/@ant/computer-use-mcp/sentinelApps.js &&
echo "export const DEFAULT_GRANT_FLAGS={}" > node_modules/@ant/computer-use-mcp/types.js &&
mkdir -p node_modules/color-diff-napi node_modules/modifiers-napi node_modules/audio-capture-napi node_modules/sharp &&
echo "{\"name\":\"color-diff-napi\",\"version\":\"0.0.0\",\"main\":\"index.js\"}" > node_modules/color-diff-napi/package.json &&
echo "export function diff(){return 0}" > node_modules/color-diff-napi/index.js &&
echo "{\"name\":\"modifiers-napi\",\"version\":\"0.0.0\",\"main\":\"index.js\"}" > node_modules/modifiers-napi/package.json &&
echo "export function isModifierPressed(){return false}" > node_modules/modifiers-napi/index.js &&
echo "{\"name\":\"audio-capture-napi\",\"version\":\"0.0.0\",\"main\":\"index.js\"}" > node_modules/audio-capture-napi/package.json &&
echo "export function startCapture(){}" > node_modules/audio-capture-napi/index.js &&
echo "{\"name\":\"sharp\",\"version\":\"0.34.0\",\"main\":\"index.js\"}" > node_modules/sharp/package.json &&
echo "export default function sharp(){throw new Error(\"not available\")}" > node_modules/sharp/index.js &&
bun build ./src/main.tsx --outfile /tmp/out.js --target bun --loader .txt:text --loader .md:text 2>&1 | head -100
'
docker run --rm \
  -v "$(pwd)/restored-src:/src:ro" \
  docker.1panel.live/oven/bun:1.2 \
  sh -c "$SETUP" 2>&1
