class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.10.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "5a9b3a6306adeda5dce1d40dd7d9192339e5f8c2b101ff58673e1178d0feb4a7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "da7b78d1330b34896d08cfb9ee3c1ed61c1100340fb94d300d0648e1c1a61141"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "2e268ae1567147c0b8cda76376ffe38f74aa86f12823bb6291e470a6b9e9fea7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "17b83b31601c4c4540e9b08a66ca55c0bef3601460e72ec0c39f36c948c56a25"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.0/finnest-darwin-arm64.gz"
      sha256 "6d31e94afb0cb83ef8384f7ce88a2e1bb5f43b6ad9138609e7f23da87a8943df"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.0/finnest-darwin-x64.gz"
      sha256 "f940c2a56fec6138528384755d6e79a3977e310962bc04b05c4191a9c433213b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.0/finnest-linux-arm64.gz"
      sha256 "a959bd8561c65d4957824826252a0c444a96291064bf730c8f53766d576403e8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.0/finnest-linux-amd64.gz"
      sha256 "f62c04796cc9d68d7bb8f238bf605c73c2fc4a909fdd5d6d39e495cf0bb449a4"
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
