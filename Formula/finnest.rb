class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.21.5"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.5/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "ccf11d7d0b407d737aa9eb386a1aee813c0f9f0f1ed6c03767d411086a8a0a1f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.5/finnest-runtime-darwin-x64.tar.gz"
      sha256 "9a2aa5644945b44911a98626f6f6215dcc74109fc870b2b6076103b2ca2fc0b8"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.5/finnest-runtime-linux-arm64.tar.gz"
      sha256 "164f403c707ef560a0ef25a80d87870d23369d87c48ac20b46b17903a331b245"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.5/finnest-runtime-linux-amd64.tar.gz"
      sha256 "16be6eadb1fcb43f64521e098acbb4ead426195955ae50183b19806b761b5398"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.5/finnest-darwin-arm64.gz"
      sha256 "5175ecc58ff76f0c994f7d8f7343db656cb16bf45944b4efb980c7e7067d290f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.5/finnest-darwin-x64.gz"
      sha256 "c8b6363f38b6fdb008db0c7c349c7b66ac8538efaa30b5cc16e880cfd969a6df"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.5/finnest-linux-arm64.gz"
      sha256 "af1d4cc2c13e36c98a05e0ef764747a50ba6fffea91b8fe642cf786a4657a115"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.5/finnest-linux-amd64.gz"
      sha256 "a373da154fa2c2f48dedc3b7d41b76b20be9740e20958585297d2987021fc062"
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
