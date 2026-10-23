class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.27.15"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.15/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "362034c7fca924d5599777471a30814cc35cfa2612d2b7e09794e691d5f7a6f2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.15/finnest-runtime-darwin-x64.tar.gz"
      sha256 "5f5d7b736e350bdbb24f9a0231a1c864926dd6189bd7cac166ad58493304c2c7"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.15/finnest-runtime-linux-arm64.tar.gz"
      sha256 "5bda69dc6c63dd8e89e23f11c8566bc1e40136d6c7a1dbb4b135b7ebe5224345"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.15/finnest-runtime-linux-amd64.tar.gz"
      sha256 "0735d919950b6500b571aba57be977c96e9a664d85dbad59a6b54a2e8d5feb7f"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.15/finnest-darwin-arm64.gz"
      sha256 "68e9b804fb8057ecd6139df1741bc491806ccbdf72952dc5b7f0b27390032872"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.15/finnest-darwin-x64.gz"
      sha256 "2b5d1d1bc9eb6ecdde7834998e07f893f2f5528447cd2a8241ff8b5769158fbd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.15/finnest-linux-arm64.gz"
      sha256 "c0896e1837e7618215bfb74910c5e635fdc7dd3bf9566e597bdf50aec11a85be"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.15/finnest-linux-amd64.gz"
      sha256 "8f1242fa6d84f158dad96c898d641a1758a8220fb7bb20e439a0b6fb16660d4a"
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
