class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.26"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.26/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "f9e12998aff749b20a7266d3891486360d9f1a8824ff2fb40461c12feb1bf021"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.26/finnest-runtime-darwin-x64.tar.gz"
      sha256 "9b533b544055271ec83f1f66f74e83bedfd6df47247ebd6663e3b5c9471a9e82"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.26/finnest-runtime-linux-arm64.tar.gz"
      sha256 "0e5d57ecbb4a4079fd97ee8b983f195b7928eb7702db3a7c74ecf5b0845c0d57"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.26/finnest-runtime-linux-amd64.tar.gz"
      sha256 "0c0cd97e75832661c5555f8e64a47ec9b05d95f66d8ba5e68ae7d81ecd5c4300"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.26/finnest-darwin-arm64.gz"
      sha256 "2253f1e2ef1042c812fc85f01badccd68ae2750e77e08ac2b1286485e4d9c8b6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.26/finnest-darwin-x64.gz"
      sha256 "21fad1e8a147e3787df88b96876fab86a2dbb72eab44b25df2cc795ab84ffd74"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.26/finnest-linux-arm64.gz"
      sha256 "bafee04205e726ef5ecbb9b7dc104115aa7254314e4a00196f220870fc4517db"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.26/finnest-linux-amd64.gz"
      sha256 "92da4124ea9649378d9ad92d55b49306b2df0fd6b00da7d0e07aff180cfafa06"
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
