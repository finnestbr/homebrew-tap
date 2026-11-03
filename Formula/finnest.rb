class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.30.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "6b1ab67ff1b85b6c4ffdecb31474df565435ecaa181399a2b3afa042e1c220e6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "2397a2d04e48d6f663fa67ffbf3ec218b63b3bcaa0a574ea1436a99d03000545"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "fea1110c3d0c818f68aadaa5ccda88e21645bd8d0289b52b63b68b5e1d5ec055"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "bd9a085d5c4f396037117e59c282b10b0dc48b507f18b693e87be9d0ceb7d002"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.0/finnest-darwin-arm64.gz"
      sha256 "62e78361a2861d56e1c510e829ab6314f8e082675bcbb117ba617245fe35715c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.0/finnest-darwin-x64.gz"
      sha256 "9cb6bc3b4765341523d7970e7c12b28e0a5852732d2daf44c2546e5774bf85c3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.0/finnest-linux-arm64.gz"
      sha256 "f7087db50fc5915bf41b18c931832dde3457c63d9035d5752c58b71e213fa338"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.30.0/finnest-linux-amd64.gz"
      sha256 "2aa3540481d5c7e27f30a35c380eeaf372443b6b7fa140c2dfa3d34299fb04be"
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
