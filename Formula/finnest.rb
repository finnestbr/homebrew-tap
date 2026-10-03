class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.11.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.11.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "682a7a5abb452b0a602b37d1e2cf60eb157f2f9cf528d1f7fbfd1d515017e3a2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.11.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "e6d1ef3480b11956519b985c5b3edb5a1539345c02943fd2909735f95d5ba527"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.11.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "4c0332fa16be1d9384c27cfed76e64ca521be477aee11b9b0151f6592511556b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.11.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "2cff33b56089c58c373736727e7f1c953e0dbf4f6ab76acc8ef5f81c6f0b3ff8"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.11.0/finnest-darwin-arm64.gz"
      sha256 "30e9671344885c669fa5de314d960c00215c50befc8e2c187892925e518bc3fc"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.11.0/finnest-darwin-x64.gz"
      sha256 "f20e407c223c857db87ade9a8df779949f11649e840a6530b75e70e59a5e3fb8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.11.0/finnest-linux-arm64.gz"
      sha256 "428c06313a88c06e5ccc79ee1890df37140eca1e216fbc873b97461034f04bb7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.11.0/finnest-linux-amd64.gz"
      sha256 "4e932dd6f92106463fee5ab05e2f8c52e2edf5b08c713c8cd9e0cd2e0cc6dce1"
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
