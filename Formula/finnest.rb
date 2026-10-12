class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.3"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.3/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "7bd926c87a91ed974f4e9101e105ca6e541b3f4d007f8fc672aab5088448d077"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.3/finnest-runtime-darwin-x64.tar.gz"
      sha256 "0da75a5bf5d2c0974b2f8174aa935eeaa326dbbedf6bf1dbed86c81854936794"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.3/finnest-runtime-linux-arm64.tar.gz"
      sha256 "2b78d73b70a7a0c8b515d9cd50f5b76bc09ca397584ab667173c57ec3ee41495"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.3/finnest-runtime-linux-amd64.tar.gz"
      sha256 "e5dd742691ba2c39795a7ac04975e74b7fc11a0f1a4db1f6092cb7e530a85630"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.3/finnest-darwin-arm64.gz"
      sha256 "eb0acf2326f801228e4dd198d406b3570157c80e9c9dcaccf18a164ac7a2715e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.3/finnest-darwin-x64.gz"
      sha256 "b402fb934964eaad3983ff4f5e0065d513a1da8a4960ff8077f2d3b07c14d3a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.3/finnest-linux-arm64.gz"
      sha256 "debd2383b30775d4d4abb32e05692bac5e16aa09222806e079c7b136aa562734"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.3/finnest-linux-amd64.gz"
      sha256 "3f6aea9009d9442f18eae6b1cc7745089a10943ca39bdd3021435122d3b47a8e"
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
