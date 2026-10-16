class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.19.37"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.37/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "1cd25128a96f207dacd1ebd71372a2489a731aa175e56d820a06ba0e36c56480"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.37/finnest-runtime-darwin-x64.tar.gz"
      sha256 "ee69538101fdf38b9e925723fd0a4242149b024485286aa004a16438d00a1127"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.37/finnest-runtime-linux-arm64.tar.gz"
      sha256 "19b509c76f2afca60054595a0ec4165c18d719b8993e7758a834118354e67add"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.37/finnest-runtime-linux-amd64.tar.gz"
      sha256 "6f984b6729c2d782e2a401980b5223f851f6ea741cdb3d11d999e2d7c8abc398"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.37/finnest-darwin-arm64.gz"
      sha256 "5eaf4a5547ed23329a6b24553720beae10deb70f229f2cf105140d75259f0d77"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.37/finnest-darwin-x64.gz"
      sha256 "f9a3a34d46229ae2ad1b2cf953092ef2828dbca476d1abed4149f20a1c9bf503"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.37/finnest-linux-arm64.gz"
      sha256 "02a8f65001ffbdb3ba112623177a5215d5673f00c21afecd2d023fec0fada114"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.19.37/finnest-linux-amd64.gz"
      sha256 "97c79b2f20cc78edf742556253980d52ff35ced1b8fb1501cda5cc800bcc5813"
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
