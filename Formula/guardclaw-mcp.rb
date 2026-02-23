# typed: false
# frozen_string_literal: true

# GuardClaw MCP Gateway - MCP protocol proxy with policy enforcement
# https://guardclaw.dev
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class GuardclawMcp < Formula
  desc "MCP gateway proxy for AI agent security - JSON-RPC 2.0 over stdio"
  homepage "https://guardclaw.dev"
  license :cannot_represent
  version "0.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "fd6083ff5aee957fca499756b5e87b1a7e640836be70dc32cd114fe52e437eb5"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "18a78208687d3404d3d71fbe863cdcd3e513723e1f467d15ac6dccb7667a9702"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "4c571aeeafa6bc02190519d77a7bfca8afc4b04045657525bdc2747756fd0620"
  end

  def install
    Dir["guardclaw-mcp-*"].each do |f|
      bin.install f => "guardclaw-mcp"
    end
  end

  test do
    assert_match "guardclaw-mcp", shell_output("#{bin}/guardclaw-mcp --version 2>&1", 0)
  end
end
