# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class HeyweekCli < Formula
  desc "Heyweek CLI"
  homepage "https://heyweek.com"
  version "1.6.0"
  depends_on :macos

  if Hardware::CPU.intel?
    url "https://github.com/heyweek/homebrew-heyweek-cli/releases/download/v1.6.0/Heyweek_v1.6.0_macOS_amd64.zip", using: CurlDownloadStrategy
    sha256 "97ec4731d28127cb7a4232c626f7163af6b2bf5ad66707da46b0289c8b26f2ac"

    def install
      bin.install "bin/hw"
    end
  end
  if Hardware::CPU.arm?
    url "https://github.com/heyweek/homebrew-heyweek-cli/releases/download/v1.6.0/Heyweek_v1.6.0_macOS_arm64.zip", using: CurlDownloadStrategy
    sha256 "9a02ddd6459cf197d2d71cd6de2fbc340cf08b1f0cd6c2a0ea9e451ec954ed5d"

    def install
      bin.install "hw"
    end
  end

  def caveats
    <<~EOS
      ❤ Thanks for installing the Heyweek CLI! To get started run `hw auth login` first.
    EOS
  end
end
