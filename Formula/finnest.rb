class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.28"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.28/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "d1d2a577ab5f3dc4c1cf25f776f6c6c7088cfec7524e3136e80ab1bf86db0544"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.28/finnest-runtime-darwin-x64.tar.gz"
      sha256 "170dbbddf0696ffcd10e549e24151a8adf433aac1875e78ba4db8b68dd4647e6"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.28/finnest-runtime-linux-arm64.tar.gz"
      sha256 "898d7b78491286c38196813cfb77aa5449975985567fb44ddefc62dace709d4c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.28/finnest-runtime-linux-amd64.tar.gz"
      sha256 "027d0445283fe19243794d3c502acc1b04423b4d6e35f3eb65241b3063d5a96c"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.28/finnest-darwin-arm64.gz"
      sha256 "959f8ed98a8aa28b61cae80f62492fd2054b1944b0ecd2544fa421d30f3037ad"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.28/finnest-darwin-x64.gz"
      sha256 "483b93b4eae3ad817ae082a8ce43e58c439fa34d2d69b046c54a3ccfdbb522e8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.28/finnest-linux-arm64.gz"
      sha256 "e78546aba76cc6989459be03092c57fa928b76e5a1467802d8514175e2ce2016"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.28/finnest-linux-amd64.gz"
      sha256 "c462d19f92aa9e4eee78cf70292d87d500d8ff322d59f38cde39637e90188282"
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
