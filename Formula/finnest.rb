class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.14"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.14/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "03a75cff4b7f9068ffbaddac2c4f7a70a4ff52473ef48fbf730ef50f0e5778a0"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.14/finnest-runtime-darwin-x64.tar.gz"
      sha256 "5261dcfaff75572a16ea4d1f21596e3177f0cea5c0330cd6cfbbdf5512b39c0f"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.14/finnest-runtime-linux-arm64.tar.gz"
      sha256 "b828884fc8ee05984bdb5060dd09939270ad6da372fc2be1bdccc7dc1a355f88"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.14/finnest-runtime-linux-amd64.tar.gz"
      sha256 "6985253274c98de204a12acd26b10b92ed437ad2050451b1048b0b22786745ad"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.14/finnest-darwin-arm64.gz"
      sha256 "fae294bf27cecf5c5d2c52e75cd43e34d96221f6ee227d741931dc51dae30538"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.14/finnest-darwin-x64.gz"
      sha256 "15639f95ef7a5282d86cad17b7e69c17b6a8784c15df7e6af144f45f818f89aa"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.14/finnest-linux-arm64.gz"
      sha256 "e61808a6aeb65a785601b39fb0210d3269bbe6ebfae52dd4bb1242a74c353657"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.14/finnest-linux-amd64.gz"
      sha256 "56b7bfed5ab6bf4b1586bd2ca28db114d95f35225da2cde55e517dd3ef31bd29"
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
