class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.25.7"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.7/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "11dc70e248737d08c473b838eb6af5b62fb35a7abd9f305a1e1d1e7ff545de54"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.7/finnest-runtime-darwin-x64.tar.gz"
      sha256 "487b73b2436d53ba9d22eb90fe99e297f149c30691b36924f50bacb6b92b5b03"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.7/finnest-runtime-linux-arm64.tar.gz"
      sha256 "8564ec3063b3b0e2f402130fa4b15c3318419f1d1b3612309c948b168e591373"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.7/finnest-runtime-linux-amd64.tar.gz"
      sha256 "e745394f13e35c666f5d99c8c9416bfb8744b9472832423942e8f0ee9115efae"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.7/finnest-darwin-arm64.gz"
      sha256 "caae2d9c8ef220aedb56d0668caa424e03ac1e6a5dca5de1941eca6530d032e4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.7/finnest-darwin-x64.gz"
      sha256 "4fb04b1c8a05a5b4674b7569518d3637ab843f44ca4d24fc954567887bd841cd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.7/finnest-linux-arm64.gz"
      sha256 "4374a83864b60993f5e9fb80150ea3b0f71aca5c2b6c152a312e8e1d653a8dc3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.7/finnest-linux-amd64.gz"
      sha256 "034a72a23a0b4f7902016a5abe05dfb7407d03f933e7f9082d98095cc110c93b"
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
