# ===== Stage 1: 安装依赖 & 编译 =====
# 使用国内镜像源 docker.1panel.live 拉取 bun 镜像
FROM docker.1panel.live/oven/bun:1.2 AS builder

WORKDIR /build

# 配置 bun/npm 使用国内镜像源（淘宝镜像）
ENV BUN_CONFIG_REGISTRY=https://registry.npmmirror.com
ENV NPM_CONFIG_REGISTRY=https://registry.npmmirror.com

# 拷贝依赖配置和 bun 配置
COPY restored-src/package.json ./
COPY restored-src/bunfig.toml ./

# 安装依赖（忽略可选/私有包的失败）
RUN bun install --ignore-scripts 2>&1 | tail -5 || true

# 创建本地 stub 包来替代无法安装的私有/Native 包
# @ant/claude-for-chrome-mcp
RUN mkdir -p node_modules/@ant/claude-for-chrome-mcp && \
    echo '{"name":"@ant/claude-for-chrome-mcp","version":"0.0.0","main":"index.js"}' > node_modules/@ant/claude-for-chrome-mcp/package.json && \
    echo 'export default {}; export function createClaudeForChromeMcpServer(){}' > node_modules/@ant/claude-for-chrome-mcp/index.js

# @ant/computer-use-mcp (with sub-modules: sentinelApps, types)
RUN mkdir -p node_modules/@ant/computer-use-mcp && \
    printf '{"name":"@ant/computer-use-mcp","version":"0.0.0","main":"index.js","exports":{".":"./index.js","./sentinelApps":"./sentinelApps.js","./types":"./types.js"}}\n' > node_modules/@ant/computer-use-mcp/package.json && \
    echo 'export default {}; export const API_RESIZE_PARAMS = {}; export const targetImageSize = { width: 1280, height: 800 }; export function bindSessionContext(){}; export const ComputerUseSessionContext = {}; export const CuCallToolResult = {}; export const CuPermissionRequest = {}; export const CuPermissionResponse = {}; export const DEFAULT_GRANT_FLAGS = {}; export const ScreenshotDims = {}; export function buildComputerUseTools(){}; export function createComputerUseMcpServer(){}' > node_modules/@ant/computer-use-mcp/index.js && \
    echo 'export function getSentinelCategory() { return null }' > node_modules/@ant/computer-use-mcp/sentinelApps.js && \
    echo 'export const DEFAULT_GRANT_FLAGS = {}' > node_modules/@ant/computer-use-mcp/types.js

# @ant/computer-use-input
RUN mkdir -p node_modules/@ant/computer-use-input && \
    echo '{"name":"@ant/computer-use-input","version":"0.0.0","main":"index.js"}' > node_modules/@ant/computer-use-input/package.json && \
    echo 'export default {}' > node_modules/@ant/computer-use-input/index.js

# @ant/computer-use-swift
RUN mkdir -p node_modules/@ant/computer-use-swift && \
    echo '{"name":"@ant/computer-use-swift","version":"0.0.0","main":"index.js"}' > node_modules/@ant/computer-use-swift/package.json && \
    echo 'export default {}' > node_modules/@ant/computer-use-swift/index.js

# color-diff-napi (native addon stub)
RUN mkdir -p node_modules/color-diff-napi && \
    echo '{"name":"color-diff-napi","version":"0.0.0","main":"index.js"}' > node_modules/color-diff-napi/package.json && \
    printf 'export function diff() { return 0 }\nexport function rgb2lab() { return {L:0,a:0,b:0} }\n' > node_modules/color-diff-napi/index.js

# modifiers-napi (native addon stub - keyboard modifier keys)
RUN mkdir -p node_modules/modifiers-napi && \
    echo '{"name":"modifiers-napi","version":"0.0.0","main":"index.js"}' > node_modules/modifiers-napi/package.json && \
    echo 'export function isModifierPressed(m) { return false }' > node_modules/modifiers-napi/index.js

# sharp (image processing - optional, stub it)
RUN mkdir -p node_modules/sharp && \
    printf '{"name":"sharp","version":"0.34.0","main":"index.js"}\n' > node_modules/sharp/package.json && \
    printf 'export default function sharp() { throw new Error("sharp not available") }\n' > node_modules/sharp/index.js

# audio-capture-napi (native addon stub)
RUN mkdir -p node_modules/audio-capture-napi && \
    echo '{"name":"audio-capture-napi","version":"0.0.0","main":"index.js"}' > node_modules/audio-capture-napi/package.json && \
    echo 'export function startCapture() {} export function stopCapture() {} export function getAudioData() { return null }' > node_modules/audio-capture-napi/index.js

# 拷贝源码
COPY restored-src/src ./src
COPY restored-src/tsconfig.json ./

# 拷贝 vendor 源码 (原生模块类型定义)
COPY restored-src/vendor ./vendor

# 创建输出目录
RUN mkdir -p dist

# ===== 执行 Bun 编译 =====
# bun:bundle 的 feature() 是 Bun 特有的 bundle-time feature flags
# --target=bun 保留 bun runtime API（bun:bundle, Bun.embeddedFiles 等）
RUN bun build \
    ./src/main.tsx \
    --outfile ./dist/cli.js \
    --target bun \
    --minify-whitespace \
    --minify-syntax \
    --loader .txt:text \
    --loader .md:text \
    --define 'process.env.NODE_ENV="production"' \
    2>&1 | tee /tmp/build.log || (echo "=== BUILD FAILED ===" && cat /tmp/build.log && exit 1)

# 给输出文件加可执行权限
RUN chmod +x ./dist/cli.js && echo "=== Build SUCCESS ===" && ls -lh ./dist/cli.js

# ===== Stage 2: 最终运行镜像 =====
FROM docker.1panel.live/oven/bun:1.2-slim AS runtime

WORKDIR /app

# 从 builder 拷贝编译产物
COPY --from=builder /build/dist/cli.js ./cli.js

# 拷贝 vendor 原生二进制 (ripgrep, audio-capture)
COPY package/vendor ./vendor

# 设置默认入口
ENTRYPOINT ["bun", "run", "/app/cli.js"]
CMD ["--help"]
