class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.36"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.36/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "dc813f9b1fc0a91a780da2a1393fc46829e9021e34427c063a54ac9d33b08548"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.36/finnest-runtime-darwin-x64.tar.gz"
      sha256 "8e70cb5b43c8d992afb3f5e66c1f757ff876af5604dc0d938d2ddaf0710cafd7"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.36/finnest-runtime-linux-arm64.tar.gz"
      sha256 "9b267b50009412d67270552daffa5946aea0da645e1366c06dcac522de373b20"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.36/finnest-runtime-linux-amd64.tar.gz"
      sha256 "3c06438367f77602ebe5f790cdc87b50212a39a237c1fba82d6a483ea1ef3a68"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.36/finnest-darwin-arm64.gz"
      sha256 "338f565080f76091f43be9765808e2f944f018f51b873029aad683438374ccae"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.36/finnest-darwin-x64.gz"
      sha256 "55e8d3dcf4c13e0b83f5119f97ba543454565ea8d10dbb20a17f92d9b6f43f43"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.36/finnest-linux-arm64.gz"
      sha256 "693bca466acef40959178fc33a817bff16e2a639bb0b39036162a087845df35e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.36/finnest-linux-amd64.gz"
      sha256 "67cda34fe4631a6ccd7d4e61c1cf32d2404c2543262342f54063b9ad4b5c84d6"
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
