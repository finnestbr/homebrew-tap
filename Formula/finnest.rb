class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.29.9"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.9/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "3bd36c32b45f42a661b80c098d9be19c17645b1b4b69aa24f63de9e196933c72"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.9/finnest-runtime-darwin-x64.tar.gz"
      sha256 "99b82e3949480b48c9cfcbd490462b6c5e43993bac805e701f9bb3289ef16e63"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.9/finnest-runtime-linux-arm64.tar.gz"
      sha256 "e1e164695b6d7f961c18eb394d0200a578649cf36f041275fb38d679082158dc"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.9/finnest-runtime-linux-amd64.tar.gz"
      sha256 "0b427f43496896c7e9bfab3f33b608098c687a4c9190fb8abe08950cf21e459c"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.9/finnest-darwin-arm64.gz"
      sha256 "2f5b7b99fb630fc5a667a4b36c26444e0ed337dc2e0cb71b8976696fb6fa02ce"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.9/finnest-darwin-x64.gz"
      sha256 "2154f5b80df939f7a8fe6f47c74426d803366f7c604a2d7c70d7f536177ae857"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.9/finnest-linux-arm64.gz"
      sha256 "9cd4afc7f34316125a50970c9af80d2989318460bedf3932e099270673de0875"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.9/finnest-linux-amd64.gz"
      sha256 "ab9e8d78e8cea9c85a1e5a6cf6eb84ead17a96b28d86d7aa68a8a1f814591f8c"
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
