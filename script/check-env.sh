#!/usr/bin/env bash
# 检查 ~/.vim 配置运行所需的编辑器、插件和外部依赖。
# 用法:
#   script/check-env.sh
#   script/check-env.sh --network       # 额外检查 GitHub SSH 和 npm 镜像
#   script/check-env.sh --require-neovim
#   VIM_ROOT=/path/to/.vim script/check-env.sh

set -u

VIM_ROOT="${VIM_ROOT:-$HOME/.vim}"
NETWORK_CHECK=0
REQUIRE_NEOVIM=0

for arg in "$@"; do
  case "$arg" in
    --network) NETWORK_CHECK=1 ;;
    --require-neovim) REQUIRE_NEOVIM=1 ;;
    -h|--help)
      sed -n '2,9p' "$0"
      exit 0
      ;;
    *)
      echo "未知参数: $arg" >&2
      exit 2
      ;;
  esac
done

if [[ -t 1 ]]; then
  C_RED=$'\033[31m'
  C_GREEN=$'\033[32m'
  C_YELLOW=$'\033[33m'
  C_BLUE=$'\033[34m'
  C_BOLD=$'\033[1m'
  C_RESET=$'\033[0m'
else
  C_RED=''
  C_GREEN=''
  C_YELLOW=''
  C_BLUE=''
  C_BOLD=''
  C_RESET=''
fi

REQUIRED_MISSING=()
OPTIONAL_MISSING=()
WARNINGS=()

section() {
  printf '\n%s===== %s =====%s\n' "$C_BOLD$C_BLUE" "$1" "$C_RESET"
}

ok() {
  printf '%s[OK]%s %s\n' "$C_GREEN" "$C_RESET" "$1"
}

warn() {
  printf '%s[WARN]%s %s\n' "$C_YELLOW" "$C_RESET" "$1"
  WARNINGS+=("$1")
}

missing_required() {
  printf '%s[MISS]%s %s\n' "$C_RED" "$C_RESET" "$1"
  REQUIRED_MISSING+=("$1")
}

missing_optional() {
  printf '%s[OPT]%s %s\n' "$C_YELLOW" "$C_RESET" "$1"
  OPTIONAL_MISSING+=("$1")
}

info() {
  printf '[INFO] %s\n' "$1"
}

has_cmd() {
  command -v "$1" >/dev/null 2>&1
}

with_timeout() {
  if has_cmd timeout; then
    timeout 12 "$@"
  elif has_cmd gtimeout; then
    gtimeout 12 "$@"
  else
    "$@"
  fi
}

check_required_cmd() {
  local cmd="$1"
  local label="$2"
  if has_cmd "$cmd"; then
    local path
    path="$(command -v "$cmd")"
    ok "$label: $path"
  else
    missing_required "$label: 未安装 ($cmd)"
  fi
}

check_optional_cmd() {
  local cmd="$1"
  local label="$2"
  if has_cmd "$cmd"; then
    ok "$label: $(command -v "$cmd")"
  else
    missing_optional "$label: 未安装 ($cmd)"
  fi
}

check_dir() {
  local path="$1"
  local label="$2"
  if [[ -d "$path" ]]; then
    ok "$label: $path"
  else
    missing_required "$label: 目录不存在 ($path)"
  fi
}

check_file() {
  local path="$1"
  local label="$2"
  if [[ -f "$path" ]]; then
    ok "$label: $path"
  else
    missing_required "$label: 文件不存在 ($path)"
  fi
}

section "配置路径"
info "VIM_ROOT=$VIM_ROOT"
if [[ -d "$VIM_ROOT" ]]; then
  ok "配置目录存在"
else
  missing_required "配置目录不存在: $VIM_ROOT"
fi
check_file "$VIM_ROOT/.vimrc" "Vim 主配置"
check_file "$VIM_ROOT/init.lua" "Neovim 主入口"
check_file "$VIM_ROOT/init.vim" "Neovim 兼容入口"
check_file "$VIM_ROOT/autoload/plug.vim" "vim-plug"
check_dir "$VIM_ROOT/configs/vim" "Vim 配置目录"
check_dir "$VIM_ROOT/configs/neovim" "Neovim 配置目录"
check_file "$VIM_ROOT/coc-settings.json" "COC 配置"

