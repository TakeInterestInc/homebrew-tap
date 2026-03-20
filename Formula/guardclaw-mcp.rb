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
  version "0.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "45b0b45690f7d73bf2f3428b77288472dda2b40c12a00c288a534ca25097ea57"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "cac5643a7770f6f0a858360deb458cb92e8fe8bc9ae1bec5140673f3bb423874"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "c15834183cbb9553c05e1794785405d15df231b20dffb8287e0675cfb5a7c05e"
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
