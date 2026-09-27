class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.42"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.42/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "5b7464ae76832bbf1a090b3f73b97830a9fddea2d685d3696d22ed3d4568c3bb"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.42/finnest-runtime-darwin-x64.tar.gz"
      sha256 "d2c454bafbb75eb398bb8d9c61f08ef71e7a2ca76f4d515da51e14302e2a9e2b"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.42/finnest-runtime-linux-arm64.tar.gz"
      sha256 "abebd057b417ca01f27e336c1585aecede1bc0a33f9e257be7b89495d72fb52e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.42/finnest-runtime-linux-amd64.tar.gz"
      sha256 "ffedeaaef7818e848d1e2d2bff5e375b6b786f5ffd8c914c5cd424d405e7f27b"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.42/finnest-darwin-arm64.gz"
      sha256 "43e4a1f08bf2ca812337b64e5cce42092c84afb8f95623b653b0f74a68479e65"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.42/finnest-darwin-x64.gz"
      sha256 "01bafe14b9563b795d645a33260b91473e3e326f8d38cbe312ffc59dd4c046b4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.42/finnest-linux-arm64.gz"
      sha256 "15e28edf26bb360b16f1a08e655229f837db6dffb8992e2e9e1e1a10d8f44c99"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.42/finnest-linux-amd64.gz"
      sha256 "0f7ee1c79d92f0f9729d0c04f57eef4aa31d0a9c5c7a16f80fa4b1a30c3087ea"
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
