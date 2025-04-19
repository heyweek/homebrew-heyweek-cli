# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class HeyweekCli < Formula
  desc "Heyweek CLI"
  homepage "https://heyweek.com"
  version "1.4.51"
  depends_on :macos

  if Hardware::CPU.intel?
    url "https://github.com/heyweek/homebrew-heyweek-cli/releases/download/v1.4.51/Heyweek_v1.4.51_macOS_amd64.zip", using: CurlDownloadStrategy
    sha256 "aa02bf5602242253b28dc94602e80d02ea0461033c4fd4dd44a3cc2e0d62cd18"

    def install
      bin.install "bin/hw"
    end
  end
  if Hardware::CPU.arm?
    url "https://github.com/heyweek/homebrew-heyweek-cli/releases/download/v1.4.51/Heyweek_v1.4.51_macOS_arm64.zip", using: CurlDownloadStrategy
    sha256 "bc819f9190d05ab79a35afa4fefd8224948ed89d284fed97bdeb0ef031492b22"

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
