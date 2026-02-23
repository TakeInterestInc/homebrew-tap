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
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "e94b1399d33d526f6e3f7c4b25277630778bb1100feb60c21bf020598738b31a"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "29dc61ca6b592a6b8bb0d54177c4d23d38065a73661ca088ab8d46ea6745f842"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "83c73e87b5fc2e63c5e7f3d341fa9d28ad4243851193f72eccc6b05fbc372257"
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
