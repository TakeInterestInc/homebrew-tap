# typed: false
# frozen_string_literal: true

# GuardClaw - Security-first AI agent protection
# https://guardclaw.dev
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class Guardclaw < Formula
  desc "Policy enforcement for AI agents - 7-layer defense architecture"
  homepage "https://guardclaw.dev"
  license :cannot_represent
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-darwin-arm64.tar.gz"
      sha256 "fe0bdfb31a1fad48c5daf4e36aa8b1b3631e0b8f75994b186cab27ae5eb02e5c"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-darwin-amd64.tar.gz"
      sha256 "9a0da9d7eade8f1c025ef9cf995f9d02aaf37422d8a340dca5784ab36b58d2b6"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-linux-amd64.tar.gz"
    sha256 "fa6eca041e83e1e4394ab1ddd43bc0d787f9f6beb40d63575d3807465cb691b3"
  end

  def install
    # Binary in tarball is platform-suffixed (e.g. guardclaw-darwin-arm64)
    Dir["guardclaw-*"].each do |f|
      bin.install f => "guardclaw"
    end
  end

  def post_install
    system "#{bin}/guardclaw", "init", "claude-code", "--global"
  end

  test do
    assert_match "guardclaw", shell_output("#{bin}/guardclaw --version 2>&1", 0)
  end
end
