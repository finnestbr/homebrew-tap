class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.22.6"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.6/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "18bfd1192b6333a0d79f91509ed1a0eec6b881263aeef6d2fe068a6baabdcf8d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.6/finnest-runtime-darwin-x64.tar.gz"
      sha256 "422bb5247b0288ad6eaaa1bf96690a2e0c501cb8a8b4f053a68912636d2db5f8"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.6/finnest-runtime-linux-arm64.tar.gz"
      sha256 "b98a7e16b3e7fe33f8ca7b4bb6a1864ffaea9aa0ecd5ffbad14cadabf632260a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.6/finnest-runtime-linux-amd64.tar.gz"
      sha256 "f07c1cdf59c598cf6edeaf61d3518890a3cb97f04315526aba1e7b37cd9e1e2e"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.6/finnest-darwin-arm64.gz"
      sha256 "f7df5ab41742c24d786e403247a9e8b38d6d6a0aeaaf6e4a6cb0bfbd787b3324"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.6/finnest-darwin-x64.gz"
      sha256 "a15904499faa653188ab4a4efa1929da3dcd1e634a15d438be42032a2925b458"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.6/finnest-linux-arm64.gz"
      sha256 "85d79860f54d9face7acbb08b95e2f228868a7022b7b1b34b3beae4cd81e18eb"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.6/finnest-linux-amd64.gz"
      sha256 "75074290ed26e2415c46a9daa4af55f9cf58f82e4c3b9bc991968e9653fefae9"
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
