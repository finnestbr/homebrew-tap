class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.9.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "b17d4c226e8776c2dfe009d854909569e3af4537f52f7cebcb68545bc0866788"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "065f38f45d6c0bccea0e1cbed103db5538e5abc4f88da884db84dc0b90ebc223"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "4f1460f31e9e96101effed056e66a0827618919d3c40460e2aca10a239f1f097"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "adfabd7aeb4032dd36e34df116b6685e3112c31e080b6a1f8dca9a6838aac175"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.1/finnest-darwin-arm64.gz"
      sha256 "af05326245b634178865e1b922924523fa3435886b7db71e3458611756edfd1b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.1/finnest-darwin-x64.gz"
      sha256 "64dd6a0eaf876204f013d228a81b5adf5c7f0909a36f0683c38663ad3d0c0648"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.1/finnest-linux-arm64.gz"
      sha256 "1478fe31ecfc2c292dfd15cc7194e7acc2bb6ef32f3894453b879aae3947edfd"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.9.1/finnest-linux-amd64.gz"
      sha256 "0923afe21e19d32b738fe7907a172b3f4bd2232aaf362010700a3856f3c94822"
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
