class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.33"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.33/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "aba40afb01b84dfbd656cc838d4ad6e50ca0d25618883bfa0a86c291e9eeb677"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.33/finnest-runtime-darwin-x64.tar.gz"
      sha256 "51c4ba612e63fa9320a1786e18902de767862aff64060282dfba5fcc3438bd73"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.33/finnest-runtime-linux-arm64.tar.gz"
      sha256 "4d0bb7cd5029b7393372842f4df7725f6e0643ec1c17d3cc10e8a02ebd01ccd6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.33/finnest-runtime-linux-amd64.tar.gz"
      sha256 "acbefaa1a4097600a9e7dcacc6ab19beeb45e2a9fb0f0ab228b8e46d837839c1"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.33/finnest-darwin-arm64.gz"
      sha256 "0bae65b64d7be773b7d44779333590ee26409894e07c444f20ec785c811ab9e9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.33/finnest-darwin-x64.gz"
      sha256 "c1eb0e7b25bb9afef5354e31cccca797a66468682bf0b4de99c21f1283dc5700"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.33/finnest-linux-arm64.gz"
      sha256 "3b63cc63a2f83df86fe89370ce7a7bcc0960f3130a1175bd73035cee6008e49d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.33/finnest-linux-amd64.gz"
      sha256 "f85509606b9d6f8b6c140d6bca9464fd263dc69ff8e5778f0bb902246fe7a436"
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
