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
  version "0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "5ad4a85eaac901bad688207ca0f7a7f7a9123548ccc33549c34b22cabe098a44"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "8e0c33e611476802cd57b2b73212cac608f1b6f730aa08edf0daa673b40a5d5d"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "19aa002ac32be4021f8271e3375db69fb8303d03a0ffbd8a67a427fe7e15a7e0"
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
