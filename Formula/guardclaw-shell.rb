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
  version "0.2.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.9/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "7280a2652d41ac3fa1ca010f54924d03051beba8c9c544a793d740cbb3617384"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.9/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "70b7ae0b630adb215b27b74a0df4f575d12bf6db23ffbd96e6f9a3c5d2dc10ec"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.9/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "b8208fec090c1048d112bf0fdebc2f3ca52305bb88194f306c0cff56236ec60d"
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
