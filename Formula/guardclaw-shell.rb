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
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "335e161e84207a30e654e6f3c5ee20197e91ea1e175e23e09018524c6cae7a17"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "74c681df4030ce9790a330289f9766fa17a9705610411733ae99e64daa7241d0"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "1d7a9629d5084cb1d968437e4e668caea97d5ef5daa97d64aa5d3e176b8aaf84"
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
