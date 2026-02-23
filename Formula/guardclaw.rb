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
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-darwin-arm64.tar.gz"
      sha256 "6059a5b523ed38baf9eb0b89ae854ae896f80d5c58d469469f4f98a384a2db75"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-darwin-amd64.tar.gz"
      sha256 "92101d339cbdc0ed909465002dbf5cd21dd81f14fecb140b2556c8436d85798f"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-linux-amd64.tar.gz"
    sha256 "17346df1e3b8462c6a22fdb94292b4cec8926fe4859fb5470b934dc7144a516b"
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
