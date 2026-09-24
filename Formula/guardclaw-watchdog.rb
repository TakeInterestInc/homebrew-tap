# typed: false
# frozen_string_literal: true

# GuardClaw Watchdog - Process health monitoring for GuardClaw agents
# https://guardclaw.com
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class GuardclawWatchdog < Formula
  desc "Process watchdog for GuardClaw AI agent protection"
  homepage "https://guardclaw.com"
  license :cannot_represent
  version "0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "cbffea5f79f587a3a28dcbcd9672d2d5933d35e3ed5ab513ca1be3a234388945"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "2ce2137e2685af0d19e62d0fc250612b92aa378b74a8922e04877753165bdd5b"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "736599668d379336f117a711714e9c498634e24670fca8977978f0f6e6067a1f"
  end

  def install
    # Binary in tarball is platform-suffixed (e.g. guardclaw-watchdog-darwin-arm64)
    Dir["guardclaw-watchdog-*"].each do |f|
      bin.install f => "guardclaw-watchdog"
    end
  end

  test do
    assert_match "guardclaw-watchdog", shell_output("#{bin}/guardclaw-watchdog --version 2>&1", 0)
  end
end
