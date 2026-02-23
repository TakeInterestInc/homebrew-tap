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
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "ce99f61f3124135766c64e8043ee07c1bce4099b05e2950a1d161a4a45b4169a"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "35aff741ee066b2651960f9b28be205e02b67257c8d8de29784d38a3c8f4349d"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "176b88c58e755b517d589d8c45017501104e59f451bf2c7717ed8cc9836b45b1"
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
