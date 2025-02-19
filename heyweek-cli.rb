# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class HeyweekCli < Formula
  desc "Heyweek CLI"
  homepage "https://heyweek.com"
  version "1.3.2"
  depends_on :macos

  if Hardware::CPU.intel?
    url "https://github.com/heyweek/homebrew-heyweek-cli/releases/download/v1.3.2/Heyweek_v1.3.2_macOS_amd64.zip", using: CurlDownloadStrategy
    sha256 "91d4da25671e69c0efac7c3f558c1edf776cd8a5c32314a21ec261bb676bdb67"

    def install
      bin.install "bin/hw"
    end
  end
  if Hardware::CPU.arm?
    url "https://github.com/heyweek/homebrew-heyweek-cli/releases/download/v1.3.2/Heyweek_v1.3.2_macOS_arm64.zip", using: CurlDownloadStrategy
    sha256 "8620185ac081e4f0951e52db696ef83365729576673c14ccb74e3be8dd6cb084"

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
