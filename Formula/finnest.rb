class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.22.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "d436433ffbfd11ffaf61ed1c9d58472fe4516c3c52c5c15cf587b9401ce79867"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "5240d5bdfd2ce1445bcde5864e8486a978f742c36dcc64a60b2edf533d34eab8"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "8da4e793b363e225ced06b6a858b5c9b2db19905ae78ee107cbf5cf7e4db63b2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "118e04e24b916c46157dd63c44f0941cd6752994c8b3371f32d67bd72a75064c"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.1/finnest-darwin-arm64.gz"
      sha256 "b83fc53ec4ea25b2fce9edc00c95dca7888a2aad4dd9114d9865e0c44e36362d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.1/finnest-darwin-x64.gz"
      sha256 "27b134f9d1467f366780215f5e430de0412e79010115df776add94340b1fa9ee"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.1/finnest-linux-arm64.gz"
      sha256 "48c2c32f2ef82e22914535799e40d46a45237a58e2787364928897ad41011ca4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.1/finnest-linux-amd64.gz"
      sha256 "bc9fa8f51d15693dd6dd2ce634476fa44ff63678684e26e0c3f311a83dd6e4ae"
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
