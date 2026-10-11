class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.17.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "7ccca042dc7d25a0e0468c53a1a1eb1418b9f2e62258ab1cc271ba289ba0c269"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "8006c99ceb1fbe8feac2f1a082c2f26d24d337c8fe0b6f722b003884e5b2c556"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "3af62bc622d0fb7153e86351741f10f1eff3a299dc2d94dc1cb48cf2aa4c516d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "ebbebc7d8de811ad21cc5d6f36ab48fe5b542b3d232bfc39c6392bd51afe074b"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.1/finnest-darwin-arm64.gz"
      sha256 "bed2460a3d1c9a711bd9881a668433bb70507161ced2b78a9560afa0fd8b3a9d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.1/finnest-darwin-x64.gz"
      sha256 "1118d15d2946f9b85dd4088e74779ef5f27e7a79109bafea8950003840266f87"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.1/finnest-linux-arm64.gz"
      sha256 "d93d7e707a01929bbbd5ed7e46d090f7c06c367af87de6b431886d328790226f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.17.1/finnest-linux-amd64.gz"
      sha256 "e0d36564d19826b4d8c8ab8b746b4b25d619eb2ad13505ff0d14af831bc2e366"
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
