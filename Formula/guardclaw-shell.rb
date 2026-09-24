# typed: false
# frozen_string_literal: true

# GuardClaw Shell Wrapper - deny-by-default shell execution filter
# https://guardclaw.com
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class GuardclawShell < Formula
  desc "Deny-by-default shell wrapper for AI agent security"
  homepage "https://guardclaw.com"
  license :cannot_represent
  version "0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "9ea4935d6795d41289973b435921830d91303d1d461a0d160594e79e7c731cd7"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "608ef34109d808cbcd608aac8cfaf7c6df82775407e7cba3841fd19cf04405de"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "394e3411f1a5497238cb83b668a3939dd100386f0cc670f2865a715606ee6fd1"
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
