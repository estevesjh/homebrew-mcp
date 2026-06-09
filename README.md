# homebrew-mcp

Homebrew tap for MCP (Model Context Protocol) servers.

## Install

```bash
brew tap estevesjh/mcp
brew install mcp-ads-arxiv
```

## Available formulas

| Formula | Description |
|---------|-------------|
| `mcp-ads-arxiv` | Read scientific papers from LaTeX source via NASA ADS + arXiv |

## After install

```bash
export ADS_API_TOKEN="your-token"   # https://ui.adsabs.harvard.edu/user/settings/token
export LIT_CACHE_DIR="$HOME/.local/share/mcp-ads-arxiv"
claude mcp add --scope user mcp-ads-arxiv -- mcp-ads-arxiv
```
