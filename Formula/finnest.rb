class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.30"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.30/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "4ea2df4605b6ce3a2d00576b28fed3907523472c3bdf22f10c471db36459c889"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.30/finnest-runtime-darwin-x64.tar.gz"
      sha256 "9252de0aaa341a32a41272c0b424aea035fb9aeaab5383595de952b7e5c5ee8b"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.30/finnest-runtime-linux-arm64.tar.gz"
      sha256 "65d862531c060e8cac1e72d24a23622e03c47c61ce953968b499ca5ae8c1b410"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.30/finnest-runtime-linux-amd64.tar.gz"
      sha256 "fec1f78de490ba94fce715e1cb3e1a5304528df8f32ad56e7cafee48d247acb6"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.30/finnest-darwin-arm64.gz"
      sha256 "4654538bcc8f06efb20d31f0e9f7bcbd986e2ab62348cc363ce2cba43a07c1e2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.30/finnest-darwin-x64.gz"
      sha256 "f0feb329d6dfe3b6c8f0ddd40542aafa6f16722f60bd570b1f9d35ec6a63224b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.30/finnest-linux-arm64.gz"
      sha256 "f379d8ed85f608ede69784c4608eb8089666e8668959e87e15a7f3c2a1177fb5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.30/finnest-linux-amd64.gz"
      sha256 "6e63398643f13a7a1ad55e81bd3cd7d3ff37ac94fc7888ee96c3de796abbf82b"
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
