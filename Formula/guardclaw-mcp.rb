# typed: false
# frozen_string_literal: true

# GuardClaw MCP Gateway - MCP protocol proxy with policy enforcement
# https://github.com/TakeInterestInc/agent-guardian

class GuardclawMcp < Formula
  desc "MCP gateway proxy for AI agent security - JSON-RPC 2.0 over stdio"
  homepage "https://github.com/TakeInterestInc/agent-guardian"
  license :cannot_represent
  version "0.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-mcp-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-mcp-linux-amd64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "guardclaw-mcp"
  end

  test do
    assert_match "guardclaw-mcp", shell_output("#{bin}/guardclaw-mcp --version 2>&1", 0)
  end
end