if has_cmd python3; then
  if python3 -m json.tool "$VIM_ROOT/coc-settings.json" >/dev/null 2>&1; then
    ok "coc-settings.json JSON 语法"
  else
    missing_required "coc-settings.json JSON 语法无效"
  fi
else
  missing_required "python3: 无法校验 coc-settings.json"
fi

section "编辑器"
HAS_EDITOR=0
if has_cmd vim; then
  HAS_EDITOR=1
  VIM_VERSION="$(vim --version 2>/dev/null | head -1)"
  ok "Vim: $VIM_VERSION"
  VIM_FEATURES="$(vim --version 2>/dev/null)"
  for feature in '+job' '+terminal' '+syntax' '+autocmd'; do
    if grep -q -- "$feature" <<<"$VIM_FEATURES"; then
      ok "Vim feature $feature"
    else
      missing_required "Vim feature $feature"
    fi
  done
  if grep -q -- '+clipboard' <<<"$VIM_FEATURES"; then
    ok "Vim feature +clipboard"
  else
    info "Vim 未编译 +clipboard（当前配置有意使用终端 Ctrl+Shift+C/V）"
  fi
  if grep -q -- '+python3' <<<"$VIM_FEATURES"; then
    ok "Vim feature +python3"
  else
    warn "Vim 未编译 +python3（会影响部分 Python provider 功能）"
  fi
else
  info "Vim: 未安装"
fi

if has_cmd nvim; then
  HAS_EDITOR=1
  ok "Neovim: $(nvim --version | head -1)"
else
  if [[ "$REQUIRE_NEOVIM" -eq 1 ]]; then
    missing_required "Neovim: 未安装（--require-neovim）"
  else
    info "Neovim: 未安装（本机可先只使用 Vim）"
  fi
fi

if [[ "$HAS_EDITOR" -eq 0 ]]; then
  missing_required "至少需要安装 Vim 或 Neovim"
fi

section "基础依赖"
check_required_cmd git "Git"
check_required_cmd curl "curl"
check_required_cmd ssh "SSH 客户端"
check_required_cmd python3 "Python 3"
check_required_cmd fzf "fzf"
check_required_cmd rg "ripgrep"

section "Node.js / npm"
NODE_BIN=''
NPM_BIN=''
NPX_BIN=''
# 配置中优先使用 ~/.local/opt/node/bin，其次使用 PATH 中的 node
if [[ -x "$HOME/.local/opt/node/bin/node" ]]; then
  export PATH="$HOME/.local/opt/node/bin:$PATH"
fi
if has_cmd node; then
  NODE_BIN="$(command -v node)"
  ok "Node.js: $("$NODE_BIN" --version) ($NODE_BIN)"
  NODE_MAJOR="$("$NODE_BIN" -p "Number(process.versions.node.split('.')[0])" 2>/dev/null || echo 0)"
  if [[ "$NODE_MAJOR" -ge 18 ]]; then
    ok "Node.js 主版本满足要求 (>=18)"
  else
    missing_required "Node.js 版本过旧，当前 $("$NODE_BIN" --version)，建议 >=20"
  fi
else
  missing_required "Node.js: 未安装"
fi

if has_cmd npm; then
  NPM_BIN="$(command -v npm)"
  ok "npm: $("$NPM_BIN" --version) ($NPM_BIN)"
else
  missing_required "npm: 未安装"
fi

if has_cmd npx; then
  NPX_BIN="$(command -v npx)"
  ok "npx: $("$NPX_BIN" --version) ($NPX_BIN)"
else
  missing_optional "npx: 未安装"
fi

if has_cmd yarn; then
  ok "yarn: $(yarn --version)"
else
  missing_optional "yarn: 未安装（当前配置不再需要）"
fi

