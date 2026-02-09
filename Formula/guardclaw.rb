# typed: false
# frozen_string_literal: true

# GuardClaw - Security-first AI agent protection
# https://github.com/TakeInterestInc/agent-guardian
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class Guardclaw < Formula
  desc "Policy enforcement for AI agents - 7-layer defense architecture"
  homepage "https://github.com/TakeInterestInc/agent-guardian"
  license :cannot_represent
  version "0.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-darwin-arm64.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-darwin-amd64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-linux-amd64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "guardclaw"
  end

  test do
    assert_match "guardclaw", shell_output("#{bin}/guardclaw --version 2>&1", 0)
  end
end
