class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.15.2"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.2/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "66d356fe2cba77df18ce69ca66126b06c60fef7db86ef7d9459b1a9a130b9fda"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.2/finnest-runtime-darwin-x64.tar.gz"
      sha256 "4eba8594b0be33d8bb1f1b2910ba569a13b5fc4d7b3d78f331dba42ace9d3855"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.2/finnest-runtime-linux-arm64.tar.gz"
      sha256 "957ce920c21743763c8e52407cddf05f3575556726792d4b0e6b05d8b6207534"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.2/finnest-runtime-linux-amd64.tar.gz"
      sha256 "0cfb203a208554330f2d20891d44020681fa51ab7c9f6fa7e0e886aec16c253a"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.2/finnest-darwin-arm64.gz"
      sha256 "09b9e4baba3e7e946df8e026c66688c8e59f3fbc582b29ec600e319fbb504f77"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.2/finnest-darwin-x64.gz"
      sha256 "e4cf21d36786eccab74dca7a32435ce5663f0a05aebbb7baf0757371aa12be65"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.2/finnest-linux-arm64.gz"
      sha256 "5ac7c6da66e402bf0596e7624b405740bc070a336440d4174409b56a88de869f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.2/finnest-linux-amd64.gz"
      sha256 "a058da6ccc4b29fce1f5d51129af64bf8480ce4b21a47deda47d2121464d9f31"
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
