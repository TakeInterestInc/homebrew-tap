# typed: false
# frozen_string_literal: true

# GuardClaw Shell Wrapper - deny-by-default shell execution filter
# https://guardclaw.dev
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class GuardclawShell < Formula
  desc "Deny-by-default shell wrapper for AI agent security"
  homepage "https://guardclaw.dev"
  license :cannot_represent
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "b2187ed1b40bc2d8867adb243dc8da9c993addd2d78b39cb7919a5400816d5da"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "6938b8f49f9e639f2e098fbb5e193a46a0cd6b214d1bdf8c78ce69045c8677ad"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "b39cbf901814d466f67c708625338187bedafe39a019309c94afb0953c1bcde8"
  end

  def install
    Dir["guardclaw-shell-*"].each do |f|
      bin.install f => "guardclaw-shell"
    end
  end

  test do
    assert_match "guardclaw-shell", shell_output("#{bin}/guardclaw-shell --version 2>&1", 0)
  end
end
