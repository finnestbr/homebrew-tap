class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.41"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.41/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "a9174bdce9afe49054833adbf67c17d30229b3683241f0985ee033560e7cfa42"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.41/finnest-runtime-darwin-x64.tar.gz"
      sha256 "b6f0945666882e2d7bbd406e113edff3bd14ec7edd2cc51b579d33b912069e13"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.41/finnest-runtime-linux-arm64.tar.gz"
      sha256 "4aae8007541da82d415ee72734918ff87ca096fa5814943cbacd3bb9bab2eca5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.41/finnest-runtime-linux-amd64.tar.gz"
      sha256 "7db4db8b5fc631dde03b80c89958d3b42a075f7ae1e537c3ffff32c5d0d7b88c"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.41/finnest-darwin-arm64.gz"
      sha256 "5955edd97b051c9593bf16751391c4965df10710851c22d259ddd47c4012207e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.41/finnest-darwin-x64.gz"
      sha256 "61d515671ab8b4fdfda2e3332508b460e40ca6e6fed2644b7d9edb25a14db970"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.41/finnest-linux-arm64.gz"
      sha256 "bdcbf138394d8ae5076f79003337fa4210334dbaf39cb9fe3d90f192655f507d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.41/finnest-linux-amd64.gz"
      sha256 "bfc9b57f9721f191bb5920412a54314ae5765043fff54687df762fae0cf61294"
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
