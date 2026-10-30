class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.28.10"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.10/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "4e2b7ce2d3790cc19ded6d42846861406993c5d7b849392c2ad8553fff183390"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.10/finnest-runtime-darwin-x64.tar.gz"
      sha256 "ac0e0b97b81f3b645876d816edb6790fb2fb9e701970ddf265761d2ecf67d724"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.10/finnest-runtime-linux-arm64.tar.gz"
      sha256 "be40a00bd99b2d041f22d21320d4690af55ec41cec91a02853a66adfec440e3c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.10/finnest-runtime-linux-amd64.tar.gz"
      sha256 "6405ac8809e629abb988f8fc1c021cf91c06ad7484aec3057b1ef527acd8c11f"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.10/finnest-darwin-arm64.gz"
      sha256 "5cf3369c426487fba1f691b0f26361612a3e07fed34443ba6e8ebcbb9c659d71"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.10/finnest-darwin-x64.gz"
      sha256 "c172345c3c6d89f3999e6d274d44ea22dee0a3ba0b790397d87eb6ada02b90b5"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.10/finnest-linux-arm64.gz"
      sha256 "753127599607b3e7cda5e1927fe7a43c2fc3deffcd25132f8bb3a6dee95a5ef5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.10/finnest-linux-amd64.gz"
      sha256 "39bd3b638048610e4cf5ed469b97fc9f24c093d5d9dd1c02c5bf8af1da40c473"
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
