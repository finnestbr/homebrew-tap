class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.28.11"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.11/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "fd3b289192ff13cdcb8c8c95ade65cd750ca84121b789525ffa8c80f9d332a29"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.11/finnest-runtime-darwin-x64.tar.gz"
      sha256 "022b04604162fb57805eb62f44562065b2131bef8a910bb5df9e17ee0387086a"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.11/finnest-runtime-linux-arm64.tar.gz"
      sha256 "a4ddc83082657a5bf5784422a7b26ebe123509d068ade7af23afcb1bd7d5825c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.11/finnest-runtime-linux-amd64.tar.gz"
      sha256 "cf11cf4d821135f70daa515b69f49ed90af9dbe96f72ba6a16f42280fde2d4f4"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.11/finnest-darwin-arm64.gz"
      sha256 "c0198deb0dacfb13406df7c43698c2495b7462337d0089257b27d28af787f53c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.11/finnest-darwin-x64.gz"
      sha256 "aa8505699b6be37a764ca34db284394b1bba25f194eb1efce9ebb3258847b383"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.11/finnest-linux-arm64.gz"
      sha256 "346c8cc5a13429afa74a422e9eb7e1df808c280dec586209f77f502a31f2648e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.11/finnest-linux-amd64.gz"
      sha256 "221bf247255d40f116038b497f70e6cb26fbf1d3c9015b45dddb1c0f6a1282a2"
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
