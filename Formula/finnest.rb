class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.16.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "7ab18c56c4f6735b8bc41cc155821a5c70a677c86f7be89c72a163f307569867"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "2620b5453b1afa023709fd0af82effdce5409b7b70133e0eba4e3039f8737e13"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "8a04c25c2861898e4743f0cf83016ab088ef8ed6de6a1d0c0f0eba290870e888"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "ea02bc2c3b8a0a7912c293a42a5c7c38d3298d8f24b76d1a6868459e44073801"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.0/finnest-darwin-arm64.gz"
      sha256 "2a708a425c8e704769628ba0f055fb2af2f527de2a4cf0755741f2d984394047"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.0/finnest-darwin-x64.gz"
      sha256 "57303655493821f65499ec55897bd28f787bd5b90c738790b93e4639e900541a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.0/finnest-linux-arm64.gz"
      sha256 "6546600d185a5bdc30b763ec7a34b8fd9903b35e79e21cf6e1cda3e7c175f446"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.0/finnest-linux-amd64.gz"
      sha256 "1c5d5f1cea5f5761ee65d5aebca3157fc60070b59d3435ce52eec45058267053"
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
