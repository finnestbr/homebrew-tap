class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.4"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.4/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "dff79a7b4a63bbf35ce858f1f26aad04b57f50df2bdaebb5bbd3ac36fb511a3d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.4/finnest-runtime-darwin-x64.tar.gz"
      sha256 "25b85de41260f8ca27b8770c13850770c82de0481b125bc5a09f5cdd158052b8"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.4/finnest-runtime-linux-arm64.tar.gz"
      sha256 "9972983025264b824fa1e777db09250fdf28b3d9ef27656100709309875f822e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.4/finnest-runtime-linux-amd64.tar.gz"
      sha256 "f56e06cf0d48af1cfae4f1f0fc51b68e69f818c6676b9915269a7fad58dad7f2"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.4/finnest-darwin-arm64.gz"
      sha256 "52ee9ec8f1ca3d30a64e698639a18aec485df2739c78616d7be8d875e5cc3628"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.4/finnest-darwin-x64.gz"
      sha256 "3bf5de77cc9748453559d001bc825223fe8760dcdd99276bae915f90b7ffb9b9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.4/finnest-linux-arm64.gz"
      sha256 "e23756a754ea113300c76cff1a9a37bd6f1ed663bca84287372e821ea8eee814"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.4/finnest-linux-amd64.gz"
      sha256 "ab143d3f39500571fcabe3a566823ec0bb151a581e3892c172b4fcc6b16064fe"
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
