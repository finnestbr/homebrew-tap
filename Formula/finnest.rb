class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.27.44"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.44/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "d358c0de41d2ef06a363e5447ebeef0fb0e674f7fd89d98e3e1482f0976327ee"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.44/finnest-runtime-darwin-x64.tar.gz"
      sha256 "5870f28a8453771c011c6fa64ba6cf3499e6443a516f8fe2882af0df7250acec"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.44/finnest-runtime-linux-arm64.tar.gz"
      sha256 "179adaa388a45c01b3020387e7df75cb88f03a142d691773f4365e9a36122476"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.44/finnest-runtime-linux-amd64.tar.gz"
      sha256 "2bb95cb159b7e09a36cd3ece9ebed34fa86e1e48f395060a90289f5cfd42d3db"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.44/finnest-darwin-arm64.gz"
      sha256 "1a88f5d0b8410af8740c76a15082fdd8d047dc358086018fd83f096e9d7d9013"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.44/finnest-darwin-x64.gz"
      sha256 "e3445fd7b72df521505eaf6a240f33b681537321da5aaa68fb47407fd93b3634"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.44/finnest-linux-arm64.gz"
      sha256 "7c6ef47891ddadc8a95e701515507427770bf70e02de99bb8922a50151c5e7c6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.44/finnest-linux-amd64.gz"
      sha256 "b5c25c2222e3cb7cad217e70efcb52c93dc8c961d1c53f06ed876d4ab87a0138"
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
