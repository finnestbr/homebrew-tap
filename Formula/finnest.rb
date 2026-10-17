class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.20.1"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.1/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "5c8e05380d9779ec4e483405e63d0a416ba8b125cf4dda5b9b1eb1b8f0fc3555"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.1/finnest-runtime-darwin-x64.tar.gz"
      sha256 "18065c7dc148a1ff87cc248c40b96e8691cae9836db4f3b73157084d58fd844b"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.1/finnest-runtime-linux-arm64.tar.gz"
      sha256 "8a7d3d0ad81d15794ebe19b219de416339bc01f2309e0ebe57f4e744fa3f0d69"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.1/finnest-runtime-linux-amd64.tar.gz"
      sha256 "6e8c57f153a653d9ae9c09c2981c96c5cb4b8c8d5b6a2fe8a2988aef3ddc0ad4"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.1/finnest-darwin-arm64.gz"
      sha256 "74dde81d9f0eb79b5955c752366a21072fdb86646af2f5a44d71dc3f707f910a"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.1/finnest-darwin-x64.gz"
      sha256 "3c5dc618f84d334a37b06dc4c29a423472035bd828baad3949a32ea6a65b5fd3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.1/finnest-linux-arm64.gz"
      sha256 "0a5775c1b85dbca4ca0d8c161104278077bb36579b0c8dee77d9c1c9ac9bc2d8"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.20.1/finnest-linux-amd64.gz"
      sha256 "d89e52b404122708cbb5b176891b86ba455a21dd2d0912f690c1b9ceb89fc1f7"
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
