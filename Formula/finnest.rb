class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.29.2"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.2/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "7be336f03444aac61f0070e2e574fc69c7276fb1aa02f42f280f060cc8b55343"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.2/finnest-runtime-darwin-x64.tar.gz"
      sha256 "7eef9fc2532b833ef83313b8fd260853c616993b2efff5f43570f9ddb4c3f836"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.2/finnest-runtime-linux-arm64.tar.gz"
      sha256 "fb35562e80938290c461db47311b3d9f2182cd02ae3d36d2af7794d3e8f38123"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.2/finnest-runtime-linux-amd64.tar.gz"
      sha256 "7746a16126d91f18b74cc0a9c93e813d6e4a65cd7ada91ef006b02601e14f554"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.2/finnest-darwin-arm64.gz"
      sha256 "697ca821b7046421763650a0defc476017545fc4b5b399a080880744e36b2816"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.2/finnest-darwin-x64.gz"
      sha256 "edde811be7fddf342b68b55cb9a41ecc73b26bd45184a5604444b28c5dc3f91a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.2/finnest-linux-arm64.gz"
      sha256 "b1548d872ec79ca47d802cfc9d26d4d5c18c0019e27f49dfc7041257989722b7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.2/finnest-linux-amd64.gz"
      sha256 "aa73a7f703be6549718a2dbd83fc0d5889e32a2a30005d1b11e85f76262fd5c7"
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
