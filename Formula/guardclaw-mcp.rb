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
  version "0.2.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.9/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "e0c471ec2adeacc2867b06d078d6023e8bb7ae4e57d38b52239f8d4303e2219f"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.9/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "9e6ad1788737504eb915727c6899f4df6296ea17a5639107859f12b429cd89e1"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.9/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "44ca4a1c53136f0516e8df917a7b212ea74876e43998c6289c012fba2279ff8d"
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
