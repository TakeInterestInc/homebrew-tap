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
  version "0.2.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.7/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "17691b8f82c2a9179f6560eddbec8039ee32af65092ec90c6e559222a33a26fb"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.7/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "75d6d2d4b2d1e02b6bda1d8d207b72cd09d645e4022918f7310fca8489398e2b"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.7/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "f66bb80a03d1a074c9ad7222f3f0149c0674d2758f07b5c000e8cb2be8b3ada7"
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
