class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.5"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.5/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "af7a33bb4716f4ca4eff12cb654a43bbad544c9b16d9616f3f0123f392172c70"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.5/finnest-runtime-darwin-x64.tar.gz"
      sha256 "1fd0bb606811e8bfa937822009b8469967388f0a6e8f588f14920a110476eec4"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.5/finnest-runtime-linux-arm64.tar.gz"
      sha256 "37e9f42960b45c1b2535203db914bf26e78a26b1d3541a733cc82535219e60c3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.5/finnest-runtime-linux-amd64.tar.gz"
      sha256 "365f4043a0ecbf444710fe7796972c6d6b61ba797e11c5a5f9da2cea64fc6186"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.5/finnest-darwin-arm64.gz"
      sha256 "8bd30743a22f043f62a54b1dfb0c0850030c3d8e1aed9e60120390df0230f90f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.5/finnest-darwin-x64.gz"
      sha256 "05cf58bae71f533ddef5880430b6ace9e2c80542edfc7645f555865fb5e1a4a0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.5/finnest-linux-arm64.gz"
      sha256 "37e6b9e012e43823065f172a693a601aa3ad3b36504d3638174d89b84347c567"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.5/finnest-linux-amd64.gz"
      sha256 "205b3d11838663824980ec7e4b8f01d4dc0147f1ff8dafc841432c3bc74f9185"
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
