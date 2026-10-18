class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.22.2"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.2/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "ef452fb16786959a25950df3ebe1ece3bf45b129d2bfb2634e3fc8bfa021fc56"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.2/finnest-runtime-darwin-x64.tar.gz"
      sha256 "21e8d38cbbe85a490a68562e8f99dad85d5ea4801bc1e35eeae2e16dac01cd4d"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.2/finnest-runtime-linux-arm64.tar.gz"
      sha256 "ba32dd0aa5e99fdff4cb38f5a4a907e88ee3187cc802e428b2299eebc134d016"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.2/finnest-runtime-linux-amd64.tar.gz"
      sha256 "f696d48dd246020f087870febb2fa6f6707eb7b9325da76e3c013a4ef0b2e6f7"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.2/finnest-darwin-arm64.gz"
      sha256 "ff62f94dfeb01344f61f278b3255bbc9666518e12759831245cb38658517804b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.2/finnest-darwin-x64.gz"
      sha256 "df6a83cff95998a6d6e2eedddc5c2dcb6a4409dca22757b53d09d283f9de21eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.2/finnest-linux-arm64.gz"
      sha256 "2748b90350e88003be3c58d445f6fc27d71de8963e7a66d31bc7b9f60cd9438b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.2/finnest-linux-amd64.gz"
      sha256 "ddbe6c4d8e9781f4e4d5038302b0d57bb62345db2683d804d35538c72b8f976e"
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
