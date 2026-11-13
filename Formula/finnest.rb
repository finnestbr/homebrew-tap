class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.33.3"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.3/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "0a7b1525fb7fd7ddf469e47706035734c432888045efd18070e829ec83461182"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.3/finnest-runtime-darwin-x64.tar.gz"
      sha256 "700e3a9e6185e68678df243cd50204d4890b8aca054ba332ec247a5f479fea2e"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.3/finnest-runtime-linux-arm64.tar.gz"
      sha256 "4c22bac62f1896bf24f6ff0aea6dd2c1df9de65b6e3ecae6a9c0b6cd0326c134"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.3/finnest-runtime-linux-amd64.tar.gz"
      sha256 "c818e872d31e6d50e6744a4ad04e632944c25ce2f9f54156b437162dd37f76d0"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.3/finnest-darwin-arm64.gz"
      sha256 "ce9902dce5d2381be920a1ed5dc317c901a105321d8e3cd99f7df83806b6f513"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.3/finnest-darwin-x64.gz"
      sha256 "a4783b2ff71ccea7b299fc7702fdb5b93304731435af4a1efd643bd1f5efb47c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.3/finnest-linux-arm64.gz"
      sha256 "f6b58c7c589ed1fa0857e5a6a985607cdeba2b3402e100858692f4ea6bd162eb"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.33.3/finnest-linux-amd64.gz"
      sha256 "e3b1a938d481f7dcc243eb29a6d38c894f201e0759444093cfd887da18aeb572"
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
