class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.21.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "e07f74a42ae78cef4cbc95ace02204278674ddc82783f1ab6ac6f2a2fc162e68"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "f4bdd22116cec1a5db2f0bb677767aa00ce44f2893a9b7a65e6c79ccd48207f2"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "66561eafa5e0620a596107b04c8dc350b29d7ba7731b07e3a99990a062dcad5d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "b9c0245212ac745a1846683956bc069e7c05e10dbde3270754cf604d42246707"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.1/finnest-darwin-arm64.gz"
      sha256 "62143687a662deb52821f7f76395f3b667816f91012140be4e551ae3a9a07f45"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.1/finnest-darwin-x64.gz"
      sha256 "46ba2839697195bb3ed5df0e665d80b228ecb83764bc793c415c25c247b96553"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.1/finnest-linux-arm64.gz"
      sha256 "d4c7bb43b1c1e13dc4fb24edce37de238636b53c7f6884e48005fd36d7f49206"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.1/finnest-linux-amd64.gz"
      sha256 "83c4db1394f5f2569c86d55105c8fd11e50fb95cdb433dfa312ea61c2152119c"
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
