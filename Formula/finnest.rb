class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.20"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.20/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "ea374883c0c7fd600c2d84375be961606a2947729784031d1dbce674b12928b7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.20/finnest-runtime-darwin-x64.tar.gz"
      sha256 "fec91155d94ae4d664e9b7d4e2783390b249ef738d582b4899b2df8cdbf055c0"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.20/finnest-runtime-linux-arm64.tar.gz"
      sha256 "d58b4280c8a8c9616ac51f8aebf5fa5dc85487980020439abc2d4a275ca59a34"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.20/finnest-runtime-linux-amd64.tar.gz"
      sha256 "07ab60e8879c9dcb51fa8d9ea771c5e263100e697d3ccc4f84b3a86c1847b4ca"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.20/finnest-darwin-arm64.gz"
      sha256 "402e5f1777ac6710e5a4d5c210297b0f903869aa43c8d564624e6f2c63d0608e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.20/finnest-darwin-x64.gz"
      sha256 "6564a10cdafaceb57f72657d15725e3bcf5ecc8988ecd39788d2ce3748c5295d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.20/finnest-linux-arm64.gz"
      sha256 "559a669071e576289ccd21ce2b91219798154547d60a30b498daa34f444c765d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.20/finnest-linux-amd64.gz"
      sha256 "12e3a16550a72dddcb6f8fce213ec148e9a4a88cc9bda3272de8abdbf7962dbd"
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
