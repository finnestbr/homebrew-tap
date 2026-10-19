class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.22.0"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.0/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "da8e84d2703d5c0f125d17edf42120abcbca20bb36167206fe7dbeabfa38ecab"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.0/finnest-runtime-darwin-x64.tar.gz"
      sha256 "27e2a361246f6aa704d67fee262b15dd2592eaf10dc38c9b861093cad072ec4f"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.0/finnest-runtime-linux-arm64.tar.gz"
      sha256 "db48233ecacc380c22f79839c2ec821fe4c6254b9c0f6fcf88cc3be07f6224ac"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.0/finnest-runtime-linux-amd64.tar.gz"
      sha256 "87f9977098d92cd25343fac89b3dc6739c1d37271a2fd3527c2aa91622a60002"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.0/finnest-darwin-arm64.gz"
      sha256 "0ef4475f9dc9613dad358afaeaa4c99bd28e76c33e76b24bacde72555d30db58"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.0/finnest-darwin-x64.gz"
      sha256 "2f9b870d8e8f436ac09b4d143a12ffc220b624856bd5a050e356c125edab07ff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.0/finnest-linux-arm64.gz"
      sha256 "15d74d3e5a4fbb40bd47ee9be25fce93e6016c676ab3e015b2dab47b4b5ae99a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.22.0/finnest-linux-amd64.gz"
      sha256 "4e1ec2aefa8e8b6323322ed3b007a517fca4eb1fce30ea38aeb6b2f960f6547c"
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
