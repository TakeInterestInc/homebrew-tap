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
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-darwin-arm64.tar.gz"
      sha256 "9d5235c0c7d518701aa9dcddebc0013b083c52723e53e1b9faa208cead676569"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-darwin-amd64.tar.gz"
      sha256 "5aa680ba3cacd9dd441ad59fde06cb6ae295d22dbd3aad3ccde217e662e669c0"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.1/guardclaw-linux-amd64.tar.gz"
    sha256 "616d970dfc15064b8ce856877ae6b79837f4b2254522e79c438fe7aa12bb0008"
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
