class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.40"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.40/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "c00000191bb53af497f885416628bc0f936bddf263457c5be698724b1b2eb94a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.40/finnest-runtime-darwin-x64.tar.gz"
      sha256 "b50af216a338e309d5eb3acaeb1369dc9cb55e9d508147d987fb640628cd303f"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.40/finnest-runtime-linux-arm64.tar.gz"
      sha256 "235d493b44bc4146d0dc3c426fd10cec426cff2d48bc6e859fe5b93d47258d58"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.40/finnest-runtime-linux-amd64.tar.gz"
      sha256 "dc76aed0e85d62a6cdfbe6b44b5b9b3831af059fed938acfc8145305372c3c82"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.40/finnest-darwin-arm64.gz"
      sha256 "32a99685d20323c4de476a9b7c705cffdae20b53f75784e8940ce5287913fb1b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.40/finnest-darwin-x64.gz"
      sha256 "11d6835ab531466b892f472a16c6cdb40b23b2871c5208295d91aa145be65048"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.40/finnest-linux-arm64.gz"
      sha256 "717e4345c1e6c7dfae2c3443d22245effc3c19020e86734f15c196cf2e76c7b6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.40/finnest-linux-amd64.gz"
      sha256 "e9eecac50b4fce2c7e52dd8090f8049b917f3c0efa75d3983e4fb58b041d468c"
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
