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
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "a1fe1cd4937c0c08b42564b54e2e9ab7047dd92708db025b1860e14e014c5320"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "710a0a5ae8cf05d0c91c5c1751c64e809c4d81c0dab3f9faa7c109031891a73b"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "07b031106d6edbeedcd8352658d9be53f0d3ad94bce058fa5addeda00c0a64e6"
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
