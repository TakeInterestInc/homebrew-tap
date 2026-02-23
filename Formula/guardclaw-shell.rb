# typed: false
# frozen_string_literal: true

# GuardClaw Shell Wrapper - deny-by-default shell execution filter
# https://guardclaw.dev
#
# This formula is auto-updated by the release workflow.
# Manual edits will be overwritten on next release.

class GuardclawShell < Formula
  desc "Deny-by-default shell wrapper for AI agent security"
  homepage "https://guardclaw.dev"
  license :cannot_represent
  version "0.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "790b655178f285d780ea0ab05aa5e9de573208425952d64fcdcb9ebcfb009886"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "9d6170d67e80252ef589fb9408e16aa206cbdd6ae97b8f78bb9eca1afe613db7"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.5.0/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "f75ed4ca80567a46a7050e5a096c840ccb767d3c78ed6eed89985089b8e50722"
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
