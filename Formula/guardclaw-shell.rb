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
  version "0.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "df973fe8c01f8be6ce90c1425aa10de2267696df7bd4810bc759ef915db71e1e"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "dfffec8ab3cfe6079057658f9b4bc882e5e86d2c307cd023ff58262f401cc60f"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "29acd6d697f6ccc28edb2054a2c931dbf98930174a9a34138180ea52a886602c"
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
