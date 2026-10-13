class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.8"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.8/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "356ce260330a1b367da1871068cdd21e52a9cf302fddbbaf9716b629f60011b7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.8/finnest-runtime-darwin-x64.tar.gz"
      sha256 "1b703cf9fe9aea4c557dbc2211688d81337a841cca7ab84829e0b1bdfcfa9e63"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.8/finnest-runtime-linux-arm64.tar.gz"
      sha256 "f08011a40d8dd3b995fe7a9b79b8c990921491fa3dd2e4d4f6ff10d3f1cecd31"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.8/finnest-runtime-linux-amd64.tar.gz"
      sha256 "2a3a6104ad9ead09ce4af62624bc31a1dd937aac72746a391507bd6eca7ac6ef"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.8/finnest-darwin-arm64.gz"
      sha256 "cf6a4e7d4649a208c981c1a7998c350e7f3951a1bd8d4b32f14a211b53b4bdb6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.8/finnest-darwin-x64.gz"
      sha256 "b429dc41961362bf547a88dba91e62b3196ae1a695d1995afea31bb82c8ece48"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.8/finnest-linux-arm64.gz"
      sha256 "3173e456ebe9f631cb49f1df7fbb713b3efe2d2876e06e1db0667033a77d9ebe"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.8/finnest-linux-amd64.gz"
      sha256 "a17df0a33c0eb2d2b0e95c8fb49b2acc23616e999a17ffa3abc95bad18463ccb"
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
