class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.29.7"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.7/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "5b71dea0d087fd5991fa1c890de01b76d849f67bb06962949264d5f83cedc2e8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.7/finnest-runtime-darwin-x64.tar.gz"
      sha256 "9bf9583cad7f6e5812b125b30271588303c548baaa65b71792e96bed59bbf049"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.7/finnest-runtime-linux-arm64.tar.gz"
      sha256 "e6feca1dec8259f3254d69a80660a12c9281cd4bc8592486cf0efb09cb0b82e3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.7/finnest-runtime-linux-amd64.tar.gz"
      sha256 "d5e9b0fe71c65db42bfb5fa1ec706bf33f35a544ec696d5c049aa1a18dec7dc3"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.7/finnest-darwin-arm64.gz"
      sha256 "8194a126ac2db814d43a5bc2de3e786c7d6090040659df51b2875c44bc624b16"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.7/finnest-darwin-x64.gz"
      sha256 "15ade1ca0c95c0ba7b15150fcf1189baeb68ad1e189f07e695bb9942bfb7d9b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.7/finnest-linux-arm64.gz"
      sha256 "b9c36192cb7b79055919af0da7d3ad3e005600d8b0349109ae8e4ba45429922c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.7/finnest-linux-amd64.gz"
      sha256 "4c1624a47a5e9f7c94a1de6531acc5030f3dd3cef062b5de8f160449f452c9c5"
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
