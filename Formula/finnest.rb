class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.26.2"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.2/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "10a55e7844aedbaf57d8ee2d56d5fa8868084aa28c702299b50f0c89525b22f9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.2/finnest-runtime-darwin-x64.tar.gz"
      sha256 "dc3456d7f2c4e33bc73a93300d0d547f33bafea8f5ffc617d90cfc4813666fca"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.2/finnest-runtime-linux-arm64.tar.gz"
      sha256 "0447076b4fd883edc3037de7cb28684d45b6bd0443f090fd649d85382ff7e3ea"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.2/finnest-runtime-linux-amd64.tar.gz"
      sha256 "81a5158dcaa355f585821d836dded554660628bec81a1ffd8e187388e1756cae"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.2/finnest-darwin-arm64.gz"
      sha256 "707cbd86f84e6bc87c7f20cf995ee71e1d5c1c280f182ef93ed935197efc0d82"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.2/finnest-darwin-x64.gz"
      sha256 "b425c3b63141a96084426b350ba3fe56a4f9865e160b00385714736cad5a413f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.2/finnest-linux-arm64.gz"
      sha256 "e97dd427b7d7bb7d30978c8c3ed9616390b5e211ca4be42f6e2d900ebba54ded"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.2/finnest-linux-amd64.gz"
      sha256 "27b89a32d49ce586ca8fb6d81ff8b5924ede13b0488836eadfb4a024d71d4295"
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
