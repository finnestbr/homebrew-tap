class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.19"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.19/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "25b578714e326ec5155b8152e03095b99a80e83be7ac07919cbb3814419d5b25"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.19/finnest-runtime-darwin-x64.tar.gz"
      sha256 "36fbaf23c6f9eb485252baacd42d634e96946d9471ba476b554d057e63f24d19"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.19/finnest-runtime-linux-arm64.tar.gz"
      sha256 "25c07a886112d36bdcabfe26902ce901e749adb64851363b6b61508742c2664d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.19/finnest-runtime-linux-amd64.tar.gz"
      sha256 "57d1a0c0f653a7147a63ec34e4cdeea4e336e472351dbb1f26f7c51785cf0501"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.19/finnest-darwin-arm64.gz"
      sha256 "6d512c585e18f2d45e5dadf6afaab4c4b83cc048d20b26b62af4f706279e29b4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.19/finnest-darwin-x64.gz"
      sha256 "5a0b5a84bb977ae7f93afcd0a0fc9739a68b689a7d85c579154efe3cda8c8340"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.19/finnest-linux-arm64.gz"
      sha256 "0bb5699a71b1f3eec36e81872a953304a47e7929df16b6238446bd6c5243de95"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.19/finnest-linux-amd64.gz"
      sha256 "05b6e94a1b4eb45da72928dbd2be911f1a55f8a8911684bc32921212b32794ac"
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
