class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.15"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.15/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "b507c48ade09fdf1d964d650ff746eb22ab82a202e5a074f9b5ae8911fc598e1"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.15/finnest-runtime-darwin-x64.tar.gz"
      sha256 "1729f32956654f9f5646df12778bcab58d062bec4db013e5f0a13845c55db9e7"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.15/finnest-runtime-linux-arm64.tar.gz"
      sha256 "1a20e08aafc9ad761628a7bcc35139fa1d30b8174ffe6b486a86b2b9089d895f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.15/finnest-runtime-linux-amd64.tar.gz"
      sha256 "bd5ecc61bcc454c527f903a597bb3647c9a5c176165114d43367cfea6ab9a4e1"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.15/finnest-darwin-arm64.gz"
      sha256 "223de09e36a48e8163c7a43a289a1fe6d8abea63d6067c7aaf860d5a6a7af929"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.15/finnest-darwin-x64.gz"
      sha256 "79452212594f288905c62d5ef76c307058dfd2e7df24980c7048732fd9f317fd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.15/finnest-linux-arm64.gz"
      sha256 "3d8197ac3148b984f29e9dcd437eb0f2e5fd5f22baf4099f69d1962dc56302ed"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.15/finnest-linux-amd64.gz"
      sha256 "0a250fcd5005c5e71f4411afa27b8aa88a31bf86b86f5ba533c6fc4483a253bb"
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
