class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.28.9"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.9/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "b605258bc07536f68a95f5de4599fa9845e024193c2984126e3c82609555d5f4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.9/finnest-runtime-darwin-x64.tar.gz"
      sha256 "aa2dc055c0af21d8b175d32ffa1dde6ec8d7b615a9f6d4321f6fb95524c03c0c"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.9/finnest-runtime-linux-arm64.tar.gz"
      sha256 "8aeb51785dce9965477a49374aa559916baa74f88310e94c97309c6130dc92fa"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.9/finnest-runtime-linux-amd64.tar.gz"
      sha256 "d57dc12694d3dd0d4e0dbd6594c472c5790a135895b6c5da2388fa571dddbd70"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.9/finnest-darwin-arm64.gz"
      sha256 "4a3782104415dcc27f705e5108789bd1f6d4893a463ba35210dc7b6da1d71c9b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.9/finnest-darwin-x64.gz"
      sha256 "3d8d38aa2d79e3eabef4e012c434c69f35dfe7d114c795cc77631e11ac1cbd70"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.9/finnest-linux-arm64.gz"
      sha256 "23a65ed1cb4f7f533eeab12569b33dd778d0b1a25093d7d31b1d7526b08636bc"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.9/finnest-linux-amd64.gz"
      sha256 "97f3bf2ea364404a6f5ff62af736baabb0c8f1e0b5bf85452f4913f7e92bd986"
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
