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
  version "0.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v0.2.1/guardclaw-darwin-arm64.tar.gz"
      sha256 "c883170dd648409f0f4625961cc11a39866109457e6cfdb4711fd823adbd4242"
    else
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v0.2.1/guardclaw-darwin-amd64.tar.gz"
      sha256 "0a5fdc41074f789dcf70b96c9baaca47a3e708f23a53ab2e3c28dbf2139682c9"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v0.2.1/guardclaw-linux-amd64.tar.gz"
    sha256 "098c866bb8eb7f7e972e8826c89687ee243d8b1d148d9709d68d75e15c6f3e54"
  end

  def install
    bin.install "guardclaw"
  end

  test do
    assert_match "guardclaw", shell_output("#{bin}/guardclaw --version 2>&1", 0)
  end
end
