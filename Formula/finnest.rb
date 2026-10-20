class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.25.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "07feae1cca8e9fd52b43b4e2b5a641566796d5da6e87032b3be153d54e3cc32e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "f63408b727518bce063733b71a2799e1c13e8d81baf94d527e067b67cc2146e2"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "2c2cb6bc746b5e8f1fce158055e0ef494390a331e0f06460c4d148ae0591a922"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "e3448f0fed5550d3a030d93187ff40986a4b7959d1b0c0f2af55c2e2e51b2941"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.0/finnest-darwin-arm64.gz"
      sha256 "fd64f46556d61cea4b0ed8793e96acb846ed6c7d00a44fe583ab2e449d700e7e"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.0/finnest-darwin-x64.gz"
      sha256 "aed40dbbc7f481a43554eb5b98362e80d2e37a1cccaa1b3899e3c32e713d0e9b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.0/finnest-linux-arm64.gz"
      sha256 "90c9deafedfd48629c1586bab5d14e1364bb453c5c7185ffc678c87d0c14486a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.25.0/finnest-linux-amd64.gz"
      sha256 "c6c17a28dfff4b29f77bd80e0d4e558f331a495d3661bf25103dea59042d2285"
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
