# TakeInterest Homebrew Tap

Install [GuardClaw](https://github.com/TakeInterestInc/agent-guardian) and related tools via Homebrew.

## Usage

```bash
brew tap TakeInterestInc/tap
brew install guardclaw
```

## Available Formulae

| Formula | Description |
|---------|-------------|
| `guardclaw` | Policy enforcement for AI agents - 7-layer defense architecture |
| `guardclaw-mcp` | MCP gateway proxy for AI agent security |
| `guardclaw-shell` | Deny-by-default shell wrapper for AI agents |

## Install All

```bash
brew tap TakeInterestInc/tap
brew install guardclaw guardclaw-mcp guardclaw-shell
```

## Verify Installation

```bash
guardclaw --version
```
