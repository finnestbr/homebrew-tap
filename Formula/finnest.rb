class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.26.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "6fab58ec4237d553132517673638afa68bcfe4b7a5481a3bc5d9bee92b9f00ea"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "853a1320a2248785fd582a2cbaa63b82c86626f767e261aadd7b1b5c7f2ec850"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "9b65fe311184e963d43bdff92c0eda1a03c28f7a45dad91bba8da41c37294a16"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "57cab059d267ec8c5a39ee07d681de491d9839a4f4a9fcb5f1fa5c83526cc921"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.1/finnest-darwin-arm64.gz"
      sha256 "73c494154a3ff058e940f2b5c3e7be4c12b41af222d31bb77f317df7cbd7c8b2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.1/finnest-darwin-x64.gz"
      sha256 "231bcb0cd6b80c5f7385ff83ff2d37f1d51b4082ecfc68d51a5e1101f32e6e35"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.1/finnest-linux-arm64.gz"
      sha256 "e6ef5682f1e828819851e848bfc9c853d39c4589f173cb1998365d791d31c078"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.1/finnest-linux-amd64.gz"
      sha256 "51c32a08f21173ecc0d031a49d422eb6aa76a62d97b4b89b00af2ac4621b433d"
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
