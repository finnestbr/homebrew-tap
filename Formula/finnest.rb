class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.14.3"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.3/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "2692f845ad6cdba75e0f09d6b1d052e732a5a0d17ee512cf100407e49c1c5803"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.3/finnest-runtime-darwin-x64.tar.gz"
      sha256 "4a0b8e0e4ba9bd155551ca50bbb85880185d304edbdd867a637e74e7febea821"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.3/finnest-runtime-linux-arm64.tar.gz"
      sha256 "6aca25197d359ae4f4d93e5ba206dee79c5fff58f3408161be887ed2415f1d82"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.3/finnest-runtime-linux-amd64.tar.gz"
      sha256 "8b91431912550cf0386adbcc7e0b37f3d33c8006e04bb2af883cc04729d2a416"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.3/finnest-darwin-arm64.gz"
      sha256 "c466b8d36eac69bdcbe211cfda7666162fe332d2564a8943cf49a2b39882c8a7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.3/finnest-darwin-x64.gz"
      sha256 "b79b2153926562f6c6bef5e405eaa76aee623fc3effdc0de234eabda37fc64c4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.3/finnest-linux-arm64.gz"
      sha256 "77b42dd70519eb28032dfc5ae0656f0cce0f244a012f87d006d87deb47f78371"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.14.3/finnest-linux-amd64.gz"
      sha256 "1bc596d2c7094fd83d2c709ad7dbf32744a265661f49bec3621b7d2b977eba52"
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
