class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.24.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "36b2f5b99973cd5793cbc2b337b889134621d546642a777ab03fa47d2201f6da"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "e3e4b3378d55bc0aca754d2c1df1a1a47d97042c16037710b1f89910136fa82f"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "75e806ae54b55887f5e9aef94ed63c2ad2b66e294d576cb46db36d77f13df88d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "fe9274836c188d0cec83f81c882f3aa6450fed365178c541b783db9a88742a90"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.0/finnest-darwin-arm64.gz"
      sha256 "416aebf27fcb08a8fb5acda7b8ce44ac9d755cae954ca6a3703499f5ccd08f78"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.0/finnest-darwin-x64.gz"
      sha256 "b978b836252648ac552de58cd494225a146b6fab6fca53b2c420fbf0d2053643"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.0/finnest-linux-arm64.gz"
      sha256 "30bcb714fdddce72a932e4d6542887c788089ddc7c26134c83a67648fbb321b2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.24.0/finnest-linux-amd64.gz"
      sha256 "b1099596b5dba186c741f754b2f01508433a18f9a1f932de8b0d3dde4bf82b7b"
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
