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
  version "0.7.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-darwin-arm64.tar.gz"
      sha256 "087c3c0cab66a858325a881c11651d1436fd363f96999a07c2b804963edc00b4"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-darwin-amd64.tar.gz"
      sha256 "5d6dcc251707e329ed3741ce32406b26e5839c4ea5247c48c7ca545b69c07449"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-linux-amd64.tar.gz"
    sha256 "36166e67204d2c319bbedee02f8c16d1a94f3e72cabf50c4220a198b68bb31e0"
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
