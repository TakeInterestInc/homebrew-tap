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
  version "0.6.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-darwin-arm64.tar.gz"
      sha256 "a923e9b244295ebf052830afcc0fd20e22b462e6269a8d008134ef37d0a01caa"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-darwin-amd64.tar.gz"
      sha256 "5c0846882b0b1b211aceffe9cce52955eb1c21040b636080dffae38a875dc461"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-linux-amd64.tar.gz"
    sha256 "15ef0581d1d2b155922ccdaf237b087eeca30e366e11fa44d17f9c0f0ea4813f"
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
