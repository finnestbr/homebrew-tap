class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.16.10"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.10/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "2ea31ec256cfdb5d54073a0d92176ad1a5ab606a8010421f69286661b25d357b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.10/finnest-runtime-darwin-x64.tar.gz"
      sha256 "289ae18210211700e5ad570631eb12dfafcb6fbf697206aaefa0d3d2934f2bf2"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.10/finnest-runtime-linux-arm64.tar.gz"
      sha256 "c0619e5c673fe18ac6c72a0e1c86a447e211c9dbaca953ecf9dfd9263a4c845b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.10/finnest-runtime-linux-amd64.tar.gz"
      sha256 "870a671a837cc2ca9f64879b5e98b36dcf836e9c3fad40643244686a5cbffa74"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.10/finnest-darwin-arm64.gz"
      sha256 "fcdd9ec119e131e8cd938e2df949cb7699103c6c806eecf09568b73787fcc101"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.10/finnest-darwin-x64.gz"
      sha256 "56b3c65cafab2fdc1fedf5e4c05e668a0f50f889900b2c98b290e77830d445f6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.10/finnest-linux-arm64.gz"
      sha256 "d3b511f7052dd6482683891d8a17dd2b2d673e97c2155c44a94a96642809535a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.10/finnest-linux-amd64.gz"
      sha256 "866dab9dd66c03774180e80176728b7c5d5e8fe3f4309cabf1aa91541aded775"
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
