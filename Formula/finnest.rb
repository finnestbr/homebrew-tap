class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.22.3"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.3/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "21449e2892d2d6f91e4c795dfbefa6422c6b03741834942de0030496a378a07c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.3/finnest-runtime-darwin-x64.tar.gz"
      sha256 "ae89a408c8a83b1fd04e72707fa6be7800b9b005cb72f70fa67673d5abb3f29a"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.3/finnest-runtime-linux-arm64.tar.gz"
      sha256 "cb137637bd8d768974349fab2a44aecbf45a809b6fdd7651d61c3d4a47c06738"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.3/finnest-runtime-linux-amd64.tar.gz"
      sha256 "3d224950ab6bc5e344ee79b9de617af97d7e1faf7340720f29d6a5d985cf94f5"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.3/finnest-darwin-arm64.gz"
      sha256 "36d8836a62ce7a36303b28f161d40286a6891124f71edb744f4cfed951926c39"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.3/finnest-darwin-x64.gz"
      sha256 "92a43b7e568be607c3e4482b3932738d5526118427f4475bff83509dac3f2b31"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.3/finnest-linux-arm64.gz"
      sha256 "64a7b12646e97417111f30140e8a61140eb1de032d5a2a14db96d8fdaf8e9454"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.3/finnest-linux-amd64.gz"
      sha256 "6cd9d6899945fb9533d746208988b5b5dd6a9593fb789e9f7da02909b6be20ab"
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
