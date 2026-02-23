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
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-mcp-darwin-arm64.tar.gz"
      sha256 "4c88e98e9d8eea8b5bcf4e1341859e2f41e9ca15b8987bacf75a174362737886"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-mcp-darwin-amd64.tar.gz"
      sha256 "af48062db4f7e164ade5a54fb756cced46b13114091675295038814ddf4d9799"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-mcp-linux-amd64.tar.gz"
    sha256 "b4250f3a37ac544d3c663ddb10feb9b91c604611bf9629e80ee869e4ff94dc88"
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
