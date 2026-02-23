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
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-watchdog-darwin-arm64.tar.gz"
      sha256 "caf5749b61ae148ca29c41a60ef04620a49742d98361c3dafaf0cf5abc0c9d18"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-watchdog-darwin-amd64.tar.gz"
      sha256 "b5c3d032a00e79915312f402b528529d21c65544e6862de347cfef26f2a76096"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-watchdog-linux-amd64.tar.gz"
    sha256 "b320029bfeb02abfdc06402b680d9e532df0924acdcf7e384f3b02a975317670"
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
