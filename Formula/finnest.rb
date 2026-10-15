class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.20"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.20/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "85269965b5149b4b72d9795e70ba965bd91bd119d2fb997ca3f7f01f1e70fefd"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.20/finnest-runtime-darwin-x64.tar.gz"
      sha256 "f16cb130cb6438942acb3ceb86b5e149ef40edd0c75e22ada2680c8fa0c91fea"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.20/finnest-runtime-linux-arm64.tar.gz"
      sha256 "6427ff693d743f56b2c1d0a3c4a9f68bac873c0ca207dfdfdcdce0b667e904c4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.20/finnest-runtime-linux-amd64.tar.gz"
      sha256 "44a58aa2504a873c2d5041d6ca1c649c5be2dba77ed5da264b378b9de7b11f49"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.20/finnest-darwin-arm64.gz"
      sha256 "58caa214760ed91c0b98307514ceea912b6ecfacc0b999638408f1745e468535"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.20/finnest-darwin-x64.gz"
      sha256 "dc6723d059bf141a6d69e9f28c6e80f41bf922f303dd51000cb7b030e78f222d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.20/finnest-linux-arm64.gz"
      sha256 "7cec9ab18a52b2a3c816f3a23fc243324f4a32c7e7588f0ec793f3559e9c1cd8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.20/finnest-linux-amd64.gz"
      sha256 "b93e31877c705215e78c2e69fd56bfa0aa47f41d9a91b2eeda717168ae1e25a7"
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
