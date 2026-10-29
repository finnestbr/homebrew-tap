class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.28.5"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.5/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "f810d767f0144356e8d708ab235fcba5f4d81917576220a4d80ad1b8e5aa3a3d"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.5/finnest-runtime-darwin-x64.tar.gz"
      sha256 "8645518119c4f2ef6f102a4067516b6b7ccfc0e49d03163d5cb41a2df9b947a6"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.5/finnest-runtime-linux-arm64.tar.gz"
      sha256 "62d49617ef239df607d31890f0f0d6706fbf9140a94e50f4a69e92f3517ca139"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.5/finnest-runtime-linux-amd64.tar.gz"
      sha256 "a0f3430bf78f7059c31aa3404c00a18bca7d85fa90159527af187aca636d77d5"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.5/finnest-darwin-arm64.gz"
      sha256 "3f7cf7e1e21886ca21334efe8e54d46cc1e5410dcbd28e9fa07cf4514bf9072f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.5/finnest-darwin-x64.gz"
      sha256 "a53d627649541338cb013dc033ce6d1e9183424dece879ac236ee07d58d70ff2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.5/finnest-linux-arm64.gz"
      sha256 "b2c198d9f08d6587c6d37094c1ccd12227e546a239f0aec858e2a2a9a9485cee"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.28.5/finnest-linux-amd64.gz"
      sha256 "370e18f2ee190c3c8aef38ba42be5f922c94e43d264f19e56821cbbb387c7e2f"
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
