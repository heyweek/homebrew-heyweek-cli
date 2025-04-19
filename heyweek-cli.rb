# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class HeyweekCli < Formula
  desc "Heyweek CLI"
  homepage "https://heyweek.com"
  version "1.4.47"
  depends_on :macos

  if Hardware::CPU.intel?
    url "https://github.com/heyweek/homebrew-heyweek-cli/releases/download/v1.4.47/Heyweek_v1.4.47_macOS_amd64.zip", using: CurlDownloadStrategy
    sha256 "c106840357ebafe4b9b9dbc2e3aedb171014cc2789840b79f85f1b3be328b9cd"

    def install
      bin.install "bin/hw"
    end
  end
  if Hardware::CPU.arm?
    url "https://github.com/heyweek/homebrew-heyweek-cli/releases/download/v1.4.47/Heyweek_v1.4.47_macOS_arm64.zip", using: CurlDownloadStrategy
    sha256 "92f110a9db3043d5ad6902651e52b5a4727f3ac7f7d956fbc068b793ab0130f7"

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
