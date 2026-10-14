class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.18"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.18/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "211846abb66ed49077cba4be67cfa3113e526c09a8fd87361fcaee968eb8111a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.18/finnest-runtime-darwin-x64.tar.gz"
      sha256 "4d5c7f928b196040d20d732969c9c924f51d70c3ffa76cd85eddee4c84d022ee"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.18/finnest-runtime-linux-arm64.tar.gz"
      sha256 "08a40a1ec68d4fd46825b0c1964f88e19d3f342469b39f831a804b4dc1692d38"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.18/finnest-runtime-linux-amd64.tar.gz"
      sha256 "514733b69f87d911a7bdc241f294c44ba3da53f24f782818fe4e4b9c4899fcf4"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.18/finnest-darwin-arm64.gz"
      sha256 "4b2de9c848edff2babf6890b54740c5f7b586af2aeb2f2d2d130461d492c97ea"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.18/finnest-darwin-x64.gz"
      sha256 "00663b4698838f2b0e6cc744de61d353982c1b0e77dc1383e168b272839d9801"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.18/finnest-linux-arm64.gz"
      sha256 "24cd8b9f93e28c809d1e3b41e7b7212a977949ca5ad18332d54f62040ee115d0"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.18/finnest-linux-amd64.gz"
      sha256 "12498afc65cc63d2e46fb22384c817fd053a8cdee75c415e8ee3fd5860c42dc7"
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
