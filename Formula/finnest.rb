class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.10.4"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.4/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "bd30bdd2a99d151ddc9c6bd6333be71f84fbf72df761fc40e4e23ae57281e239"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.4/finnest-runtime-darwin-x64.tar.gz"
      sha256 "7520c9e2d1ee0c635cae2fbb4062f32987386067cfe5bd5da89c128da259cfb3"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.4/finnest-runtime-linux-arm64.tar.gz"
      sha256 "f36d9baeeba21d3c7b28c44ce34a5e0e65e2326fa3a8366e33e0d05e11f4cbf9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.4/finnest-runtime-linux-amd64.tar.gz"
      sha256 "c95faae7e6409ae331c7c90731bec933ae9dfba906a7478c1f182b9d7785f182"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.4/finnest-darwin-arm64.gz"
      sha256 "a5ffb684b6c30813bd4c3bbd44b5ea6d39b90ad7c0992bb6ef11134b75e8cf1d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.4/finnest-darwin-x64.gz"
      sha256 "ebbfc25fea7b8a7aee95fc253306c0239acd802a93f83c00e5dce6f36b62e958"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.4/finnest-linux-arm64.gz"
      sha256 "f72449aa4458a621e2b467538b8428b07582e8e7f779992eb109628a56283bfb"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.4/finnest-linux-amd64.gz"
      sha256 "17d5777573360544790550444fa2b14d14934049e8777a08bb3307bc6ad3693b"
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
