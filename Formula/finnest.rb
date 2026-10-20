class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.24.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "0c15b31ab9cbe53213f671ee3365c8680c71034da50a0eac8fa81395a2058f47"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "6e5b8195cf3b37ce2fbe0da2b9534337a76e6d02ac20ab4181433bb220021df6"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "ffd7bfc78ef4c0636b5f3b1c8c138281b53e35a0147dac468d2b9482477c7fba"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "8b58351c4afe4e74f82d536383c50d9ce0a072aad9a64656805ff59dbefcd168"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.1/finnest-darwin-arm64.gz"
      sha256 "bae6d70ca6c25f9ac91f9b8015c56c5a30dd020b2adacbf2a3936cb411251594"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.1/finnest-darwin-x64.gz"
      sha256 "bad7a90d1d7aa9c36848b6f64ece0eddbe9f08af127c2661f214dde930903395"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.1/finnest-linux-arm64.gz"
      sha256 "073528d0df881a48028bc9b60beea94e23d8282f25382a73db0bcf3c37079ba7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.1/finnest-linux-amd64.gz"
      sha256 "8485058c5f8175ad90398cf1e4150e7798481f57a1ded939aa3821af84691403"
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
