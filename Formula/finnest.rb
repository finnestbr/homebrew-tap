class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.21.4"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.4/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "e1f1f3180e59d5c168fb009e8aef00d067770172e9d9b6d61b81775bb0f8645c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.4/finnest-runtime-darwin-x64.tar.gz"
      sha256 "ea5e710eea04fe84461d564e39c6d0ef0326ecd3011b8b3335a461109d9ba25e"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.4/finnest-runtime-linux-arm64.tar.gz"
      sha256 "8f77b56cabccbfb9169829424b8eb320492cc06ea9d1eb7091ea89e2f9064805"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.4/finnest-runtime-linux-amd64.tar.gz"
      sha256 "69a0831efa6c77ef016aec66f97c2def2de79de1a5a78452dcad8b839b2aeba7"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.4/finnest-darwin-arm64.gz"
      sha256 "1a126c23232a659a4dcbd263eae766c2d74cf2d4d1f181ef30263adf36cc1715"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.4/finnest-darwin-x64.gz"
      sha256 "31513b7d68fe5821e4b7fb02a94cba3a51f7274ff837d2c431ea2fb547125b22"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.4/finnest-linux-arm64.gz"
      sha256 "137dce0ddf8be8eede1555db1cc9141348f97396dd1b413cf1f00ee61287affb"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.4/finnest-linux-amd64.gz"
      sha256 "de764ac8467889ee00794b7da7a049daa146750bac4ec023f443e557773fdb31"
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
