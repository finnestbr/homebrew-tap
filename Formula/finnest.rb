class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.25"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.25/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "8c4cefa8c20dd05f45b67a822548aa37cf093ab31ace3e1445a09fba4f36e9d0"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.25/finnest-runtime-darwin-x64.tar.gz"
      sha256 "cec7ab07cacff219d8ae26fe5af993d6e0876d62f80381d4a69e803329d1e529"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.25/finnest-runtime-linux-arm64.tar.gz"
      sha256 "73bade1098b31a47d2b886380a77effff02312ce0d36398580f4897fda550af3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.25/finnest-runtime-linux-amd64.tar.gz"
      sha256 "c2f2a2b0463a40760d5f5d27a5a6f833294de182fdd23e3ededda19d7548ef93"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.25/finnest-darwin-arm64.gz"
      sha256 "a962d2356ad31e40293cb3db781528c5fcf42f55c70a78d261fba071510bc1db"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.25/finnest-darwin-x64.gz"
      sha256 "f3bc90df63701296899e874154c5f6bea53c44513b74500d061414749c1291d1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.25/finnest-linux-arm64.gz"
      sha256 "db638190e05b25396393eb4dfff6228d4f152cc956792ba2be9bb773a3265d08"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.25/finnest-linux-amd64.gz"
      sha256 "95b395d371df2f8a768141d7fe5e51ce11d27562fb1d8d2f66fd4ad40b27ff36"
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
