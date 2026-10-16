class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.27"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.27/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "a864c7073a35bf7034b7017c8f6e8544b8f4df66bbe28daeecaa629decfd03b5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.27/finnest-runtime-darwin-x64.tar.gz"
      sha256 "70bfb7bff4ab624ffb8103fe6206bcd1c8a0392f0a25c09c51b8645f9a6ccc95"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.27/finnest-runtime-linux-arm64.tar.gz"
      sha256 "508a841efca62376c7c86dd637d5b4a9c6d32cd8f64bcdf52b4da69059f79079"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.27/finnest-runtime-linux-amd64.tar.gz"
      sha256 "60dbcea3bba4a29907bc53bcbcb12c1a3b4944a874aa181927046b5d3db7dfbb"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.27/finnest-darwin-arm64.gz"
      sha256 "d344044bd0a1175427b45f0061faa6e07faec69cf1cefe8ece654261e798e5e8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.27/finnest-darwin-x64.gz"
      sha256 "172760532824c492ccc78762738d6b3395157dc7a2fb8cd1666d16290ad192a0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.27/finnest-linux-arm64.gz"
      sha256 "3b8593880c6adef8737c8ad3369f7c7bcae4043560c57854c97f2032a3a2ed37"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.27/finnest-linux-amd64.gz"
      sha256 "82e4151829ee09e87e2c1eef49ab9c0f1a003b45c0718a5d37bc7112385d74b9"
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
