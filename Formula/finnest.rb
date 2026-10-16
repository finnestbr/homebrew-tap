class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.32"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.32/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "e665e3f4bec1bf3131679ebc148e60656d0123bff8a5f49cb813dca0d4313184"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.32/finnest-runtime-darwin-x64.tar.gz"
      sha256 "ea50f437784868fcbf3509c43745156b4888e8d9883cbcafc8b7a815d6392d50"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.32/finnest-runtime-linux-arm64.tar.gz"
      sha256 "77d5a567dea0a5e489ab69587258a8acc8729de6e8d57d504719c370133d96bf"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.32/finnest-runtime-linux-amd64.tar.gz"
      sha256 "9eba4bc31fd9802d20a75868d82ab1b82e2b1041435fc83a0ab2c8e21530d560"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.32/finnest-darwin-arm64.gz"
      sha256 "0e3c3d0afc105090b177b68c0122a32f5c4226a43e73bc221ecf826c7fe713a2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.32/finnest-darwin-x64.gz"
      sha256 "330aad9dee5ebb3ad2a2ee032943809384570176cb5bf72ebc43f9566f17cf6c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.32/finnest-linux-arm64.gz"
      sha256 "80e1048e9a12541560fe60d26cf4400533051b9aca52aee759dff1c4c92a7b06"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.32/finnest-linux-amd64.gz"
      sha256 "dddc8f40e1b38882c6bfe58782f1d962fd0b72e9c6208ddd67bc4610063f1db3"
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
