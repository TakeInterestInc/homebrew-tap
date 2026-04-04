# typed: false
# frozen_string_literal: true

# GuardClaw Shell Wrapper - deny-by-default shell execution filter
# https://guardclaw.com
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class GuardclawShell < Formula
  desc "Deny-by-default shell wrapper for AI agent security"
  homepage "https://guardclaw.com"
  license :cannot_represent
  version "0.6.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "7df371a93c50d2520f2fbc227f959fa43e533a4ea380b1d88445dcea46241863"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "7c7806f3c3b6f16db6bf65f87a761141d172c90490e24cb2688f4de9c97aa6c2"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.6.2/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "82fcfeb726e4b6e8deaa82d212bf7a0ebdf9feb376523cc683ba4a7decd0365c"
  end

  def install
    Dir["guardclaw-shell-*"].each do |f|
      bin.install f => "guardclaw-shell"
    end
  end

  test do
    assert_match "guardclaw-shell", shell_output("#{bin}/guardclaw-shell --version 2>&1", 0)
  end
end
