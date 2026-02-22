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
  version "0.2.9"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.9/guardclaw-darwin-arm64.tar.gz"
      sha256 "776f2f4fd4930bc72d30ee43477bf6b16e766000f2440edf940972df7e7f6cdf"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.9/guardclaw-darwin-amd64.tar.gz"
      sha256 "f3cd8e39d9b64b16fe6e7902398b816489d96ecbacbb7eb5ecc48e1f8ca83bfc"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.9/guardclaw-linux-amd64.tar.gz"
    sha256 "d981747cbcb8917e76d91a2e7d9ef614bedf582fd9089faeae1d1d500a081915"
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
