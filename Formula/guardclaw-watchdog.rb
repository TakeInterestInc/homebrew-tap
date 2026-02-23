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
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "4151063c5de63d62ab5cdfd058147b26cfa4853ca94bdf1ecaf50d3181afe481"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "943bba311e05c7e3f419feb192804f4055c304303cd0e0b380af51b0adf97b88"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "0d3a4b707ab7bf4425c92ae6df1ae35fa43fe03ec39819a4b4382ae8ae5a76ac"
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
