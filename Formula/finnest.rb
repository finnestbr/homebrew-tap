class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.19"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.19/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "de4aeeddf5beb409954089f93e436b1b3059fc514b604ce8b0dc13b34612c45a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.19/finnest-runtime-darwin-x64.tar.gz"
      sha256 "d8ba56531c48de3a19bd5c75f89c20bfe98ffe07122466e6eeb6515ac700a168"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.19/finnest-runtime-linux-arm64.tar.gz"
      sha256 "106a84908908a46a15ccaebc0f40ac30b74bd63a544ab6d5ce855565f4c10cb5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.19/finnest-runtime-linux-amd64.tar.gz"
      sha256 "62f7293a28d6b3613616ebfcab65413e02e6ad701b9c770788b522ce7d6f8da9"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.19/finnest-darwin-arm64.gz"
      sha256 "3cba952a569024208a7385858aa0b7abefa851dca568e63d33df517178626a66"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.19/finnest-darwin-x64.gz"
      sha256 "fb6275985d859c7af6052ee3da8248a8a136bb6fd78042f5397cd22455d94d3f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.19/finnest-linux-arm64.gz"
      sha256 "35533673d195ee99221d44eb9a871153bc7058c82f6fcc7915ef9197a0ce8250"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.19/finnest-linux-amd64.gz"
      sha256 "775432d194b8ce25044b8c7bc04d93f0bb1166308fa22dbe9353140a445c0155"
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
