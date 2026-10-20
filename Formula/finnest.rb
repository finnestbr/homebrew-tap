class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.25.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "56a054971068cc55f447e96503a2d2d128146d03c131aac2d515831a523327c1"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "c66dffa466df431cc5e571d1b5bd0a66ab39f8826ed0da39e20a4da3a8c86c73"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "7d5698bcdc0b5413707e3fd065ea0ec17c06dbb1cbfcbc2d6e8bdc7883e4e4b8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "ce71738e5ac9c71f1698b564122d4877becf6b56be7bd1b2734d120385d76ec4"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.1/finnest-darwin-arm64.gz"
      sha256 "8ae755e0d39783f5ca9446dd269688f1e4b05cb7e0bd07fcc8684eabd25b630e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.1/finnest-darwin-x64.gz"
      sha256 "2a3b649834fa55a78840c893b43d3fcb6abb3b1a62cfaecbc406cbb12db1ca04"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.1/finnest-linux-arm64.gz"
      sha256 "87175cdbe91e8d2f0ae8f2008e515bf5b9b2cf3b78b649362fff769fe6b3f6ce"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.1/finnest-linux-amd64.gz"
      sha256 "c46497f1b7486976a1b481c38df314ed4f88f44ff7fc4283933498829662237f"
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
