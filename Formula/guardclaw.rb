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
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-darwin-arm64.tar.gz"
      sha256 "53b0cdbcccfde72ef05865b43660d215d94c5bb20a997888a2e793197f82a5e4"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-darwin-amd64.tar.gz"
      sha256 "9ebab342e58d1c71c12b7962b5e3bed0f7d82c49ef0254c8de665c26df3f2a17"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.0/guardclaw-linux-amd64.tar.gz"
    sha256 "a813f329aafa1d14405cae1d6242e381b6c27bc1d965ec83df9d148d9be5957d"
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
