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
  version "0.7.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "a394bef11c6da227812303085194f9826789c92fb090939a473398e9148481b6"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "4323370224136a910c337d06ab62cfcc08ef09f51485894e0e43aacec7df4444"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "d53784635adeb91c56b52fa6655598ba94c8b69d114e941fd18817579feb1a5b"
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
