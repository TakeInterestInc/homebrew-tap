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
  version "0.2.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.7/guardclaw-darwin-arm64.tar.gz"
      sha256 "1bb7a5671403dd6fdd85c9ba53918dc584abe2016b17c7cb9460abc604e07997"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.7/guardclaw-darwin-amd64.tar.gz"
      sha256 "8ddf86c2af349076005832900e6a49c9baa4ccd236aae4275cf0bf28ba082bd7"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.2.7/guardclaw-linux-amd64.tar.gz"
    sha256 "aa350e64a39aa47fd784765fc42fd4804bd42cfa176151d75e3992a1b03804af"
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
