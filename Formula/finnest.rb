class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.31"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.31/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "21451a1cd5eb9a61faa9b0cfe1927904777e8055c30f0e3304cd355d39848bbf"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.31/finnest-runtime-darwin-x64.tar.gz"
      sha256 "7dcf067488492721735230dc66b1f3dea2fced39f6d31d189861d83562f3afd6"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.31/finnest-runtime-linux-arm64.tar.gz"
      sha256 "786b91a52c8ef7b30aacf851988a2416ee2a9f3332cd7cf19361224a6827446b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.31/finnest-runtime-linux-amd64.tar.gz"
      sha256 "0bc0d52eff9cbac723a2038044ddc11e4bc0191c4ed36b55303b9da89fe7e641"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.31/finnest-darwin-arm64.gz"
      sha256 "9e03844e93e001563bcf6332dc05e302ecf6f171b84a64be4fe11ac3e1c95669"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.31/finnest-darwin-x64.gz"
      sha256 "9f1dd874f66c46f17303c19fb6af71ae0b89381433f328dc97b1a3d37c5a52d7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.31/finnest-linux-arm64.gz"
      sha256 "3b2795174ef094873e7ea0d20d4214058eec816fe84336f91ef38fa47f3ba727"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.31/finnest-linux-amd64.gz"
      sha256 "80fd8c16d53944e06895ff57d772be37fdb13c05751f0b580731b8d1ccd9f239"
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
