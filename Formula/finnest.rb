class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.29"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.29/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "4dc485a5807499beb761b29b4bf6f9ed2119d1212de02f6e267419fd3dc7b26d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.29/finnest-runtime-darwin-x64.tar.gz"
      sha256 "8d80772206c3ef4a2160d77f7b7d54f27080033e29d6fc55c693960fd583671c"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.29/finnest-runtime-linux-arm64.tar.gz"
      sha256 "540e7bf1b5e8e2e963881775ab5e14429c7a200b80cff4300d46d04ccac56ed5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.29/finnest-runtime-linux-amd64.tar.gz"
      sha256 "3734605f4f64aa5e378aa032668b8ca2d300aa856ad6eb719c849899b2a772bb"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.29/finnest-darwin-arm64.gz"
      sha256 "c1eb3dd4f7b4a70e7646796ea1640b0059495ef58a0689d73a0278bc30163f50"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.29/finnest-darwin-x64.gz"
      sha256 "1d3d3d2c3c2fddec4055db0fc5d4a4f0df1ce7cafcd4d344c5e9e9b4cd1b6413"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.29/finnest-linux-arm64.gz"
      sha256 "d89479a551af3dbc5f8a2633a6881ec619cda00192313860ae7e8dd702efb743"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.29/finnest-linux-amd64.gz"
      sha256 "e66568fab85a02127579ab6142158b280de8e15b11d37f9ecf8e790e9fc4c32e"
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
