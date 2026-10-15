class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.22"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.22/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "b6a728cbfaef58931aebfbe3a74d558b6f44cba84525156c8a79b4867f780329"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.22/finnest-runtime-darwin-x64.tar.gz"
      sha256 "f808c2c295ef9d37cb534146e7aa3e8d28b0b2182e0afaa56fde05635eaf1581"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.22/finnest-runtime-linux-arm64.tar.gz"
      sha256 "5240a793f4a32e9df423146f4aaee844d10a5681764a79cf187010a0126dddee"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.22/finnest-runtime-linux-amd64.tar.gz"
      sha256 "ba211880786ce8b4406b3ff81cfefbf205c7c04bf63176e5c2042841480b0e28"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.22/finnest-darwin-arm64.gz"
      sha256 "4003539b5dc2d14df56b6f8cccaf9fe8326d6947e63c1c5b706a8eb5a09a5a9b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.22/finnest-darwin-x64.gz"
      sha256 "3aa226c0d57c35aeff61395f547668485e47aa44be8182ce87dcc2fd43783cce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.22/finnest-linux-arm64.gz"
      sha256 "d8a02173ce5da14050bb15e0c92f5173052536faab4c2fef5e45652b92b4335c"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.22/finnest-linux-amd64.gz"
      sha256 "359469d4ddc0fa162beb1b60df602ddbbbcd7df73ec9a54e513cf34ac902ad8a"
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
