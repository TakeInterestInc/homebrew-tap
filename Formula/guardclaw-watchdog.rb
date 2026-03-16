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
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "ea950db463cf5a88dc6b46cea2ffde0520366dfb4d983bb2b9aa56ea282bb946"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "55e769b2d20ea6d2c8b3b22e498cd43e90eeeb04e2d059ec0486b8c94af0869a"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "590d60a54b3d3b82eafc441bcfe97b39b2c9d1c94f7baa673ddbf8dfe2e68eac"
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
