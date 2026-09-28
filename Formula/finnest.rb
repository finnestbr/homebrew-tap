class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.43"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.43/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "69a77ce50930d03c94f66eba05700bd89dcc0036faf8c9819d289d12bbb03b02"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.43/finnest-runtime-darwin-x64.tar.gz"
      sha256 "d358fd6cfea900323d794fcfaf1950e8598d9c91ca96cd5eea40c10a7b29610b"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.43/finnest-runtime-linux-arm64.tar.gz"
      sha256 "4402ce9a8d2639064b141f2a69719a4c78481a92a3e00d93763a7c102a89f544"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.43/finnest-runtime-linux-amd64.tar.gz"
      sha256 "ceb3e39276a521604f78e62eb880a9c764939db0e4d0e8d94a8750a139da08af"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.43/finnest-darwin-arm64.gz"
      sha256 "0df0442eb7489a0d60a0125456705513e20c801050073a8e5e408327e90ee811"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.43/finnest-darwin-x64.gz"
      sha256 "8809450c6c80b4d35dc6db30bd4f80c2c70e23cfdad1c4382c982f19a26196b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.43/finnest-linux-arm64.gz"
      sha256 "1196911757ae063b62841dad968f1f3d9eb0473387ccdc25e892957b30869bdd"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.43/finnest-linux-amd64.gz"
      sha256 "65761787793e9386b50675a5e7941be3b4d324f1e5d1b295fb59e042ce89e01b"
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
