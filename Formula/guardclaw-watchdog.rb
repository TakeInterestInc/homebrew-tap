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
  version "0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "18427c6edbb934fcf0f346c580b0276f0af06725912d03c3da3ffd2495d2dfeb"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "5d614ad2317689a3deb40e84de9596b3f44c92ff552ed9280339ba3ab216c6c6"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "9262944409557f9d0bc19ab608c007595cca8e2e68aef8aa6b2b9010015499a9"
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
