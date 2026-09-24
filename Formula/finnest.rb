class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.35"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.35/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "8f495be0caaeeca670abc9f6b5c7a9e11e4de896d1eaf2731d060c77b9c2a3a3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.35/finnest-runtime-darwin-x64.tar.gz"
      sha256 "ff7d69e397166e096df41a3a16f44776748d3a095e7730465b66a23534767e7d"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.35/finnest-runtime-linux-arm64.tar.gz"
      sha256 "f8b7a7a468c3454314b07f1f21f7f0cb592d3b2709bf5fbd0a937d7cdcb8ca26"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.35/finnest-runtime-linux-amd64.tar.gz"
      sha256 "7c546b94b5c3f8a11e113cd93e60fc9da725d998e74047092190bc2919c7f0fc"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.35/finnest-darwin-arm64.gz"
      sha256 "41e3c0f6e67ded5d15da6ab872a5f9853c25da8c61d175a1810ba530517d3297"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.35/finnest-darwin-x64.gz"
      sha256 "98cccae8a6abac73c43f7860836319802ec6ba78e0ffb7b26453a09ea9b35b00"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.35/finnest-linux-arm64.gz"
      sha256 "e42b3c2f329f0e28971cb3521c18137f7f9397c60bf50d718bf6f4efffab6dcb"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.35/finnest-linux-amd64.gz"
      sha256 "f35c1f7dc31fc8556469b5e1ccfed23a533f86262d4d8103b20713d2c3433f11"
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
