class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.45"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.45/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "da09f1a51d15cf45c6ceab38d37ad0869f62ecd8f576ae2e185c1e8fa2bc6969"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.45/finnest-runtime-darwin-x64.tar.gz"
      sha256 "8d99678d155bae59da13350a88a087bdf34b538d1f0e4accba8519c828061b7e"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.45/finnest-runtime-linux-arm64.tar.gz"
      sha256 "3e6bba1917a2e00373083607bead2d31804bac5b743bb4abd2671a43474e56f5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.45/finnest-runtime-linux-amd64.tar.gz"
      sha256 "3525757bc1fc3453fa929ab1e9384083787c7de2f3b366048aec4c40fcc50c67"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.45/finnest-darwin-arm64.gz"
      sha256 "449d15943c295af4285fb495af80987917be34a5ac6e2f38e8fa4d130177e878"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.45/finnest-darwin-x64.gz"
      sha256 "d7c089a394e451efc6a193b6be66d976a66f6c1b44c43283f7a20a3e83c134c2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.45/finnest-linux-arm64.gz"
      sha256 "c8662f4fcbe2e2b0905811bb827216f85ee487eb2f17122b02329c4d606ff445"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.45/finnest-linux-amd64.gz"
      sha256 "f4f323d816503f8f9f475bc301b52ba151e1cc9fe484380e4d5a72f59b9298e7"
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
