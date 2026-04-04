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
  version "0.6.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "816fb81302f207b1c5f5e71f572cadea9a0e89b3e88a7fc4119950de024a81fb"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "c2df6624067b35497ce38cfdaca33c663e4f86b119a4517a82233be437e091b0"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "98a60f91fe0b6f278b06fc1a06ffd824163bb5849f252a871643d4e561480439"
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
