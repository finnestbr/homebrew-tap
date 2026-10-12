class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "05855e78efd2ad017bfb68af7e15df4d7fca79899decb26c9168d43413608c55"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "612f2519f981da25d4e501557a0db96e4b40037c836762ff624278fc7d6208ce"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "a3324af983e719da3baad5fa06e9a75b206cbd95a1259a5a050d9ca2d5784e55"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "20466675669bbe1a1df528eb2d583082741c943d3279c2fb2a185673f264327f"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.1/finnest-darwin-arm64.gz"
      sha256 "e8b87bc45ef667eb81ecb98f22e75e91bda9191c07956aeceb05ca740aa09b8b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.1/finnest-darwin-x64.gz"
      sha256 "164b73e66da66b3f7a1a57b4ee1d374a28f7eedabf0c04e05b66a09b75d2e50a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.1/finnest-linux-arm64.gz"
      sha256 "c495bbf0ee5e29165db8d527d2df9b262e7daba19c80196e2545780282fd7950"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.1/finnest-linux-amd64.gz"
      sha256 "fd42d06b446a77df8784db4285b00da52a12c13bba12ea1defd8a91c5b318516"
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
