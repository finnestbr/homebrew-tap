class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.15.5"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.5/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "fa795cd53dd8362842e22c99eac228b35b203a2b9ff986b846d290b6d34be6b5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.5/finnest-runtime-darwin-x64.tar.gz"
      sha256 "c3efa85f588571d179a4c90efe0c5ec80e96f634bc9a46860c54f174846b58a5"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.5/finnest-runtime-linux-arm64.tar.gz"
      sha256 "fa54fb16a29a8e511c18ecf3c28692c31765604cc885aaffdd822ad03924d58d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.5/finnest-runtime-linux-amd64.tar.gz"
      sha256 "75045b33da47177fcd951cc95879fc8806e860b0090a66ef2ce5a7ba4b66c16f"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.5/finnest-darwin-arm64.gz"
      sha256 "831b02b911b0c074e16228871342894061ab5c29a99f31444d1f1504f466683e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.5/finnest-darwin-x64.gz"
      sha256 "0d8637aea122c580dbd5fc3484a21eb6f5295d15d005ae757d738cb59aa59f9a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.5/finnest-linux-arm64.gz"
      sha256 "a6494dd647b334a2ecbba9fda08338b864ea754c45a0be3c09523f4cd9f7223a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.5/finnest-linux-amd64.gz"
      sha256 "c8169b4e78da2ff41690f5bf2bda4aa45fa0a2c9e746c537e051af23c8f42cff"
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
