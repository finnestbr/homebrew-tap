class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.27.28"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.28/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "b1f6532e16c7d660918755ef6e93fe9f144193810e4aef6fb24fb2c4c14045e6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.28/finnest-runtime-darwin-x64.tar.gz"
      sha256 "cc1765e93126e41d6e5baf1e3ae0e774636a08590fb3013659f7cc772dfd1905"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.28/finnest-runtime-linux-arm64.tar.gz"
      sha256 "b599bc0478546aab15e567994f4901019f1b69a068e45959e23a2e80fd26fdfb"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.28/finnest-runtime-linux-amd64.tar.gz"
      sha256 "20d791415612829d30c4fde4efe32855fce91bebfcf55df73bbae2834b312610"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.28/finnest-darwin-arm64.gz"
      sha256 "d83629105ec1d8150608031c0a3af673849490d619ba4b6f585380ad37d82e60"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.28/finnest-darwin-x64.gz"
      sha256 "34dc61377edf362fb662f6ccd0b80f1339dd430209b7abda98c18c7a6e0ce08c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.28/finnest-linux-arm64.gz"
      sha256 "b2a6971cf828e1ae22bc8fe886f9d9d7f7df6de7e6937d8e88ca7ea04ea76fb7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.28/finnest-linux-amd64.gz"
      sha256 "9387bfc66e323c609dfcdb558d3dffc34892fd45836df8bf01d95057914d05a2"
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
