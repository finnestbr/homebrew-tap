class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.21.2"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.2/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "f12a3daa817e9b9c33ca16f0113841062bdc9b154655ca2e6f6b62c0798f3f69"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.2/finnest-runtime-darwin-x64.tar.gz"
      sha256 "0e95799aabf8529f432cf923945b29a258c97aca00b7e983413ec7c59cb1897d"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.2/finnest-runtime-linux-arm64.tar.gz"
      sha256 "8e0047b6d4d38fd2d5a3273b37cc9e3c7ca6c4d83272dace5529fff42181e183"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.2/finnest-runtime-linux-amd64.tar.gz"
      sha256 "8df32a37f2eddb2e97b4e82ff4b400159bb602c780b765aa07a2cc0c1de418b5"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.2/finnest-darwin-arm64.gz"
      sha256 "4d5b631c13d7c10b4ee5bf25fb1d1687c81b54dd8a6b65e5938802bc64fb7186"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.2/finnest-darwin-x64.gz"
      sha256 "dabae9fde9f264804b7febac7970a86a29cba4472f256778df59ba9d04791a68"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.2/finnest-linux-arm64.gz"
      sha256 "0fa0411e409b1acdb322bc2bb7ffa7c789f9453961172c92668f23a30ff9dcfa"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.2/finnest-linux-amd64.gz"
      sha256 "6df3a47f39810ef4fe0d31a2374993ab047952ea058f3d9b58484587abce5759"
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
