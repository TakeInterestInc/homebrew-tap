# typed: false
# frozen_string_literal: true

# GuardClaw - Security-first AI agent protection
# https://guardclaw.com
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class Guardclaw < Formula
  desc "Policy enforcement for AI agents - 7-layer defense architecture"
  homepage "https://guardclaw.com"
  license :cannot_represent
  version "0.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-darwin-arm64.tar.gz"
      sha256 "d8a2d64754ada6168731ed3abc7981eaf534cb592c54e91b1a9f1c4d966935e0"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-darwin-amd64.tar.gz"
      sha256 "a9ba0a66c323d00f3cc18ac37c11115e2540769475a15ab73236f4584008a509"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.0/guardclaw-linux-amd64.tar.gz"
    sha256 "79c7b14e41b703063dd121178aee45a1202784e4dc40d406537660c9a1c7fb4f"
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
