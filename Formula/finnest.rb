class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.30"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.30/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "bee77546943e1efcdfd3ffcde80a0fe9c9bb4ed59ba795f0d0ab8467a5e0f226"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.30/finnest-runtime-darwin-x64.tar.gz"
      sha256 "c7037ccfbe6e5bada58cd3ec7c923fcedca1f09d12d3db2dcf0a048366a0a716"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.30/finnest-runtime-linux-arm64.tar.gz"
      sha256 "e15a57a5f0271a2a4c401df80d845d45dcba907987e991bb962365857c4ea033"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.30/finnest-runtime-linux-amd64.tar.gz"
      sha256 "63fad449c8bfd8832e3158a5870dfdff8a09801ec3ac42e93fdf53fc0c66264f"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.30/finnest-darwin-arm64.gz"
      sha256 "189fe690dc94053d07268dedd49d4b3e11e188c93cc5d02bf374c785b18cbc39"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.30/finnest-darwin-x64.gz"
      sha256 "5f4af31cb9bab27d33d278cca151c9049e5a6ca44fdbbfdc0c2198c0e8d73ccc"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.30/finnest-linux-arm64.gz"
      sha256 "702fbb0cc8a20c6fea9ef3beeedbf0324fcfe1b51189684339d0317fa6c2fd81"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.30/finnest-linux-amd64.gz"
      sha256 "692e988b4ed25b61f4670f39af825aef7821da512fcfcb06ffe068bf2d71fb13"
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
