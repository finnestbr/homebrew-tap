class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.15.3"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.3/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "ff1c69110aaaa4984cd31ffdf2971740381e93bbed80c2b9f773447540ed1458"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.3/finnest-runtime-darwin-x64.tar.gz"
      sha256 "cd59c3e90cb291e6b75052064d49c46e84d86fee0261af2f242e7e870be567a8"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.3/finnest-runtime-linux-arm64.tar.gz"
      sha256 "250381b6f798fe5f1b06e11e4cf7daa056bdf2b481d7d1a983548b2c2a71fac1"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.3/finnest-runtime-linux-amd64.tar.gz"
      sha256 "883c5c65c6a1fa827de6c7acfbfd016e8cd76bf3c75b26f452e1c0d8aa2ab4be"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.3/finnest-darwin-arm64.gz"
      sha256 "97ea3b2ced59b08f313e6c791ec26f2a84aa45a0682d98799905e1e4de34cec8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.3/finnest-darwin-x64.gz"
      sha256 "f83402803f2389269c9cfb99a72d8a578320ec1025bedbca36bdad005477f429"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.3/finnest-linux-arm64.gz"
      sha256 "95b5e031395c5ac190217dc28277044b77c75a7c40750bb4e6efc0ae818cdd6b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.3/finnest-linux-amd64.gz"
      sha256 "7565897d4d02ded731b2e61a09c717a81964a16e6e667d3f381bdbede7cef49e"
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
