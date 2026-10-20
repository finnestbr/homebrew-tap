class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.23.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.23.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "7e3be8e7393effb8ea01f5b25c4fcf4497869c7ea56f9dfeea5e326b6caf2a52"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.23.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "dc3e22fbb5b2d4cae7a842487525c124db810158a92b1d3fada2fc014698f8b8"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.23.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "f664b20ae78e928443bfeb6b0c32d2a48b306035127c1ce71224964e911b5185"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.23.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "828ad76e748668442eff58e8cb938bb04be0e25c68329be8195ce4fc82dd327a"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.23.0/finnest-darwin-arm64.gz"
      sha256 "a4aca355f7d2ef2ad69c756230ef22c68f776f4fcd98f261650bec1d1512c46c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.23.0/finnest-darwin-x64.gz"
      sha256 "27e36c589fb0a36a1fd8bdd3c48e33fed257d4b1bf13c51225dbe2067a475e6a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.23.0/finnest-linux-arm64.gz"
      sha256 "1a75836d56f65c20e31b2855a3423b4a4f50571b6bb37ade8499449fba1f986a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.23.0/finnest-linux-amd64.gz"
      sha256 "2f7d7c9df83c842443168a2ebd44dc56bf44639bd3628687f437d8fab60232a9"
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
