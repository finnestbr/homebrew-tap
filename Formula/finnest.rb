class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.22.5"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.5/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "37a593ceaa2cd4180318c531d7ec04e8b18cc1a5892bc8bd886efd708802bb5b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.5/finnest-runtime-darwin-x64.tar.gz"
      sha256 "abf52d751216e1822bd5ff46b73c6af24b3171a356abdbdc222a32ca14feecd9"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.5/finnest-runtime-linux-arm64.tar.gz"
      sha256 "972f308bb6bb96877bddb743e8db6b3971de9f7a6b1f003bb3dc08186dcdd88d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.5/finnest-runtime-linux-amd64.tar.gz"
      sha256 "75ad42aed06ea2cb7a95b60ebb4eded99cd22dd7d6bcb23039e10e673e543484"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.5/finnest-darwin-arm64.gz"
      sha256 "a201bcc9fe421f6b19d86839d68ff669894d37597889f040c64f5efe1eaff532"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.5/finnest-darwin-x64.gz"
      sha256 "b11cd4a1f6d45b2a8993d3f683c39b2236c178a6aa9348e75eec2014cf97d542"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.5/finnest-linux-arm64.gz"
      sha256 "192ddf00046c61be32bc5373b979e661b4f6ea3ce15bc6293b80c3a7a2dc75f4"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.5/finnest-linux-amd64.gz"
      sha256 "c170db79f325daeaf549550ad34ac3c73e4f0125070e2cb63570a5a57f4e7d29"
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
