class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.46"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.46/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "b58027665bb4c1c051440501f6bb02362992310e21e5ab32fa35c8060cc4b5c3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.46/finnest-runtime-darwin-x64.tar.gz"
      sha256 "5eadd56fa6aa28937e850302363a62c713ff5848b39fb2541468e5fe54dd47a0"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.46/finnest-runtime-linux-arm64.tar.gz"
      sha256 "ef85ab0a27df051fb3e6a368a7b0b3db0f22d5488cdfd4859d2a902aeeb81547"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.46/finnest-runtime-linux-amd64.tar.gz"
      sha256 "dae71b0e04442178b04ccaec2beaaa302f0de2faebf920f81963b4a9ec6422ad"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.46/finnest-darwin-arm64.gz"
      sha256 "0cb7e6f0ef17238fa4151148b7281c90328b832dd3d5ee37233589eb62c0f11b"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.46/finnest-darwin-x64.gz"
      sha256 "11ba4575016e642e908e2ceb2288045b72713328534b3eeb7da4a66832c0487a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.46/finnest-linux-arm64.gz"
      sha256 "73ba3c34b5efbfd04741f058ef841b9b08109902342e5500f8424c11d50aed44"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.46/finnest-linux-amd64.gz"
      sha256 "f4df8bd2e6b7252d6f6c10cd0564856ec642e0a09fc28e8e8bc492fb3dd34412"
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
