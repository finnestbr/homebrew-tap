class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.16.9"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.9/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "f841d509d0656fa0a6f5bdaf869da88025dc963f7309b3aaf38c299e9178676a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.9/finnest-runtime-darwin-x64.tar.gz"
      sha256 "4c6f495218aca674fd6b8e9d89fbee1772036d65cbc7b57756c6fdecdd914baa"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.9/finnest-runtime-linux-arm64.tar.gz"
      sha256 "aec764eb1e666ad6d329cd5e2cdc1f1ec92a61de05a3301dc7a4ef505dc93213"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.9/finnest-runtime-linux-amd64.tar.gz"
      sha256 "7d6138fd2852db7736c7f84ba7c9dd46fb4cedbd0fc8f8a7652ab4a94b6c9cd1"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.9/finnest-darwin-arm64.gz"
      sha256 "1920123648e82c27ac522420b5d9e99dd1c706fabe95d87e72860df6c3b2e83c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.9/finnest-darwin-x64.gz"
      sha256 "ee92c3f1c0949da2498967cf5bd7e6c34f06df08da08289d8bf67905539d414d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.9/finnest-linux-arm64.gz"
      sha256 "13c02f199a864aedc22cbd2e4499fb72eb433afcbab10c2d66ef750067faa3d1"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.9/finnest-linux-amd64.gz"
      sha256 "a6ef427d2b75e0720ecdd0ebae213bb20dca09440fa12a7856468e5651b19370"
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
