class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.27.29"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.29/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "aad98f16e6538dd24c3790f5ee0914463c2835009df29c984c76a12acada6542"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.29/finnest-runtime-darwin-x64.tar.gz"
      sha256 "ef07fc4366881efd2d9e996ceae5e999d7a464d1484f3cda8e07a372490913d9"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.29/finnest-runtime-linux-arm64.tar.gz"
      sha256 "17078c7bd3302439e1aa6d0f0a160ef639f74357549d2058a88279aeea99d67c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.29/finnest-runtime-linux-amd64.tar.gz"
      sha256 "4d669308ef76660e505647a226b8c6c7296ffba9c9933017a21b6f8bce7403b4"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.29/finnest-darwin-arm64.gz"
      sha256 "f1b2247e8a210facdc0341ac1d8e5fe025f8a9322a351f284958333abe0eda4d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.29/finnest-darwin-x64.gz"
      sha256 "0dc185ec1de86b2343d0a049107f738ea5e4a596d9b1e342f0e0961b4fb780f1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.29/finnest-linux-arm64.gz"
      sha256 "dc2c6ac2416b6025738e9906318854459f3d3af55713bb18ac4838bb367542ef"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.29/finnest-linux-amd64.gz"
      sha256 "1a16def9d780fa93399ac6d5a4b2adcf08f1a7dbc45e26ca19b5578b332e324f"
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
