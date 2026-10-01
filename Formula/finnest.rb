class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.10.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "56f26cac0e8a17f8baf0125f62b133a9094478c1ab639e8cc7140e2acf83ed6d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "e9270474ef64c6149d7ff0e4b3a47df664d93887d037036127715c532c430d5b"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "6e77e35ce05d1871a8e286b5387e7fce2be8e3357f1160a652d50960b61bad2d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "3dbef1410cdf1e26e85e21609c2b768c9d48a2eab467c6db2f83f8e307566907"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.1/finnest-darwin-arm64.gz"
      sha256 "430086467540a1dd968cfd9ca46b6ac0dd3aa46e6302b7d3b9d0e3a116ea98d7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.1/finnest-darwin-x64.gz"
      sha256 "a2a9e0014b31fd30e27aa7e6ade029f9bb89e1170d50e1b0c975307995c85f4f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.1/finnest-linux-arm64.gz"
      sha256 "aee24b1173574afef65cb168f3be3525867ad849f95cf6e5e1284befe0b4e160"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.1/finnest-linux-amd64.gz"
      sha256 "19b4839e1b724d7cd1a1dafb94132324b83eacb579048c30415ffcb7cd8860ea"
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
