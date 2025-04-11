# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class HeyweekCli < Formula
  desc "Heyweek CLI"
  homepage "https://heyweek.com"
  version "1.4.34"
  depends_on :macos

  if Hardware::CPU.intel?
    url "https://github.com/heyweek/homebrew-heyweek-cli/releases/download/v1.4.34/Heyweek_v1.4.34_macOS_amd64.zip", using: CurlDownloadStrategy
    sha256 "843a2c9f69cd294e5a527d32ffefc03e8de3c891c5ad67537005a04860ea31fa"

    def install
      bin.install "bin/hw"
    end
  end
  if Hardware::CPU.arm?
    url "https://github.com/heyweek/homebrew-heyweek-cli/releases/download/v1.4.34/Heyweek_v1.4.34_macOS_arm64.zip", using: CurlDownloadStrategy
    sha256 "cdbf9c118262f2bfcdac4a94351e3d4ec56db7f24b19d171ea84cadd100e621c"

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
