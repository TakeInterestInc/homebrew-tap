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
  version "0.6.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "da5e9d89387699beaceb042d0afd665fb8dcdae082d555bfc6a8d24e9c5e30bf"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "b9f493904fc14428c9925a3436de468e299e840706b1e0b7611d1d058e8e8818"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "ed418a4cd561d720a4031df431308d332f41b98c11f71fbec85c29088f719ce1"
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