section "C/C++ / clangd"
check_required_cmd clangd "clangd 语言服务器"
if has_cmd clangd; then
  info "clangd: $(clangd --version | head -1)"
fi
check_required_cmd gcc "GCC"
check_required_cmd g++ "G++"
if has_cmd ccls; then
  ok "ccls: $(command -v ccls)（当前配置不依赖）"
else
  info "ccls: 未安装（当前配置已切换到 clangd，不需要）"
fi
check_optional_cmd cscope "cscope"
if has_cmd ctags; then
  CTAGS_PATH="$(command -v ctags)"
  CTAGS_VERSION="$(ctags --version 2>/dev/null | head -1)"
  ok "ctags: ${CTAGS_VERSION:-$CTAGS_PATH}"
else
  missing_required "ctags: 未安装（Tagbar/F9 需要）"
fi

section "插件目录"
PLUGGED="$VIM_ROOT/plugged/vim-plug"
COC_EXT="$VIM_ROOT/plugged/coc/extensions/node_modules"
if [[ -d "$PLUGGED" ]]; then
  ok "vim-plug 插件目录: $PLUGGED"
else
  missing_required "vim-plug 插件目录不存在: $PLUGGED"
fi

REQUIRED_PLUGINS=(
  vim-plug vim-airline vim-rainbow nerdtree nerdtree-git-plugin tagbar
  asyncrun.vim ale coc.nvim fzf fzf.vim markdown-preview.nvim
  mathjax-support-for-mkdp vim-table-mode undotree
)
for plugin in "${REQUIRED_PLUGINS[@]}"; do
  if [[ -d "$PLUGGED/$plugin" ]]; then
    ok "插件 $plugin"
  else
    missing_required "插件未安装: $plugin"
  fi
done

if has_cmd nvim; then
  for plugin in sotte/presenting.nvim nvim-treesitter nvim-treesitter-context; do
    name="${plugin##*/}"
    [[ "$name" == "presenting.nvim" ]] && name="presenting.nvim"
    if [[ -d "$PLUGGED/$name" ]]; then
      ok "Neovim 插件 $name"
    else
      missing_optional "Neovim 插件未安装: $name"
    fi
  done
  check_optional_cmd tree-sitter "tree-sitter CLI（nvim-treesitter 可选）"
fi

if [[ -d "$PLUGGED/glow.vim" ]]; then
  ok "插件 glow.vim"
elif has_cmd glow; then
  missing_optional "插件 glow.vim: glow 已安装但插件目录缺失"
else
  info "glow.vim 未安装（当前没有 glow 命令）"
fi

section "COC 扩展"
if [[ -d "$COC_EXT" ]]; then
  ok "COC 扩展目录: $COC_EXT"
  for ext in coc-json coc-tsserver coc-vimlsp coc-snippets coc-clangd coc-pyright; do
    if [[ -d "$COC_EXT/$ext" ]]; then
      ok "COC 扩展 $ext"
    else
      missing_required "COC 扩展未安装: $ext"
    fi
  done
else
  missing_required "COC 扩展目录不存在: $COC_EXT"
fi

section "npm registry"
NPMRC="$HOME/.npmrc"
if [[ -f "$NPMRC" ]]; then
  if grep -Eq '^registry=https://registry\.npmmirror\.com/?' "$NPMRC"; then
    ok "npm registry: npmmirror"
  else
    warn "~/.npmrc 未配置全局 npmmirror registry"
  fi
  if grep -Eq '^coc\.nvim:registry=https://registry\.npmmirror\.com/?' "$NPMRC"; then
    ok "COC registry: npmmirror"
  else
    warn "~/.npmrc 未配置 coc.nvim registry"
  fi
else
  warn "~/.npmrc 不存在"
fi

section "Conda / Python 环境"
CONDA_BIN=''
if has_cmd conda; then
  CONDA_BIN="$(command -v conda)"
elif [[ -x /opt/miniconda/bin/conda ]]; then
  CONDA_BIN=/opt/miniconda/bin/conda
