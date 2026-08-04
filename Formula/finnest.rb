class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.6.24"
  license "UNLICENSED"

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.24/finnest-darwin-arm64"
      sha256 "ab0ada9fbb0ccf8638a10b0c28360158c2f4e08f65796b9e324aefc702c9e9f9"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.24/finnest-runtime-darwin-arm64.tar.gz"
        sha256 "9c4dc8261e2b4b6d517f5b967871a0f6a5994ce08fd7acf22c542aaa8859ae28"
      end
    end
  end
  on_macos do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.24/finnest-darwin-x64"
      sha256 "6868423e0ca5d6ed41a03e44b15acc88c6b582ff5cdb212a8032f7aa253ac2c3"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.24/finnest-runtime-darwin-x64.tar.gz"
        sha256 "fea2f01098e2f9e3f74475e8fbf5bb5bf86a6693196f209b9cbe67e5d4060fd2"
      end
    end
  end
  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.24/finnest-linux-arm64"
      sha256 "753b1fd0f5e79e9e5bfb0af57e5f1dd4886a9b5a66d8d8c6399e492c805ed343"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.24/finnest-runtime-linux-arm64.tar.gz"
        sha256 "c53dc184186cba8481ee3e92be0664a784b8725ddb6b3066a5bfa6f0a451874d"
      end
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.24/finnest-linux-amd64"
      sha256 "182b136233b4b6fe02e4d1e3c863c62cf8f2860337a0a082b24cdbaad950097a"
      resource "finnest-runtime" do
        url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.6.24/finnest-runtime-linux-amd64.tar.gz"
        sha256 "04b1d6177f29a2ab1b2defaf41a0a9f9de61c712fd1d183d874e8c9163b17897"
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
