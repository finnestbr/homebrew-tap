class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.7.2"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.2/finnest-darwin-arm64"
      sha256 "bf631dc068691a8e555b939b9ec1121e420fbbe26aca145f3a224655f7c0233e"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.2/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "6eb788070a913b043f760677c763516765a2a8f5c44c6cb3abb28c67cfce0303"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.2/finnest-darwin-x64"
      sha256 "81bef1df8d9983e36e68b7c687e6671c7f7c4bbc852be389336aee7d41ca0a0b"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.2/finnest-runtime-darwin-x64.tar.gz"
        sha256 "d1287d56a56d4e92ed125c63c11237d5ad3067ea5ca9b4a26ee7bcabe99a2619"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.2/finnest-linux-arm64"
      sha256 "be40538dbb36402d60ab7a285a9cd8f81c95a8f99bd11940c43ff74f8fb96a36"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.2/finnest-runtime-linux-arm64.tar.gz"
        sha256 "58b87c2a595222a1f3ec66bce75061155ccfdc4936c513f77b257a1a1507e3e8"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.2/finnest-linux-amd64"
      sha256 "e1eee9e8cd50329b6ad441e499c72f10f4b9fbc78cd44a1287b1cc2ebc6cb817"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.2/finnest-runtime-linux-amd64.tar.gz"
        sha256 "7dc13d1783e939cf0d303de3c7161f323b92184c2b04bc84b34f94d8972871d7"
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