elif [[ -x "$HOME/miniconda3/bin/conda" ]]; then
  CONDA_BIN="$HOME/miniconda3/bin/conda"
fi

if [[ -n "$CONDA_BIN" ]]; then
  ok "Conda: $("$CONDA_BIN" --version) ($CONDA_BIN)"
  info "Conda environments:"
  "$CONDA_BIN" env list 2>/dev/null | sed 's/^/  /'
else
  missing_optional "Conda: 未安装（RunPython 会回退到 python3）"
fi

if has_cmd python3; then
  ok "python3: $(python3 --version 2>&1) ($(command -v python3))"
else
  missing_required "python3: 未安装"
fi
if has_cmd pip3; then
  ok "pip3: $(pip3 --version 2>&1 | head -1)"
else
  missing_optional "pip3: 未安装"
fi

section "可选插件依赖"
check_optional_cmd glow "glow（Glow Markdown 预览）"
check_optional_cmd ag "ag（:Ag 搜索，已有 rg）"
check_optional_cmd latexmk "latexmk（LaTeX 编译）"
check_optional_cmd xelatex "xelatex（中文 LaTeX）"
check_optional_cmd zathura "zathura（PDF 预览）"
check_optional_cmd firefox "Firefox（HTML/Markdown 预览）"
check_optional_cmd chromium "Chromium（HTML/Markdown 预览）"
check_optional_cmd live-server "live-server（WebDev）"
check_optional_cmd browser-sync "browser-sync（WebDev）"
check_optional_cmd nvcc "nvcc（CUDA 编译）"

if has_cmd nvidia-smi; then
  info "NVIDIA GPU: $(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | head -1)"
  info "Compute capability: $(nvidia-smi --query-gpu=compute_cap --format=csv,noheader 2>/dev/null | head -1)"
else
  info "NVIDIA GPU: 未检测到 nvidia-smi"
fi

if [[ "$NETWORK_CHECK" -eq 1 ]]; then
  section "网络检查"
  if with_timeout ssh -T -o BatchMode=yes -o StrictHostKeyChecking=accept-new git@github.com >/tmp/vim-env-ssh.$$ 2>&1; then
    ok "GitHub SSH 可用"
  else
    if grep -q 'successfully authenticated' /tmp/vim-env-ssh.$$ 2>/dev/null; then
      ok "GitHub SSH 可用（GitHub 不提供 shell）"
    else
      missing_required "GitHub SSH 不可用: $(tail -1 /tmp/vim-env-ssh.$$ 2>/dev/null)"
    fi
  fi
  if has_cmd curl; then
    if with_timeout curl -IL -sS -o /dev/null https://registry.npmmirror.com/coc-json; then
      ok "npmmirror registry 可访问"
    else
      missing_optional "npmmirror registry 无法访问"
    fi
  fi
  rm -f /tmp/vim-env-ssh.$$
fi

section "汇总"
if [[ ${#REQUIRED_MISSING[@]} -eq 0 ]]; then
  printf '%s所有必需依赖均已安装。%s\n' "$C_GREEN" "$C_RESET"
else
  printf '%s必需依赖缺失: %d 项%s\n' "$C_RED" "${#REQUIRED_MISSING[@]}" "$C_RESET"
  printf '  - %s\n' "${REQUIRED_MISSING[@]}"
fi

if [[ ${#OPTIONAL_MISSING[@]} -gt 0 ]]; then
  printf '\n%s可选依赖缺失: %d 项%s\n' "$C_YELLOW" "${#OPTIONAL_MISSING[@]}" "$C_RESET"
  printf '  - %s\n' "${OPTIONAL_MISSING[@]}"
fi

if [[ ${#WARNINGS[@]} -gt 0 ]]; then
  printf '\n警告: %d 项\n' "${#WARNINGS[@]}"
  printf '  - %s\n' "${WARNINGS[@]}"
fi

if [[ ${#REQUIRED_MISSING[@]} -eq 0 ]]; then
  exit 0
fi
exit 1
