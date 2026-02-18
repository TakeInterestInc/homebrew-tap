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
      sha256 "53ecff5d44e3a7133aff90ed961b705bdc051c1d17d33d0b5376d63024b4fd21"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-darwin-amd64.tar.gz"
      sha256 "9b51af5a008447c3a1ca5d95ab67d1237c8c54afa407ac697bd6694d35868a84"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.8/guardclaw-linux-amd64.tar.gz"
    sha256 "02552868f7decfb2225ea751e26e6dac6b4dc66d38e338926f13be6968e2df9f"
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
