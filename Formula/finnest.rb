class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.16.7"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.7/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "39919547fba0bc5d4856fb1190b4e38c3cc16c5a474126c42393a7f270ff5ad0"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.7/finnest-runtime-darwin-x64.tar.gz"
      sha256 "324c8307ea9dbf271d119de9e09d9fc24c8afa3999777ede78c7812fadd16243"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.7/finnest-runtime-linux-arm64.tar.gz"
      sha256 "7452833747239a9a29bf8ae06937c9e2e13b1f9277aeb9341338f741261dfb4f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.7/finnest-runtime-linux-amd64.tar.gz"
      sha256 "9ef40a9cf63803f2baedd5c9cee9a9c716272c2745b4e1cef99b9937af48af54"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.7/finnest-darwin-arm64.gz"
      sha256 "271e6230a3af3d65b3245354a5d75383d44fdbca00eda6d062603f757b0fad35"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.7/finnest-darwin-x64.gz"
      sha256 "8af699122f86b98468e6b7f9b48553266c8c5789a1bd05f4672f0c869398a35d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.7/finnest-linux-arm64.gz"
      sha256 "44ee881bb29b2e62be9c99649b4246cabc899bdef79f1486b8848df91fa6edb2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.16.7/finnest-linux-amd64.gz"
      sha256 "5b494a675f3548958f58255f2353d0f24351b9c7e876c764ac8afe224439a681"
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
