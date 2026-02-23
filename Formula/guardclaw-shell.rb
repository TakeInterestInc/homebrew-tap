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
  version "0.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "034388a714f9479cabfb984eea4284a0a3b6c30256a585f75b4cca5bbb0697df"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "718011073c00dea64e2d67c26f1885bfe58dd71ce0a11eb38d5ad70cbe9eaa6b"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "f8a74ea2ed1fd3e367cf0d0f9f7239f416a6aa7d5e5d750eec1075bb93d955c0"
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
