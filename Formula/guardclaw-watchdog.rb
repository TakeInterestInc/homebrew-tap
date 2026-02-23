# typed: false
# frozen_string_literal: true

# GuardClaw Watchdog - Process health monitoring for GuardClaw agents
# https://guardclaw.dev
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class GuardclawWatchdog < Formula
  desc "Process watchdog for GuardClaw AI agent protection"
  homepage "https://guardclaw.dev"
  license :cannot_represent
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
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
