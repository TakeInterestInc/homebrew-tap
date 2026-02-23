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
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-darwin-arm64.tar.gz"
      sha256 "eb28b424ba68d5e91f1dd47da80f112934d13c341b85aedd6c6945c978f3b6d7"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-darwin-amd64.tar.gz"
      sha256 "1cf7e4f990b70503d75868a79b4b99a5a9a6c0462b813eb8bdb1683ca8cac7a6"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.4.0/guardclaw-linux-amd64.tar.gz"
    sha256 "e0892e6657a9d0cc28c1434615e6a370db4649c160dcf9a0a9a25eccb1992589"
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
