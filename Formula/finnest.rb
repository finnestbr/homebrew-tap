class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.29"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.29/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "d70549f2f4e2031d18daa5fd43c5dfa0115ed179ed170d7c1c8d94a74aa5bce0"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.29/finnest-runtime-darwin-x64.tar.gz"
      sha256 "1f780c51fd576f3dd89368721c7450f428dc098fc39b53ac97aee95f7be1dfd2"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.29/finnest-runtime-linux-arm64.tar.gz"
      sha256 "93939908e48af73936f49f29cce0bf7c3b717369bba9ab156b7cfc5e4dff9956"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.29/finnest-runtime-linux-amd64.tar.gz"
      sha256 "988af3ce18dce002347e3131cf5d150856d08a1a274fe047b9c69c5bc4040a6a"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.29/finnest-darwin-arm64.gz"
      sha256 "dde7dae5da0c0fb48449a14f66c6e356f492bdc22692ea7b4e6a90517b5baf4e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.29/finnest-darwin-x64.gz"
      sha256 "189e583eefc95c8a54016dcd9b7367b0d1ff18911b759fd2fa6af15afeb33da5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.29/finnest-linux-arm64.gz"
      sha256 "0cce19a1e07e24d91eb72cd5ca019a696fe943ffd860016f731ddbec5d85bf9d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.29/finnest-linux-amd64.gz"
      sha256 "61031ddaa26a8ec6c3208eb02a47a4be9179b325a1d37c8c19e5b2bd82477aea"
    end
  end

  def install
    asset = Dir["finnest-*"].first
    chmod 0755, asset
    libexec.install asset => "finnest"
    resource("finnest-runtime").stage do
      (libexec/"finnest-runtime").install Dir["*"]
      (libexec/"finnest-runtime").install ".finnest-toolchain-identity"
    end
    bin.install_symlink libexec/"finnest"
  end

  test do
    output = shell_output("#{bin}/finnest version --json")
    assert_match(/"version":\s*"#{Regexp.escape(version.to_s)}"/, output)
    assert_match(/"runtimeBundle":\s*\{\s*"status":\s*"ok"/, output)
  end
end
