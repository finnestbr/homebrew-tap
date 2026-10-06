class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.15.7"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.7/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "72bf8a039311c0143c2b823fbd2c13250f301003e739f7946dea6bdeaaec9ad0"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.7/finnest-runtime-darwin-x64.tar.gz"
      sha256 "a34ff0a1f3c3be351194c2a5592400207e6cd8f14af9f45b9698654991ac9f29"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.7/finnest-runtime-linux-arm64.tar.gz"
      sha256 "55b46c3d8161a7707a99c154ec747c9a45b1b7473bfaff9d1ef0e3a966f53cf2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.7/finnest-runtime-linux-amd64.tar.gz"
      sha256 "8a0f95a6357a18b43255da3f7a8f63b19b65404c064b9640f6bafd4a312126d9"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.7/finnest-darwin-arm64.gz"
      sha256 "20e0b8263dbe042b8b5b113747cce86428573d7b31a2758b180b850691720c89"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.7/finnest-darwin-x64.gz"
      sha256 "7981ca5e463d0ad4827ccc4db5aaaaea513ede6d0dc40621ab423dd324841015"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.7/finnest-linux-arm64.gz"
      sha256 "7da10da09d4f4f0c6208b2534ed0f8e8ff352a8b2dcae0df4438dec4a2b371e6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.7/finnest-linux-amd64.gz"
      sha256 "fbdd085b3dbc748c63696d3547a7403be55ebebea903b762db74201e45039cbe"
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
