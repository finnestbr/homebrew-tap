class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.36"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.36/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "da1a6ee593031950c05e9a25e769a66814cbea2c06387a8b8abaae28ad8375dd"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.36/finnest-runtime-darwin-x64.tar.gz"
      sha256 "1b6eff8c764b7b2bf6517873ae2cb98dd111fb3d5b7a9a28ca3ac6485b58cdf0"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.36/finnest-runtime-linux-arm64.tar.gz"
      sha256 "add1665974b583314b21368ed05be612c1b2da6560c4307e300668455659d102"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.36/finnest-runtime-linux-amd64.tar.gz"
      sha256 "0a578cd733dfb4f85c7abcce2e886466483cfcdabbfdb618b15d1e8ff669dc65"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.36/finnest-darwin-arm64.gz"
      sha256 "431f1c5be2c5d45ba7e3db666f81c1a869cf2eb15f5c1b10f7d957fabda53780"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.36/finnest-darwin-x64.gz"
      sha256 "58afe132d2655d21f09484ed595cb90c8a63f0b0f69f92e7bbaf7ce1fb9d0b8c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.36/finnest-linux-arm64.gz"
      sha256 "956541059ed67fff1798dedcd31a13b6b98410e0073aba9bcc8cdd46b56d2462"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.36/finnest-linux-amd64.gz"
      sha256 "ef847c941cf1fb447a2732876084b59a207cfb5f03716f4bce9f29f201dc8e35"
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
