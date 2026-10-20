class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.25.8"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.8/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "047c3d95a2bfb66cbdf43263b4ca22e5e06b1d76884357401adcdf1e69b270be"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.8/finnest-runtime-darwin-x64.tar.gz"
      sha256 "a7ee906d00deed71bd62536e4c11f17fb8c6299476986ebd59243e46c0a1d87b"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.8/finnest-runtime-linux-arm64.tar.gz"
      sha256 "44e5a7513fffea8083606edfcf517b0d5a57c7e98f41662675839271fb320abb"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.8/finnest-runtime-linux-amd64.tar.gz"
      sha256 "0922928f9cab5bf6eea52c5aff1cfcb1fbc770bc30b9b4aff35beab3d6a4b857"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.8/finnest-darwin-arm64.gz"
      sha256 "4185e430d6573202b9d6ce59edd21737b30f543592802c1c640b16308fd67430"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.8/finnest-darwin-x64.gz"
      sha256 "72acf416d54dd3fd36e61d3c1870aa28d19cc66463b3ddb93f8846f92de6b588"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.8/finnest-linux-arm64.gz"
      sha256 "ec61a4c80b2fa014a937452034f6df43a9ba3d204657649fe37cd42cbf05827f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.8/finnest-linux-amd64.gz"
      sha256 "62a66183b0296df0d9cd962e8747014391a66ab34d83f8561d34f1a91d079b52"
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
