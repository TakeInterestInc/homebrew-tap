# typed: false
# frozen_string_literal: true

# GuardClaw Shell Wrapper - deny-by-default shell execution filter
# https://github.com/TakeInterestInc/agent-guardian

class GuardclawShell < Formula
  desc "Deny-by-default shell wrapper for AI agent security"
  homepage "https://github.com/TakeInterestInc/agent-guardian"
  license :cannot_represent
  version "0.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-shell-linux-arm64.tar.gz"
      sha256 "PLACEHOLDER"
    else
      url "https://github.com/TakeInterestInc/agent-guardian/releases/download/v#{version}/guardclaw-shell-linux-amd64.tar.gz"
      sha256 "PLACEHOLDER"
    end
  end

  def install
    bin.install "guardclaw-shell"
  end

  test do
    assert_match "guardclaw-shell", shell_output("#{bin}/guardclaw-shell --version 2>&1", 0)
  end
end
