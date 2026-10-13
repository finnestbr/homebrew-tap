class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.10"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.10/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "c348422b15bfa1302f1c837bd6d8ce53c3d49eb238dd6e756d5e9158d38fd16d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.10/finnest-runtime-darwin-x64.tar.gz"
      sha256 "6822b76db76f04de26996c1ffd6e8a568e0ed12383ac4cccfc60ebced6433467"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.10/finnest-runtime-linux-arm64.tar.gz"
      sha256 "e61bdceec3153489941bf6f7ac2d56c7291098c3e63b9141f7f6c06b70d94dee"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.10/finnest-runtime-linux-amd64.tar.gz"
      sha256 "2856c6753330532f1aeac0b5fa42760f2323520d81c453bea7f77de9ea0d1a4b"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.10/finnest-darwin-arm64.gz"
      sha256 "7b5fd7496572422c631c417866b53514a8a1dc053b1213648a9639737fe3ae94"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.10/finnest-darwin-x64.gz"
      sha256 "feec5c91a32ecebe6d35c3fb8a9aa43bab038ec26f55c1852cc428659e88e81a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.10/finnest-linux-arm64.gz"
      sha256 "18f0a7ab48a8d91b21019fa2721875ed74433e6696754e3119952fc47270a010"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.10/finnest-linux-amd64.gz"
      sha256 "70973bdf01811e8c33eb39b7ee029e80ed54ade4c03ba02282dba08d1f39fc0c"
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
