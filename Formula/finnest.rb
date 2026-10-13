class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.12"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.12/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "b07cca0b313776ca47e4e1da36b1151baf1d8da1f7a5a25f629d7165576078fc"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.12/finnest-runtime-darwin-x64.tar.gz"
      sha256 "52aa6220145c0bcd9d753b60d09b20c42bf4e7029d0bb80adb0da06e728332c0"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.12/finnest-runtime-linux-arm64.tar.gz"
      sha256 "6a2b45fe311c4983df5038ec2565f1c2f95ddd46ba0ebc15ad68beca492e5acc"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.12/finnest-runtime-linux-amd64.tar.gz"
      sha256 "600b72f15f214979ca29b6b7bbb4bd5a03b7dfd7d8f46e3c74f0c04e99a71224"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.12/finnest-darwin-arm64.gz"
      sha256 "1cf038ac33f12e54f3e46e3940e58c86bf26ff36f106950170b7e1f24792f41d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.12/finnest-darwin-x64.gz"
      sha256 "4cdab96097b011de778ac1c0ab3d6d90789663f3e31a6faa6e06813b18ae7d67"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.12/finnest-linux-arm64.gz"
      sha256 "28b88dbe4e2998a0f23aa9df8b80f06903949dee00515f500d96c16981c2e2d6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.12/finnest-linux-amd64.gz"
      sha256 "f346b73cde766a24e72ed88bf1c8d64612299cbfdc45966fa0b44c9c17086eed"
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
