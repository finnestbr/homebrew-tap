class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.6.40"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.40/finnest-darwin-arm64"
      sha256 "0aa3c36c8f94337cef6e3326828212c74ea6a2ad06249c511d3e6e4fadeaaf09"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.40/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "f89f82225d1b322dfc30e56d3d1bb47046f40fe75c006c8525a980df50ee2c51"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.40/finnest-darwin-x64"
      sha256 "94f5536b3a46458c25a37165f4d34b6c2718d43c2af1edf016b445e14f9f58c6"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.40/finnest-runtime-darwin-x64.tar.gz"
        sha256 "4e56da29f55a821f2bfa54143993bf8343aff7a0045bffb7cbdb449ae8a4b216"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.40/finnest-linux-arm64"
      sha256 "02cd257bf2fdf2e0acff355ea675fb314590c2e2e43c42f36191bb8147d0f37e"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.40/finnest-runtime-linux-arm64.tar.gz"
        sha256 "6fb66f9a519a6d145f434d80d43727aa611cea00054c19df32d1ada024c229ca"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.40/finnest-linux-amd64"
      sha256 "9a9f058f288f661d003f2277812efba289cd0daec5f110fe5a82225c759593bc"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.40/finnest-runtime-linux-amd64.tar.gz"
        sha256 "1205b1e86d9ed7cbb0838361eb9d91e91dcbe423ee9b5c92774ceeae6113dbd5"
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
