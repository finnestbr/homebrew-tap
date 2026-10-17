class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.21.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "feac530bf1199ddbbf45b60ac51641d4d365397e8d3eab723872dff6b31253ce"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "57443c491d7aa1c5366fb9663066eb6c36a143f2d1cdddbd6b9a42f00a3ff8d8"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "58cca8bef99ebd8b9afefcded3b097c86307b8a20f4b11b6e59ee90324c870ae"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "269dfb7c832aac8b80afe410dc91f722ed7c00214e26b57b5a49360292111d5c"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.0/finnest-darwin-arm64.gz"
      sha256 "24af3e19baf3f65543ffc148d9fefe56a161978f04b3ab599ea4ca016e99094c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.0/finnest-darwin-x64.gz"
      sha256 "2d889d703c7a3b6f89919f17eb2b5f3f004cf90cfbfdf9032fcf1846f9bc29a4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.0/finnest-linux-arm64.gz"
      sha256 "4bf953c8b7a073c7f26563b11af4f4b78adab19118940d322085c81f33428192"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.0/finnest-linux-amd64.gz"
      sha256 "9525bd53f6fc556cc58070072b50ed6a28b42101a45f2478075a90f7b40612f5"
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
