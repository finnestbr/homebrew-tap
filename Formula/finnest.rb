class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.26.3"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.3/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "75ac7cbd06466aa34f5e71280344fc70427a350ae5d6b47beb6fdd565344c0cb"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.3/finnest-runtime-darwin-x64.tar.gz"
      sha256 "e18067806466716e80c45aca83d0b6ea67bef1d89b1be086560426b4f1a2f830"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.3/finnest-runtime-linux-arm64.tar.gz"
      sha256 "8e58b05772143bc5f1e2c7c98ad40784587b7174c3b74f9e4a584108d948aa43"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.3/finnest-runtime-linux-amd64.tar.gz"
      sha256 "ed288599e8a36a21ffbe437e53244bbc7b45d6b5f2404b22cf5ae2b4ce73e05d"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.3/finnest-darwin-arm64.gz"
      sha256 "4ef943b0b4206ae7ea927864e4baeb383f27c6b5c034955eb16af6eabff092d2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.3/finnest-darwin-x64.gz"
      sha256 "9b383611d2fcf53744a86cd694dcf95b1e45985b3cf73c0edab4633b11448405"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.3/finnest-linux-arm64.gz"
      sha256 "c32272383d443c87b483f497b449f1c27785785ec34d5a3f879134fd509ed1c5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.26.3/finnest-linux-amd64.gz"
      sha256 "2edd1f5610929f40af8846708b85d86eb0776210fbe97023f0fbed79580f0295"
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
