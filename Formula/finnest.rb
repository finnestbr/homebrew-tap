class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.27.31"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.31/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "69db9bb36ea6e2b0ebb3ab857404741480a78ae572672071e02e7ed50acaf729"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.31/finnest-runtime-darwin-x64.tar.gz"
      sha256 "6dc83207ea199eedc666d7d4321246acf6505c9a3681321c6f1db8399ae92684"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.31/finnest-runtime-linux-arm64.tar.gz"
      sha256 "5d3a3d6035bb30bc4c5e0695ac8a744c6655cc6b59c720f59895276fd3e91131"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.31/finnest-runtime-linux-amd64.tar.gz"
      sha256 "1395b5ccbd8c1a87960a1caf7a1c970373985db721ac243f4d4e2d66dfb3f8c0"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.31/finnest-darwin-arm64.gz"
      sha256 "5f3983108563503a8a11b1e06af54273e5d7f75ec9316d97b196e4c58687e37c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.31/finnest-darwin-x64.gz"
      sha256 "b348c0a2f08d6f10ef6198473adbcf48ddaddec3c4d9de4a8d6d996e7ab999e4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.31/finnest-linux-arm64.gz"
      sha256 "089749247b68a45fd0fda715f9b00a9c7a325ff8e6763b7b853678dc3f034fc5"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.27.31/finnest-linux-amd64.gz"
      sha256 "1434289a1fa3522561add3b7d064e78fe530aa0546ad5a4ee0db52732b99043d"
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
