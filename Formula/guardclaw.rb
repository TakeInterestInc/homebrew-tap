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
  version "0.5.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-darwin-arm64.tar.gz"
      sha256 "2555e53a350e6035312d8c217ab9db48981fdbc83c89c515d5ba7b3445f25e8f"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-darwin-amd64.tar.gz"
      sha256 "e5957278236ffbf6d0059b00bdc486b7ec5e55431db4fdef8ffc71124017bc8e"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.1/guardclaw-linux-amd64.tar.gz"
    sha256 "31ccaddff98508a61b6047bcdec549f2d9c2d895d9c469500970a525836232e2"
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
