# typed: false
# frozen_string_literal: true

# GuardClaw MCP Gateway - MCP protocol proxy with policy enforcement
# https://guardclaw.com
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class GuardclawMcp < Formula
  desc "MCP gateway proxy for AI agent security - JSON-RPC 2.0 over stdio"
  homepage "https://guardclaw.com"
  license :cannot_represent
  version "0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "0bbe5d9adfa78d86e15c0a9b33ed69c9ed64d4f97b73c549ef73e4c0cd513715"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "8fc19abffcb4122f0136ba11c0583e5a8f73b0d3b73afedfdf79d4fc26d3023d"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "d91fde19f0d4b8bebf4fa853cb8e0c593f51a5461c7a3b92adfc678b2eb4ff78"
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
