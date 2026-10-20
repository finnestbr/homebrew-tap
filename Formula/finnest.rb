class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.25.2"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.2/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "23118106bd398912d8760c0ab6c071187588defe54662dc1843d06585fdbebc2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.2/finnest-runtime-darwin-x64.tar.gz"
      sha256 "a2430441fe7cd0cb5f6db5a4df9100753cb01a252f33bc32506abe0e674e6f3e"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.2/finnest-runtime-linux-arm64.tar.gz"
      sha256 "6f8fc3ed9624043f3aba4840549e3a18120c9d349bb076e93769e3cb6995ecf7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.2/finnest-runtime-linux-amd64.tar.gz"
      sha256 "9e02613f743667ef2e942613ebe0b6f4255274f048a8c76ebb56d95ad63576fc"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.2/finnest-darwin-arm64.gz"
      sha256 "9637185420059db6dc4818dfc0c4d4d8589a4ae95f74689e597d2e7d8e051b44"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.2/finnest-darwin-x64.gz"
      sha256 "6d1123d520e5b4df1a536b2a428e69769b87dd2354827722692c9420e15710a5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.2/finnest-linux-arm64.gz"
      sha256 "b9a4ed3c787f1cf099afab44c86d34dc0fdb856eb2306c935b91cd9c335bb0ac"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.2/finnest-linux-amd64.gz"
      sha256 "49faca9971cad3d01e9d038f4c16a850d353ad57e2ad029a54cd6d6665801d59"
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
