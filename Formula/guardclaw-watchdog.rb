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
  version "0.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "cce1ba77f4d548b271fd3808c8b5c8ae09c50d9312ff7fe76d50a8097d21ff53"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "9e4465be9d0558932419e41c0322959410810d2c6856f23f863e2d21902d56af"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "7a6b0e0599c87e654ef61d4444dca60b0288225960d55ebe6842689b9127a9af"
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
