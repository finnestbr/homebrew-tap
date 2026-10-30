class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.17"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.17/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "564c7cda3ab883ad944d1862082a1bee50488c0b50ae6aa3449c43b7d298bfbd"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.17/finnest-runtime-darwin-x64.tar.gz"
      sha256 "1c8db04aaae59de3671e024fdffe3afe819f65309538ccfc879fa1815c5af605"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.17/finnest-runtime-linux-arm64.tar.gz"
      sha256 "c90bd9f49b1634dacb4be9041298aab0095a1198cf3c7a1ebc9423dc5e43747d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.17/finnest-runtime-linux-amd64.tar.gz"
      sha256 "ea87f43dbffe943f31d1d460302581854f7dcc88efaad340a545ee30801b09a1"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.17/finnest-darwin-arm64.gz"
      sha256 "6793cae63585634d35dfa1697a142c17faf6bfae0f2de1326730a844b8ffa62e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.17/finnest-darwin-x64.gz"
      sha256 "2c89097f8b3e921df440de1a3f37fa0a6e3d7ae5d5c08783a1f0ea97743412a7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.17/finnest-linux-arm64.gz"
      sha256 "9732cdfb570a05414d1228547a728a0b0e3a28a4cda81bc053f9e59b2d431e5c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.17/finnest-linux-amd64.gz"
      sha256 "e9e2fd36eed6e1b8866332132c8f0329eb7e2fdf0617ca63031fa71b981a92e2"
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
