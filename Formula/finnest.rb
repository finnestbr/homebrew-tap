class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.15.9"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.9/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "9ed150eea2719f376e8a658d81ead37154e7578b61ca0c81f9c1ac2310545aa0"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.9/finnest-runtime-darwin-x64.tar.gz"
      sha256 "3035edb8fa20c8e8adf5fd8313649c0af100b179502d5da957769997bd581d1c"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.9/finnest-runtime-linux-arm64.tar.gz"
      sha256 "cb2773cb6f330e63e05cfd64f4b99e8de6086a949965d3dd3cbe9a609554fa05"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.9/finnest-runtime-linux-amd64.tar.gz"
      sha256 "7ae5d3b4e6eb6ba3d635dd187b9c0ad6ed9778576cf3fd6eec03338790a716d8"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.9/finnest-darwin-arm64.gz"
      sha256 "a52860fbc9b31ad4c6258b85e0f22aa91303ab875b63e4eef93a12a656ce5221"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.9/finnest-darwin-x64.gz"
      sha256 "05aa65c51a8d5f8cc8109a1d36e825c5c53fb1aa9f3112d1a0f53af7fbe10cff"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.9/finnest-linux-arm64.gz"
      sha256 "30f424dd7ad6d97cdfd31e9f4c19cd21b51edf5212ec9faa18e233d8001c6438"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.15.9/finnest-linux-amd64.gz"
      sha256 "86faf36abe5b6dd040007ea80b8be9af3d375a81a97a0ca45a35a72bda210a96"
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
