class Finnest < Formula
  desc "Finnest Customer CLI"
  homepage "https://finnest.com.br"
  version "0.8.37"
  license "UNLICENSED"

  resource "finnest-runtime" do
    on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.37/finnest-runtime-darwin-arm64.tar.gz"
      sha256 "d421e29ae4ff9de8f8cf3e962c7b6489bb941b24c5073e6933633053541f5bd3"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.37/finnest-runtime-darwin-x64.tar.gz"
      sha256 "dadeba18d63c843ace8d2657849031c0dfe60c7368a0e9e6a3cb71f099e7a479"
    end
    end
    on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.37/finnest-runtime-linux-arm64.tar.gz"
      sha256 "2618ecd66c99286854548580638e475961d02055d0932095ae29cdc804326ad7"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.37/finnest-runtime-linux-amd64.tar.gz"
      sha256 "d72d24125ef1c6bd028e38323bb78d81bbeeb5c62a64e370fb290fec0d4386dc"
    end
    end
  end

  on_macos do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.37/finnest-darwin-arm64.gz"
      sha256 "42cda4b96687e72117cee86054b75b0f39c0c3b9a51f5f52bdaadc587a654213"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.37/finnest-darwin-x64.gz"
      sha256 "d23710517aaaf3845384e9088b4539339a7155bf29d97fb1b7b048deea56fdd9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.37/finnest-linux-arm64.gz"
      sha256 "dd4709645ad339c019001677f185440e3a2a0d8420e83a509cb1998867428897"
    end
    on_intel do
      url "https://github.com/finnestbr/finnest-static/releases/download/cli-v0.8.37/finnest-linux-amd64.gz"
      sha256 "058dceded93d3be27f6e34e98254c109cfdc1698941f29a88ad832f3e6691cb5"
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
