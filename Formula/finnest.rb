class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.11"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.11/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "3d84b7fbf4b12638d974642ecccdc080912891dbf98b53f1d6b9834de0a30cf6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.11/finnest-runtime-darwin-x64.tar.gz"
      sha256 "b8a88a3c43bbf70a68bab65f26b77f1029c0f22e05af6fdc26ab75b7ac487e44"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.11/finnest-runtime-linux-arm64.tar.gz"
      sha256 "3087ca48dd6f2b1372631d72f533e957a800581014eccff942e3aa8262881799"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.11/finnest-runtime-linux-amd64.tar.gz"
      sha256 "0e42f2ce790d05fe9b264707da8d957cd33945c97035715473b5daf261f1208c"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.11/finnest-darwin-arm64.gz"
      sha256 "d73c5927004cbfe6b632ac1883771cb38c5d85e510acf2da4b19786afd357dc9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.11/finnest-darwin-x64.gz"
      sha256 "0d430504e5323e2b83916aea37d05cff329480ef42839f8147cd6ea5c654bd1b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.11/finnest-linux-arm64.gz"
      sha256 "ccb14484d3ac7d9a0d2a2f19d6d4c331b140df8c2ab961b1d62cf23031438c2c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.11/finnest-linux-amd64.gz"
      sha256 "a0b09b8724fd796dfe9601c2dbac09e3d8a20195bc8f726efaa588a8795600ef"
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
