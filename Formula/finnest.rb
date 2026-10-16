class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.31"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.31/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "6af778ed227a6d4eedccba7b26ff0927b49c8bf53821069afbf60903b4a2d115"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.31/finnest-runtime-darwin-x64.tar.gz"
      sha256 "df1641e6b8270af4918b832a49360b2755e7984904e79331f8d8cf599cfbe6b9"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.31/finnest-runtime-linux-arm64.tar.gz"
      sha256 "cd4b58ee4d9a7175c18460d56ffd38a677c52d6cbc215a67c92878fdeee2983b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.31/finnest-runtime-linux-amd64.tar.gz"
      sha256 "8f1859a8144b804ae2adb198987545a69943955dc9f1ba36f3c0cd5440dfdbd4"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.31/finnest-darwin-arm64.gz"
      sha256 "ee60f0d8c18f1b072bc31dab3b4b9b74a25ba03f903210dcc4d67e43b36713bd"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.31/finnest-darwin-x64.gz"
      sha256 "ed17dcb621390843b341b153b4c37f72fe2e5b374d2396cdc3ca2403a5fd8f2b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.31/finnest-linux-arm64.gz"
      sha256 "762b0ec939d6648fa9b0d2a2094094d2e501ae00bfe4ababb846f859d9072d92"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.31/finnest-linux-amd64.gz"
      sha256 "35613087ff737a5e0945e9469c13d31e51cfeaa03b12f5e955c10355604473e7"
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
