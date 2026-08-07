class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.6.32"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.32/finnest-darwin-arm64"
      sha256 "a845d69e3f17c4f1a73797e5b68c93f5376056ec4fd28eda104a718e3dd54627"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.32/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "a990869b118fe7574b3d1a399af508b3f78b3dfe41b412f8e9a95b339612f39a"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.32/finnest-darwin-x64"
      sha256 "88a9eb126fb3da27a9d2467355ae57769b18300e1e75a44dee5e089fc600894e"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.32/finnest-runtime-darwin-x64.tar.gz"
        sha256 "c307a859011702d73d370c5ba9da1875a162c2cc6c397e61d7ece653d1d5e274"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.32/finnest-linux-arm64"
      sha256 "2415791acd5887864c5c5fca6507d6c38d62cb3906fe573188cabcfa68f2136b"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.32/finnest-runtime-linux-arm64.tar.gz"
        sha256 "6ea930280d7091e8ba302a2515df2e6463bde3a609506ee9301c201c68b0bf13"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.32/finnest-linux-amd64"
      sha256 "1213d22353eb6875ee815f76854cb6c83a966d3451d876e03589598665e115b5"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.32/finnest-runtime-linux-amd64.tar.gz"
        sha256 "0952d395ed573bab9f69552d0512e3bb555df8fd662e83f60914aa8868f81d9a"
      end
    end
  end

  def install
    asset = Dir["finnest-*"].first
    chmod 0755, asset
    bin.install asset => "finnest"
    resource("finnest-runtime").stage do
      prefix.install "finnest-runtime"
    end
  end

  test do
    assert_match "Usage: finnest", shell_output("#{bin}/finnest 2>&1", 0)
  end
end
