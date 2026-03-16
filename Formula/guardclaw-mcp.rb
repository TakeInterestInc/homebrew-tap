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
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "85c54243cd8037f8d18f8939c7ec9c360905d63f47fe7730e0475341faf70e89"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "a4d3f251ef5871685ec82ddeb2fa991b5fd2ee07c4ddd8639302d9c32573583f"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "58a7e3d5b04600fb0a65229da1de9165a72b5c5458804ef0b4923911c9080c7a"
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
