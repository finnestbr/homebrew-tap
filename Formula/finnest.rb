class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.23"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.23/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "bc09a7f4741a38a08089062ec160b1acf3f6b8f76ff9f259f62375f62b5c197d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.23/finnest-runtime-darwin-x64.tar.gz"
      sha256 "1179d8bd20d538b639602604a0144ea4482d564f598e4a612ce9aa0458ffb3c9"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.23/finnest-runtime-linux-arm64.tar.gz"
      sha256 "20368ef7e2c0599eb5e23cdfc7c8760469cb7ee3365b4f8af1f6a98069fcd41f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.23/finnest-runtime-linux-amd64.tar.gz"
      sha256 "21326437faaf18d84188b0eaa7cf065a76169f6a3c216126e053aaf9c6066c5a"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.23/finnest-darwin-arm64.gz"
      sha256 "016fb9feed9d6e116c4a50663e4c9101f6511bdde36a14a4f89b268d4b87430b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.23/finnest-darwin-x64.gz"
      sha256 "2ed44d096049e215683b999b8954254ea7ce883f18770daeebebef279b83be05"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.23/finnest-linux-arm64.gz"
      sha256 "9afb58114c8b304eca772cc40f5dd4d88b255ba1db14806760312bdd13c4d506"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.23/finnest-linux-amd64.gz"
      sha256 "b13ee7f1f529281d55bc857b6c8a97fb3012311d9c705e82747f9c0bea9ec8ec"
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
