class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.16.6"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.6/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "55fe7de2573bcc89c0328edb74cb56b83f32c654dd693ecaef62c362e9ee3681"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.6/finnest-runtime-darwin-x64.tar.gz"
      sha256 "586f490c590eca529b330970a9057ebe5a8c0f50cd21629228ecba9b8befa693"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.6/finnest-runtime-linux-arm64.tar.gz"
      sha256 "b3358978636026f6aa0b3318fc0722f89a9c93297653dd966ce0d0cdf144d0b3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.6/finnest-runtime-linux-amd64.tar.gz"
      sha256 "2b092461b9e9073bf642fd1f0c437f1133fa0305fffe1ac5ee7aaa118ba3e378"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.6/finnest-darwin-arm64.gz"
      sha256 "05ad1fb31a0866d2624e3e2b674a05004abf413b793ebbeea1346eae790d77b5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.6/finnest-darwin-x64.gz"
      sha256 "e20997eacd4a4e67614504ab9fb9035e1bba5d89d45525a4b6ccfc216050cfde"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.6/finnest-linux-arm64.gz"
      sha256 "da54cce5fac242bd25e591b892811c82745b4f260e3d8aa4dd4837f523480232"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.6/finnest-linux-amd64.gz"
      sha256 "6379dcb0d3286b3ec0351857bce07dc21eef75493c3109303e88a5ab17d36b13"
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
