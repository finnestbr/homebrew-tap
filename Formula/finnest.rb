class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.28.8"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.8/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "4230e0e61fc96aba026193a62faf737d2bb2f2cb663c92577575628e0656c07f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.8/finnest-runtime-darwin-x64.tar.gz"
      sha256 "e396f12221d20366059db7458a81e84c26ab4e6c437cc6bd0c95e8931826e8a6"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.8/finnest-runtime-linux-arm64.tar.gz"
      sha256 "21b49e79f73e0669090e2c1aee2fcddba5d50410bd12d79b4cb35fa20dceae88"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.8/finnest-runtime-linux-amd64.tar.gz"
      sha256 "2ba3ff1a3d9131554fca75bb3b4f2ffd45859c6f3be2e189e755180b30566fcd"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.8/finnest-darwin-arm64.gz"
      sha256 "084d2bb2b32c3234e9a0214d2c8396fcd55c21ac0e02446968d0284ae7857dce"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.8/finnest-darwin-x64.gz"
      sha256 "1a3c746ba9c26ac93be95a7b157bee0f273210ed616d2a0eb487653c5b786263"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.8/finnest-linux-arm64.gz"
      sha256 "9858746cd8314c5f3012ea254af8022e737541524090ba15b259c76ad9b0f69c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.8/finnest-linux-amd64.gz"
      sha256 "659b760fb17a34eab23fd56cf499258223af69c11983837383d52fce23cd82e9"
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
