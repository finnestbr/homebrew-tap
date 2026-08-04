class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.6.26"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.26/finnest-darwin-arm64"
      sha256 "28cba43420de76911f4511410c9fef84088fbc8b40e1e354ec41be98525bda84"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.26/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "f7d0a28a2c9d4aaf071ad569620c6e99c2c926a260ff463d682e8726eb0dc7ac"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.26/finnest-darwin-x64"
      sha256 "513162d980e7267344869622e3ad1a84d0d44f84e27f09ab9fd73771280ab118"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.26/finnest-runtime-darwin-x64.tar.gz"
        sha256 "bf60c094c75445ece61602157ac899ed2b2aa912b5df94d65071698cabddc8d1"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.26/finnest-linux-arm64"
      sha256 "6ec6a4a945ba8c00f09db78e2db319c209b4951a9e633d8f93517f9515fe10f4"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.26/finnest-runtime-linux-arm64.tar.gz"
        sha256 "16a7cac7aea21300db1e8e9ef1cec17df82788c0828ecb54fe251ec4527ba99d"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.26/finnest-linux-amd64"
      sha256 "a1ad1f500b15b0fcf5640c4358ab815802710922bd0982e95526efd30afedfd7"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.26/finnest-runtime-linux-amd64.tar.gz"
        sha256 "71f180cbb5aaee698e40f249c427373d16696d719fa165c679b0f086cd17ae7d"
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
