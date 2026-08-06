class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.6.29"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.29/finnest-darwin-arm64"
      sha256 "136eb3f15e9d9c7817503243a88d8b5b19368764bb2f7a3ce43098835e21e17b"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.29/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "8ac53a3710b505638cee4b3817e89298b4799c39de4e1e058971f691c2b0c4ff"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.29/finnest-darwin-x64"
      sha256 "d87289b40c815a1991448a2cffc42310955703a8649bf1972c006971d0ecc4b5"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.29/finnest-runtime-darwin-x64.tar.gz"
        sha256 "4273f1fc6cf14e74450e5aabce1a006c60fddccfdc3be4fadd764aec195f9f84"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.29/finnest-linux-arm64"
      sha256 "5ee14ee9d42790993caeef286689989101b2b78798d3c683809a8716608c05af"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.29/finnest-runtime-linux-arm64.tar.gz"
        sha256 "beb63f1ba230306a6afac86228369245fb318c8bd358c962ba042d5cfc06350d"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.29/finnest-linux-amd64"
      sha256 "04c540f0004539650bd833e69fa9816d7d4fb801d756544854da38c4f7cb0362"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.29/finnest-runtime-linux-amd64.tar.gz"
        sha256 "84aeb89fdd925c5f8a9deee24c9b4ce4b1a40df6fb47bf358d69ffb1f5e14f2a"
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
