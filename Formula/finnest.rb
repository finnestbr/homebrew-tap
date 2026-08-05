class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.6.27"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.27/finnest-darwin-arm64"
      sha256 "3cef3f4d21904b86ba3837975b39f96753ac0fe7ce0cd68b9064ab01fbc4e6d8"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.27/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "cdb16392c659349f4f7691f506f6bd1a23955bd72c531fdcf530475018ef2c3a"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.27/finnest-darwin-x64"
      sha256 "2b5f8621e809b029c92c61c00a0e4714a1e2cdc757f1228f1dc085f337e7b50c"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.27/finnest-runtime-darwin-x64.tar.gz"
        sha256 "df266ddd8eae22c3af356314edb5a2442ab27b3429d4f8a3c9ab07407b3e0f0e"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.27/finnest-linux-arm64"
      sha256 "056f3a75a9c48b221b69be390c0139df6e76589ecf0162d9dbf104939df9150b"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.27/finnest-runtime-linux-arm64.tar.gz"
        sha256 "2e80cb9a0414418280164001825eec2d556ff2b21bd57ad14050537344a6457f"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.27/finnest-linux-amd64"
      sha256 "bbd800ee11ce895a7bbfdaaa1b872432813e8fe40f150027de0f6f6b42a98cb4"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.27/finnest-runtime-linux-amd64.tar.gz"
        sha256 "b47b882f72ed3f8fcb9690582cbdeb19836555536c9cc70e32820f10f6efdb72"
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
