class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.34"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.34/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "6dcb0751ad13b12828a5f1fd2279629a059d38ee83ff60d5c2fa7b7d8ec909a8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.34/finnest-runtime-darwin-x64.tar.gz"
      sha256 "becdedc55c4ebfb4ebde84ef7dff5162f9dec1dbcd220a0cdace1aaea4115ff5"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.34/finnest-runtime-linux-arm64.tar.gz"
      sha256 "d675a8cbd7395746090e6582a394a11a05d923977675a267d48d76c225937b1e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.34/finnest-runtime-linux-amd64.tar.gz"
      sha256 "7afb764d8a3527263f99894cc3c94a27edcb3682cfd0f2d9266cfa8de22d2490"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.34/finnest-darwin-arm64.gz"
      sha256 "1e88dc7d058df0ef29c0ee397ec13ce3248e52154d8b625497f327df6ee1c47b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.34/finnest-darwin-x64.gz"
      sha256 "6fa93b794c553ad3e46ed4732a4c678b635eedce0627812d72c6aaad5225f340"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.34/finnest-linux-arm64.gz"
      sha256 "4258160d83634e7fda1801d561e84d05da089a60841a06bc6c989ca576dc7600"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.34/finnest-linux-amd64.gz"
      sha256 "d1707a1751487977f29a55734748a26a4c2d1f363a5b918679063521bc39a7e5"
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
