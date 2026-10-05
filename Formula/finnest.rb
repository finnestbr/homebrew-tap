class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.15.4"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.4/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "0bcd948c73ee989f9e5820b09e7062bac10ef6dcd0ba61159741640034a132c9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.4/finnest-runtime-darwin-x64.tar.gz"
      sha256 "82fe2ea483746205eae22ee9d8df1b3bdeea68fbb6f9b18978a958b136af7ff1"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.4/finnest-runtime-linux-arm64.tar.gz"
      sha256 "593adc19c961a97ebb912d26cdac904694f1d78719c3e202479adf5de266d820"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.4/finnest-runtime-linux-amd64.tar.gz"
      sha256 "1e4815c9f48a9360bac780288578308aaacaab0707c1792b5ee0745e201bcc5f"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.4/finnest-darwin-arm64.gz"
      sha256 "377415d982ce02b3625758d39025481407302376caf0c13fd6dfdfa8fbb038db"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.4/finnest-darwin-x64.gz"
      sha256 "490b18d8a1198a3cfcfa40ab522949c961429687964c1df9d0ae0ddc1430db97"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.4/finnest-linux-arm64.gz"
      sha256 "8201204173a008f3304c541658f0fe410cfe2b6e161dc200433d82c2da10fa6a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.4/finnest-linux-amd64.gz"
      sha256 "f3e6a5335e54c6c726e5caf639ef22e36ff74a5cc78577faa320a21b86b3d02f"
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
