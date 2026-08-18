class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.7.3"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.3/finnest-darwin-arm64"
      sha256 "aa264ac8cc6ed90cd33e6da5c8b0b9a5d59fd83384eb31ed095c9b9e8b2682b8"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.3/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "fb76a2337d47054c90168590dceb9a7fa13fb3a905ab15f570e96c71849938f8"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.3/finnest-darwin-x64"
      sha256 "fd3ec534ebda9634007cc8e9ab7a334cedda0a775c4869dc80300027077b728a"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.3/finnest-runtime-darwin-x64.tar.gz"
        sha256 "2a62476920c1ee996ab8260ce245578d0135eef36dd9e0dd1f31c147ce489cac"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.3/finnest-linux-arm64"
      sha256 "975271438e6d165524ebeab7a82b99c08e06eb2628a935a8abe152d73e3d1fb6"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.3/finnest-runtime-linux-arm64.tar.gz"
        sha256 "a6dd8d3477b923f012a0167864bfbf90047afbc9609b0a4d5d9e3bbdb99783b4"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.3/finnest-linux-amd64"
      sha256 "fd75fc1e2c6381ee5b03ee9b5b3f13dabda979c23533e6188c6c9d2a0235d70d"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.7.3/finnest-runtime-linux-amd64.tar.gz"
        sha256 "9db950b929e4a4ccdb1bd8dd9b31105e7b99dc2f572ab67683d013aef0982ead"
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
