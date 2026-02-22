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
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "0475b330c8ec0c1d02eb8c680eba6a68f3b0a8538d072166d899e18ca16651c9"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "854e60d1227a0d04836d4dfb090defe80d1e1d031ce4fad127923882ae9d83f6"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "e41b647d22947b26763485490660cb60784b7dd792cf95a716dab098226c7ec4"
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
