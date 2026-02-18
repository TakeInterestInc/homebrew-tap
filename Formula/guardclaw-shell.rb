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
  version "0.2.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "9302e5e132c95349f66a5611416ffb2ed254e703f9907cf345c78a78d42f9b2e"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "c2ae0ef87d8c2e9bd13c14976d5d3cf1b19a825656ea68eacfc62626326e9d71"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "93968416c2d7f1e6b537e3f8996dd88221853a0a180de2608bb212a1a504afbe"
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
