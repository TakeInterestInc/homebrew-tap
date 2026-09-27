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
  version "0.7.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "bae52fe50bfff56cf206174744cdcd9a7b04a5b6a37e935fa7d660a16df6a2c9"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "f6be90d210f2a486dc48cc9d01a2888119ad27d26339f5ce712bb968b6b9c3ef"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "2e0608f50b54d8b5742b3b5345c298668db2ec4280c8249c96ad79afde28b2c9"
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
