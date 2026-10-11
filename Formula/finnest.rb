class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "292547198ecb121e07104d7e3f8cacede94bdc808a36572ef8840465d7a89439"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "a8dfd0feb453f1b09436182d7e32ff4ab42ebb01d13fde99f9c66021e20a7ccf"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "cde454af3e89b71974da3dc327c46b4b03055f8153aab1b6140219bd15656ecd"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "f64866866ff2ecf4c606ea6c52a9097460fb054b97aced47ea1070d7523bfd19"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.0/finnest-darwin-arm64.gz"
      sha256 "576e701344b63405863f8bf81420e3fe6c461883ebb956977442ecbfaa4fc4d0"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.0/finnest-darwin-x64.gz"
      sha256 "a0e400e800f73aef32a9f04afce855d97cd68ae8620df6d89c1a720c9c5855b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.0/finnest-linux-arm64.gz"
      sha256 "893d3a29dee18ac4b79397fedeb7cba4957c6d31a71187d1405071bfbcd28028"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.0/finnest-linux-amd64.gz"
      sha256 "96d499b6bdc68d74f4089a2a8e1df011975f753fd6b8646457dcc9ece93a4260"
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
