class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.32.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.32.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "8fe8994e2d801193fcd7abdf562536b75d6208419510066b3783c6bd37ec604f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.32.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "bb1ec704b0fbeb7cd27f75da355dbab296aa4933150bbf30e8ddd9f74fe89371"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.32.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "a455c179ef3a9b7e826888a6d265a2d8ea45191b279df8df17eedb87d2b7d559"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.32.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "f9fcb90fb1475c488d0836c3b6bb89dd46d7e1248e3c3fa3ecc549abff9d201b"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.32.1/finnest-darwin-arm64.gz"
      sha256 "4a1613c4b3b1a1fbfefb672eae1d8a079296e93757492f97641c3e83087c7340"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.32.1/finnest-darwin-x64.gz"
      sha256 "65416b226a30beff73bd8ffc455bb2964720d71dd96a73492407157494cad81b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.32.1/finnest-linux-arm64.gz"
      sha256 "66faa2b19da500e52f471621c8462ea03595117a3f494d0439e3558e4fa7d83a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.32.1/finnest-linux-amd64.gz"
      sha256 "6203b0f8a2dee657be184f95d7e9a6dfe5429c847568100f16a974ecfa580ae1"
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
