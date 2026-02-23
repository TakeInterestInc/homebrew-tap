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
  version "0.3.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-darwin-arm64.tar.gz"
      sha256 "4b7bacf4d4d1328439fa4eed0af80f0d56a4cd1ca7d366128042781295f2637b"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-darwin-amd64.tar.gz"
      sha256 "2fb928bdac7523303cd05bf4a625fed0147b54d2d3753d4da8239831e0ce78ee"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.2/guardclaw-linux-amd64.tar.gz"
    sha256 "1c4fcd4e9b165916f440b4e42ad64ec0e5d4a48c742331b4db7cd7e7cd80d901"
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
