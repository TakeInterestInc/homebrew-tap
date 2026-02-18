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
  version "0.2.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.7/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "ae88587c1c84292c84cd99c05436131fae2681985814060817c4940644629a15"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.7/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "e726833172b52b9e706999cb9a39194877d757a1f2da3307346f610329a2b254"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.7/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "55b1577c04b21403c4b038bba731d915970a6e820c9596d8e0515e52e437fb24"
  end

  def install
    bin.install "guardclaw-mcp"
  end

  test do
    assert_match "guardclaw-mcp", shell_output("#{bin}/guardclaw-mcp --version 2>&1", 0)
  end
end
