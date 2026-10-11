class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.18.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "a46632c74fba2d0ebaed4ae82db98588a9024de9191002ebd9940f3747e77e77"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "e16f0ee6f46cf3b73171e60f10625977342a120fe7728f2358db1dd4107d20cb"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "a6b642a24506f49be1150c76a9424248bef55209811411d1461317886589a9ba"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "bfaa7ebf20c79c531449eae27f30fc4d07c9a17548e4beaf97977369c802012b"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.1/finnest-darwin-arm64.gz"
      sha256 "b5af272675933d090ffc0557ca2beb0ed59d822517bbf09a60886491dcfc04e9"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.1/finnest-darwin-x64.gz"
      sha256 "02cac625baa1852b7c4fff6099d6ad5eee6e7c6e6f10ebcd230d3397757e538d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.1/finnest-linux-arm64.gz"
      sha256 "71c9d0f83c14870b1b48802623356512c6ea1b5f7d1684788e4122eb15279ab1"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.18.1/finnest-linux-amd64.gz"
      sha256 "5b9aa35949ec9df27f459875b4546d5c42584a03887d37f76ab49d986d276d31"
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
