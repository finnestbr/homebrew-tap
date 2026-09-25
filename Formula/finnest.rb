class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.38"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.38/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "3528c4c692e4041dc6c510640eae95e6cc57bdf0ff5fa8b29a5f2fbc7e39bb88"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.38/finnest-runtime-darwin-x64.tar.gz"
      sha256 "d45f92415d7627d5bbc2e34d0e2f310e4628ff8ccf402580584b9ff7e417751d"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.38/finnest-runtime-linux-arm64.tar.gz"
      sha256 "4ab4ae949f0e7a91e23d4c7df142205d2be2e1efe0f77a9a9d7f930a229ebeb8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.38/finnest-runtime-linux-amd64.tar.gz"
      sha256 "96b242b204d0f01a5d5da73cda32c81a27db5af4e95f9983183d31feef50d306"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.38/finnest-darwin-arm64.gz"
      sha256 "1efbc58ba5cbf9834b368d06d55b11405982c404243ddf0fdedd1e7e6e3fbddc"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.38/finnest-darwin-x64.gz"
      sha256 "655349b57aa4866e22d5f1a3b4edb5ef5e27f3240584da5c895356996393d9d2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.38/finnest-linux-arm64.gz"
      sha256 "eb1a100170cc80c47a8e21614bbc09c83b38b6a995c20f117088a9d83ee1733a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.38/finnest-linux-amd64.gz"
      sha256 "6b60391e2340d9e556005ec28de2c6afc2dd6fb4b1f55d7e2829c249dc2ccd98"
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
