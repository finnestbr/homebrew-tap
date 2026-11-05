class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.31.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.31.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "30498a3bffba80c7209a01794719ba35f0b33e141f6dfefd4d68103475420fc3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.31.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "a42259d2ed3b1d5c423b3019ca4d1b359fac52dd29e962700a3a6d1f33bade4f"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.31.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "3025f8bef618c668bc3abc984901356859a7e75bc5a4cfcf6cd3ec9d5b0f3304"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.31.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "93e32ce6d9a2a17723da52c625c84ff40ba071c1b0015017664fa5885a511b8c"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.31.0/finnest-darwin-arm64.gz"
      sha256 "3d4b0479d2e26c14bdadaea9217d91b8bc6135a34ebd208ae5306464d25e679a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.31.0/finnest-darwin-x64.gz"
      sha256 "dca5f9354d78a1ff4eb5dab124db77db3949eb02cb4f0447e166a283fbaedc6c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.31.0/finnest-linux-arm64.gz"
      sha256 "ac4edafd8bd2a79a4ca8f7c5d8d4c61a2f6485fbcec4fe6c62555a2e31ae8ab4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.31.0/finnest-linux-amd64.gz"
      sha256 "ecf146283b79dcb4d2afb6854778e5bd3152d4d368ae05060aa9d7d349dc6f2d"
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
