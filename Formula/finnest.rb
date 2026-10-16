class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.20.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "e5294557b3004c33cb2137847f4d8618c8c9dffdf1e616480c8772bfda4fb6cd"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "b9c17fbe4feb9a32e3ba5a1368333b79f5e3eb3c3d7b2880771ba88266b88d9e"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "cb85459cfa084d30849629bf61bf8d6bcbdacac0cdf303837ec6c951b8022e16"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "d45ad7bcbc3b0c23e50929f136e025c855b7506b52ffd1cc16b2125001b17253"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.0/finnest-darwin-arm64.gz"
      sha256 "66101dd9948057d6d88deea69bc50ad7f62d657fba26cba4c868dde79160d63f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.0/finnest-darwin-x64.gz"
      sha256 "efb9888e95efe1a47cd51d0a8f7ea8be7ffe96b51b7a9e31609a4ea495e23d7f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.0/finnest-linux-arm64.gz"
      sha256 "8f3e970a403790f7688d5d5ae1e5508dc74026d024a526b86317b7f483b020e4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.0/finnest-linux-amd64.gz"
      sha256 "32ec5671ae9a7d709c73796561b6e561171283e2045f233a2e27eb983bea56ae"
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
