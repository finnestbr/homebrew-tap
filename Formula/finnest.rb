class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.9.2"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.2/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "88e90148acdbd0f575c493402b287ea977b7b010b3cc439c5210a20769ec0ae6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.2/finnest-runtime-darwin-x64.tar.gz"
      sha256 "92729c967b441cef4290f88ebc37f5dbd03a1b21bc75d5c0d78ff8d0a216316e"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.2/finnest-runtime-linux-arm64.tar.gz"
      sha256 "be07469655452cedadb4b278f307a0eeb6b38e299f36afbee0e2467f2a381b80"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.2/finnest-runtime-linux-amd64.tar.gz"
      sha256 "5f8298fb7115fa3af375d7f07f20e026dfd1f0a163008279c2745ff86e34c896"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.2/finnest-darwin-arm64.gz"
      sha256 "97d0340b9b2cbcf5b60999717767262f58fa73f91091bc4c6488996760d28766"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.2/finnest-darwin-x64.gz"
      sha256 "8fe61e7fa24f85d4481106b117f5349841938ca0a5da0a5c1428aeed992cf975"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.2/finnest-linux-arm64.gz"
      sha256 "f0a5a5f98efbdd6afd1a63388a19a4f2e1505479262adcb94e075e5566926460"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.2/finnest-linux-amd64.gz"
      sha256 "f846ba2fc56fecdfba3bb7cae5ad5e53a817562920b1a49dbc523a0f34241c4d"
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
