class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.15.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "035776900224411f51c4c481e254b17be039ddb05f0a2d75987f2518b6f462db"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "85f0494c9907718748715566df7ae2e8f18fcae6a76699991ead83bec902c0a3"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "6b5561becdac5f5d334dee51cc27ba0a991ab2ff1fb5f980d5ebbd5b33ffe4bc"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "4fcd805c374511c08c437a42e4f80f7bf11a3d39419dc035ee27d7209f812bab"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.0/finnest-darwin-arm64.gz"
      sha256 "a46fc9cb42e2ecfe3eb06e59261998c841a5465ed66abcef62926713d7ddd05b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.0/finnest-darwin-x64.gz"
      sha256 "3ec5cf26373bbc94923b95657a3e57fb76669112c5eb87edc2070bf860a8f5ed"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.0/finnest-linux-arm64.gz"
      sha256 "0299ab63769f37ab0d4616fca4c772ebf7d0e0a558e5ca661c4f6f3e288e744e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.0/finnest-linux-amd64.gz"
      sha256 "5d6a3db369a32d31b3884f7fdf7b2c2e8c2dbb2e6c5ecf7888c42a0084e92955"
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
