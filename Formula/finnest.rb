class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.6.37"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.37/finnest-darwin-arm64"
      sha256 "a44fdb311063eb2c8cada9a0c07a1fbd17b855bce745b7976d1adc0446f03d36"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.37/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "df0ad8e09adda6eb3c996109921ab1c1d9a57b4681416d0ccd458635fcb3cfd2"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.37/finnest-darwin-x64"
      sha256 "868a66445c2daefad3884bf7e0d5b81644367aa607e5ee1916ab26749543ad39"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.37/finnest-runtime-darwin-x64.tar.gz"
        sha256 "05b9f8b81a497c4dce939f7983772083eee8974bdff8f8bbc774f29eac7fe57d"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.37/finnest-linux-arm64"
      sha256 "a55815f8995a74ff510bca63a8d271f6e1548832f2be501fbd506e3840e0c45d"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.37/finnest-runtime-linux-arm64.tar.gz"
        sha256 "4ee97aaa218f0cd388b99a835a28ae7f3fa18610e8bb100a82a16e97a6fe32e5"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.37/finnest-linux-amd64"
      sha256 "97c56823627f018523f41a42a214521ef01f4e9bd62176097934bf66e5be647f"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.37/finnest-runtime-linux-amd64.tar.gz"
        sha256 "fd83627090f533f0bfe0b862d73980e7910b77afebe72a3f40e72ce4485434a1"
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
