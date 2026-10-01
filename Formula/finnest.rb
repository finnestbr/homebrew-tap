class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.10.2"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.2/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "fe75b6bcbf81f10aef4da33ab9d727894ad7ae9321ee015c847d857f5da79164"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.2/finnest-runtime-darwin-x64.tar.gz"
      sha256 "6a5d82575a1e9f9aec06ad4a19e546d8fd163949c6c5918dafe3c802709a2836"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.2/finnest-runtime-linux-arm64.tar.gz"
      sha256 "e29467cf3036a057221d457cfc5fb4bb46194a3feccc24956b8785f962d142f6"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.2/finnest-runtime-linux-amd64.tar.gz"
      sha256 "e3da0308b44f8677ef0b24580dc48255e2987079166b130e3671b259d1f7e97b"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.2/finnest-darwin-arm64.gz"
      sha256 "2d9bc590e8a5d88b509851ed7061953c986ff0ba4c3494a48b0fd23237a86428"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.2/finnest-darwin-x64.gz"
      sha256 "9ceabfd6d0c59395da3d781b66f625a07ca4975954dbb58b9843c6408455e3e7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.2/finnest-linux-arm64.gz"
      sha256 "50630d7b10759f510ce76e1629bebdb930a2f869c0bf73f74697f4dd46b459d9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.10.2/finnest-linux-amd64.gz"
      sha256 "716262e85790292adee6f2593bec1ac652ed004a85ce6d4248a473aa2d466d3d"
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
