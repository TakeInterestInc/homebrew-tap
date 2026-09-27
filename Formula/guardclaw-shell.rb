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
  version "0.7.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "42c149c42d72fd1fc00983e929b17bacd3f91fb9df6b9a0fd3a778fcd2667229"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "9ddce143b4ee2c63b80a86d4ea7abb06a8e86e9b4029e56f8a8cbfded4581384"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.7.1/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "3266a4b29d7e5dcdeed0a416da59a8bf7580dae8ed63a423dab842a8d5e48bf2"
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
