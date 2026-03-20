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
  version "0.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-darwin-arm64.tar.gz"
      sha256 "736afd4fdffbc1f74d84bc774fa3f80647cd91f865084a503532bd49c20ab238"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-darwin-amd64.tar.gz"
      sha256 "bb79641768411693978c42a48009427a6d28ed81a963cb8bc82130286c0efe6b"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.1/guardclaw-linux-amd64.tar.gz"
    sha256 "a9c3725dc1e421f9f783d07d6f9f4ccea3367e0190129a3834c63eb69aca6b44"
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
