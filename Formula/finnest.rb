class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.29.13"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.13/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "081bd5525c72447581860982d35661a499386b8c33f00494697f4f04a5b281d2"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.13/finnest-runtime-darwin-x64.tar.gz"
      sha256 "ecf69dfa18d8249a93688e9e3c7f22124482c6e2e43d5d9467180eb292ed55ea"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.13/finnest-runtime-linux-arm64.tar.gz"
      sha256 "cc0171d80d2b3989e5cf378281efc4f491a5897a223d3f9a8e2c34820a11d48f"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.13/finnest-runtime-linux-amd64.tar.gz"
      sha256 "d942b452bef51337a7bfd8fc0726840104e9a5aab1e4b213ac70721be09b551b"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.13/finnest-darwin-arm64.gz"
      sha256 "7e5bf8c2b0b68ae63f5a68a0497bb45b593a7214e6d3c23be8254ee09cdff279"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.13/finnest-darwin-x64.gz"
      sha256 "8b36520461f0660197693ec5ecc5ff9e38249f47e947bea4b296aa1809f0c9be"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.13/finnest-linux-arm64.gz"
      sha256 "01e1d1170347ed440df6f6d0750fecd2f3c1ae9655f79c7e7f83a827a684fc34"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.29.13/finnest-linux-amd64.gz"
      sha256 "6f11e9c6b45df051bbc82ec6d5dddf9862639493250ff0687010078e2b94a165"
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
