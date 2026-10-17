class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.21.3"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.3/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "77e83a5a599b2906cdb5617e0e464b7dbfeca3c42d48b6d65131b4bb60dec54c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.3/finnest-runtime-darwin-x64.tar.gz"
      sha256 "a5851dbc70762d796058c3ddf9ba18f44391c9a462230aa9524e6a7f1dc693ef"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.3/finnest-runtime-linux-arm64.tar.gz"
      sha256 "8b62134dbc10e6506ebe992855c45cd391f4a4bec6eb226df981db31beb53361"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.3/finnest-runtime-linux-amd64.tar.gz"
      sha256 "6d3424d8ecd811ce3fa30590dac2e636ae6b98763147c33fe1fffc216a2bfc04"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.3/finnest-darwin-arm64.gz"
      sha256 "6f70720022878425e6c758b5c885edfdba641b6f31f1ac0d3edefbee31eec32d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.3/finnest-darwin-x64.gz"
      sha256 "977202b06ebe23d399b18be413ffc00101697b8a6410f611c6acec327f5f6de2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.3/finnest-linux-arm64.gz"
      sha256 "ba5551c7c1ee52e4b990cf3d35ef3d2b4c15c364c9197ebc271543dc7c003fbf"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.21.3/finnest-linux-amd64.gz"
      sha256 "b33f178402464c679340a30d9b5eb0fede976059b3ccf3f364f3def8201da8c0"
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
