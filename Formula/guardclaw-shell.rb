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
  version "0.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-shell-darwin-arm64.tar.gz"
      sha256 "503757d05d49223815bd45c3031ebdc207ace62aa6f70c86bd96652475ebaf80"
    else
      url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-shell-darwin-amd64.tar.gz"
      sha256 "95dfff0f06019e6a85fbad0a6d200438ea22ca03a1ad8169a655324eabdec8da"
    end
  end

  on_linux do
    url "https://github.com/TakeInterestInc/guardclaw-releases/releases/download/v0.3.0/guardclaw-shell-linux-amd64.tar.gz"
    sha256 "669e282bd9ec20e267608748b2d1baad1c81478e80292302863fa69cb1fb2930"
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
