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
  version "0.2.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-darwin-arm64.tar.gz"
      sha256 "d831cc08e3f8cca17949613dfedb6d874085fddd06e22b07dbb985ff3114387c"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-darwin-amd64.tar.gz"
      sha256 "107fec37458a1cfd17a7a052493c99325a9eaba08c25e97ff1f0e5ae3a23f67f"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-linux-amd64.tar.gz"
    sha256 "ab755d9e085a179d620ab8039e23ec2e3588cbde7329bb847cf9559603a6dc80"
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
