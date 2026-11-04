class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.30.2"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.2/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "8ba6529de2c312afa36d13c2172ff9e24911a02193624c683ff07e79f29c09e1"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.2/finnest-runtime-darwin-x64.tar.gz"
      sha256 "622bcdae2756baf03984f398b129427e2c4962426c3bd85fb28473d553bbee86"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.2/finnest-runtime-linux-arm64.tar.gz"
      sha256 "df3b6b563f3a5d9e9c76a219f0ee1eaaee708b753fe7270c263261339b715bb4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.2/finnest-runtime-linux-amd64.tar.gz"
      sha256 "63e9b725852184f5497c380f47669af7a89eb04b9b5d7d514d52f238b74395c8"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.2/finnest-darwin-arm64.gz"
      sha256 "316c3621cf321350776acbd488f45216dcaf62e242f3a3683179665824b86907"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.2/finnest-darwin-x64.gz"
      sha256 "41afd91e823309f77ee11329630896e3a60215f376d38763d15038b3bb597dc3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.2/finnest-linux-arm64.gz"
      sha256 "971dd5f24d76d285d2c03e50a96cc3fa5c47d5830631684f4d47b011f35b6a14"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.2/finnest-linux-amd64.gz"
      sha256 "8544714eacc05fafcc4561cb6634fb0b14812bd9583d88b65f028e6c5cb726f3"
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
