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
  version "0.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "d60cfc13925655b3498f90e6e169430a50200484067137b24fe0c95eb1217039"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "2d979fb509c7754450959855bc1a8e34f843c76f526bf12f0fc355c1dfbe030e"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "d59337cc868d5a9e17c96cf7f35b3a7d8fec1c1271f04a1db2e07709807eec11"
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
