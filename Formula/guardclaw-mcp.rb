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
  version "0.2.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "18cbe0c369730733f695f48813d553f3a59ec7209ac2a207cf2e59e30d2e4aa4"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "72d33e59ab8095aeca2fc982f6aaf4703f92f56c988934de25741d5879c895f4"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "a592384c7a48c3de384096004d5fbbade0e2098abf63b009768bfe9d797c1914"
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
