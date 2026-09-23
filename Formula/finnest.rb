class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.32"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.32/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "7727b753bf1a7c9b761e592e0c48566eb419fd293e877e0f653bc45e179493d9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.32/finnest-runtime-darwin-x64.tar.gz"
      sha256 "a02c345de2d75e3938347611f14cc1db699429270f607d9c08adc7c7ed36b502"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.32/finnest-runtime-linux-arm64.tar.gz"
      sha256 "06967eacfde891d06aa080e0dcb0d4a576ea63b116cc19a37ea16da3d152e322"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.32/finnest-runtime-linux-amd64.tar.gz"
      sha256 "7b573e703fcffcee9be3d51fac252183f29f7ae30931f1187b2808e824a54554"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.32/finnest-darwin-arm64.gz"
      sha256 "7ec260fc53ac90bac21bde0af14f2132d4a4ab0d834c08b2ff0e3ca13bf3e296"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.32/finnest-darwin-x64.gz"
      sha256 "fe2ad661ab64441230d46c182cc921985cebdce4b22dcd7a928de6f88c9a202b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.32/finnest-linux-arm64.gz"
      sha256 "8c7dab437716e164b1247d9104694c01dd645120a3b31e8c195a2793045b574b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.32/finnest-linux-amd64.gz"
      sha256 "123d228361a23242b9a38ae0654516d982a2fab4b3e157bff09d1e2f23b45d4e"
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
