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
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "e5dc0436d21e8d65d7a01b4c1ee634af3c879318f53ee1383ccd1c03bc967e4a"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "794d8f00cdfd44080433afe67123dfd7edd89be418bd72e2f7fca39e33dde4f1"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "1cb6771b366c45552236e30f89a24911a2e703041633242a6f2777dd6785e90c"
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
