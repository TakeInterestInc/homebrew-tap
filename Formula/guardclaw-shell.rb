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
  version "0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "ed781118601c62d0891e6790805ce8fed74b19de997b182722c5b9d3099ccf08"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "142080658bc639cdc709abdf17d735cb30f813eecf346f1465cffd4a2a60887a"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "8f02c2005c4e34e3d95811ce9660e9f3815de5ab299fcf2969c7081139369462"
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
