class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.9"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.9/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "8b83f2222c1b76b8bfb512c5a693507f1a809a2218066bbdb1daac0ac2106db3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.9/finnest-runtime-darwin-x64.tar.gz"
      sha256 "61efd1cf1650a42a2f5e30315998bb17badaac81d2ded14d32c50119e1c13ec0"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.9/finnest-runtime-linux-arm64.tar.gz"
      sha256 "dbd6a98881f95b14154362a43d0fe410303c0e59c56a177cf50755bff006bd71"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.9/finnest-runtime-linux-amd64.tar.gz"
      sha256 "722534b90cde4c78322e31b4805e7762bc8c062312705e19791ed0fca363a95c"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.9/finnest-darwin-arm64.gz"
      sha256 "283c14a66973f661028a090270499b2b28c75cdba87074e4233c755a87c1af97"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.9/finnest-darwin-x64.gz"
      sha256 "79aa1e901971eb51c7eb70591e7cbd709af28ca91d37fdf344880762b778f677"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.9/finnest-linux-arm64.gz"
      sha256 "8d24c8043bb850068af2a91ad6c326d15d8d436c84b6e7aa5559d5f6af88c9a7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.9/finnest-linux-amd64.gz"
      sha256 "41f259fe529a9ed3f9a676295dbc90ea6dfc4ee0c7da25e6b61e757ba50ead07"
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
